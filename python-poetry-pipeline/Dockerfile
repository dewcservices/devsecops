FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf update -y; \
# Install git, nano, python 
dnf install git nano python3 -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
rm -rf /var/cache

# install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Install Trivy 
# Might need to comment out if devcontainer issues
RUN <<EOF cat >> /etc/yum.repos.d/trivy.repo
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF
RUN dnf update -y; dnf install trivy -y; rm -rf /var/cache

# OPTIONAL DEPLOYMENT EXAMPLE:
#-----------------------------
## Make App folder, copy project into container
# WORKDIR /app
# COPY . .

## Install project requirements, build project
# RUN poetry add .

## Expose port and run app
# EXPOSE 8080
# ENTRYPOINT [ "poetry", "run", "gunicorn", "projectname" ]
