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
# Install python for Semgrep, Install gnupg2 for GPG pass-through
# For ssh git support, uncomment `AllowAgentForwarding yes` in /etc/ssh/sshd_config on your host 
dnf install python3 python3-pip gnupg2 -y; \
# Optional: mkdocs
python3 -m pip install semgrep; \
# Install trivy package
dnf install trivy -y; \
# Clean package cache
dnf clean all