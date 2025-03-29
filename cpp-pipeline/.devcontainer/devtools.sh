#!/bin/bash
set -e

# Install Trivy repo
<<EOF cat >> /etc/yum.repos.d/trivy.repo
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF

# Install Lefthook repo
curl -1sLf 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.rpm.sh' | bash

dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# isntall Lefthook
dnf install lefthook -y
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# Install trivy package
dnf install trivy -y; \
# Clean package cache
dnf clean all