#!/bin/bash
set -e

# Install Trivy 
<<EOF cat >> /etc/yum.repos.d/trivy.repo
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF

dnf -y update-minimal --security --sec-severity=Important --sec-severity=Critical && \
# Install nodejs for SonarQube 
dnf install nodejs -y; \
# Install trivy package
dnf install trivy -y; \
# Clean package cache
dnf clean all