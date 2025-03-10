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

# Install project 
# RUN poetry add ./projectName

# Run project 
# ENTRYPOINT [ "poetry", "run", "gunicorn", "projectname" ]