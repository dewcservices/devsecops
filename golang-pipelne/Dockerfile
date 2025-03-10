FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf update -y; \
# Install git, nano & golang
dnf install git nano golang -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
rm -rf /var/cache

# OPTIONAL DEPLOYMENT EXAMPLE:
#-----------------------------
## Make App folder, copy project into container
# WORKDIR /app
# COPY . .

## Install project requirements, build project
# RUN go mod download 
# RUN go build -o /app/run

## Expose port and run app
# EXPOSE 8080
# CMD [ /app/run ]