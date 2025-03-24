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
ENV PYTHONUNBUFFERED=1


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
# RUN poetry python install $(cat .python-version)
# RUN poetry install

## Expose port and run app
# EXPOSE 8080
# ENTRYPOINT [ "poetry", "run", "fastapi", "run", "src/python_template/main.py", "--port", "8080", "--workers", "4" "--host", "0.0.0.0"]

# for gunicorn (Flask)
# CMD [ "GUNICORN_CMD_ARGS='--bind=0.0.0.0:8080 --workers=8'", "poetry", "run", "--frozen", "gunicorn", "'src/python_template/main.py'" ]
