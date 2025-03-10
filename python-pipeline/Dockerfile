FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf update -y; \
# Install git, nano & Python
dnf install git nano python3 python3-pip -y; \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# clear cache
rm -rf /var/cache

# Install project 
# RUN pip3 install ./projectName/  

# Run project 
# ENTRYPOINT [ "gunicorn", "projectname" ]