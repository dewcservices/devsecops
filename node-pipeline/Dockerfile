FROM registry.access.redhat.com/ubi9/ubi:latest

RUN dnf update -y; \
# Install git & nano 
dnf install git nano -y; \
# clear cache
rm -rf /var/cache

# Install nvm
WORKDIR /root
ADD https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh /root/
RUN chmod +x /root/install.sh && /root/install.sh
RUN export NVM_DIR="$HOME/.nvm"; \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; \ 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
nvm install 23

# Build package 
#WORKDIR ./projectName 
#ng build --watch

# Run package 
#npm install lite-server --save-dev
#ENTRYPOINT [ "lite-server", "--baseDir='dist/projectName' ]"