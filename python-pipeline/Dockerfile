FROM registry.access.redhat.com/ubi9/ubi:latest

COPY .python-version .python-version

RUN dnf update -y; \
# Install git, nano & Python
dnf install git nano python$(cat .python-version) python$(cat .python-version)-pip -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
rm -rf /var/cache

# Symlink pip(VERSION) to pip3
RUN ln -s /usr/bin/pip$(cat .python-version) /usr/bin/pip3

# Install Trivy 
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
# RUN pip3 install --include-deps .[test,dev]

## Expose port and run app
# EXPOSE 8080

# for uvicorn (FastAPI)
# ENTRYPOINT [ "fastapi", "run", "src/python_template/main.py", "--port", "8080", "--workers", "4" "--host", "0.0.0.0"]

# for gunicorn (Flask)
# CMD [ "GUNICORN_CMD_ARGS='--bind=0.0.0.0:8080 --workers=8'","--frozen", "gunicorn", "'src/python_template/main.py'" ]
