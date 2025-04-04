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
# Install Lefthook
dnf install lefthook -y; \
# Install python for Semgrep & mkdocs 
dnf install python3 python3-pip -y; \
python3 -m pip install semgrep mkdocs; \
# Install trivy package
dnf install trivy -y; \
# Clean package cache
dnf clean all