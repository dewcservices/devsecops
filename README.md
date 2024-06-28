# DevSecOps Pipelines

This repository includes several [Github Action](https://github.com/features/actions) pipelines for different. So far, these are:

- Java with Gradle
- Java with Maven
- Node.js
- Python with `requirements.txt`
- Python with [poetry](https://python-poetry.org/)

## Requirements

For the pipelines to run properly, you will need a [Dockerhub](https://hub.docker.com/) account and a [Sonarcloud](https://sonarcloud.io/login) account. These are both free and can be integrated for free within public Github repositories.

### Dockerhub (Skip if using Private repo)

> **IMPORTANT**: Skip this step if you are using a private Github Repository (The pipelines will push to Github container repository instead)

After setting up your Dockerhub account, create a new access token so that your Github repository has permission to pull and push images. You will have to create one for each repo you make.

You should be able to find this section at https://hub.docker.com/settings/security once you've logged in.

Create the new access token and copy it to your clipboard. Go to your repository's **Settings**, click **Secrets and variables**, then **Actions**. Create a new repository secret named **DOCKERHUB_TOKEN** with the access token as the value.

Similarly, create a new secret named **DOCKERHUB_USERNAME** and set it to your username.

### Sonarcloud

> **IMPORTANT**: Skip this step if you are using a private Github Repository without a paid version of Sonarcloud

After creating a new Sonar cloud account, follow the [Sonarcloud docs](https://docs.sonarsource.com/sonarcloud/getting-started/github/#set-up-your-analysis) to:

- connect your Github Organisation (your account in this case) to Sonarcloud
- [Import your repository](https://docs.sonarsource.com/sonarcloud/getting-started/github/#import-repositories)

Next, disable automatic analysis by going to your Sonarcloud project's **Administration** > **Analysis Method** page and turn automatic analysis **Off**.

> **Note**: The pipelines will fail if automatic analysis is enabled

Finally, on SonarCloud, go to **My account > Security > Generate Tokens** and generate a fresh token. Copy it and createa new secret in your Github Repository named **SONAR_TOKEN** with this token as the value.

### Dockerfile

The pipelines expect to build, test, and push an image. Make sure there is a valid Dockerfile at the root of your project directory. 

### Gitleaks

If you are using the pipelines within an organisation's repository rather than your own repository you will need an Organization License Key. These are free to make and can be done so here: https://gitleaks.io/products.html

Create a Github Repository secret named **GITLEAKS_TOKEN** with the value of the token.

## How to

### Including the pipeline in your repo
All the pipelines are set up similarly. Simply copy the `.github/` folder for the respective project type into your repository. Then fill out all the empty `env` variables in the file within the `workflows/` folder.


### Commit Format
The commit messages **MUST** be a [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/), since the commit types are used to determine how the version number is incremented. Failure to do so will break the pipeline

The pipelines uses your commit messages to determine the [semantic version](https://semver.org/) number of your build and image when you do a push to main (also triggerred when a merge request is accepted and goes through). It iterates through all commits in the push and:

- Defaults to no version change
- If a `fix:` is found, the patch version is bumped. E.g. `v1.0.2 --> v1.0.3`
- If a `feat:` is found, the mintor version is bumped. E.g. `v1.0.2 --> v1.1.0`
- If `BREAKING CHANGE` is found in the footer for any commit, regardless of type, the major version is incremented. E.g. `v1.0.2 --> v2.0.0`

This means pushes that have only commit types like `test:` and `chore:` won't increase the version number unless `BREAKING CHANGE` is included.