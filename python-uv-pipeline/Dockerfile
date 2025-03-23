FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf update -y; \
# Install git, nano
dnf install git nano  -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
rm -rf /var/cache

# Install uv, latest python and ruff 
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN source $HOME/.local/bin/env && uv python install
ENV PYTHONUNBUFFERED=1
RUN source $HOME/.local/bin/env && uv tool install ruff@latest

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
# RUN source $HOME/.local/bin/env && uv pip install .  

## Expose port and run app
# EXPOSE 8080

# for uvicorn (FastAPI)
# ENTRYPOINT [ "uv", "run", "fastapi", "run", "src/python_template/main.py", "--port", "8080", "--workers", "4" "--host", "0.0.0.0"]

# for gunicorn (Flask)
# CMD [ "GUNICORN_CMD_ARGS='--bind=0.0.0.0:8080 --workers=8'", "uv", "run", "--frozen", "gunicorn", "'src/python_template/main.py:gunicorn()'" ]
