#!/bin/bash

sed -i -e "s/PubkeyAuthentication no/#PubkeyAuthentication no/" /etc/ssh/sshd_config
sed -i -e "s/PubkeyAuthentication yes/#PubkeyAuthentication yes/" /etc/ssh/sshd_config
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

sed -i -e "s/PasswordAuthentication no/#PasswordAuthentication no/" /etc/ssh/sshd_config
sed -i -e "s/PasswordAuthentication yes/#PasswordAuthentication yes/" /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

sed -i -e "s/UsePAM no/#UsePAM no/" /etc/ssh/sshd_config
sed -i -e "s/UsePAM yes/#UsePAM yes/" /etc/ssh/sshd_config
echo "UsePAM yes" >> /etc/ssh/sshd_config

sed -i -e "s/ChallengeResponseAuthentication no/#ChallengeResponseAuthentication no/" /etc/ssh/sshd_config
sed -i -e "s/ChallengeResponseAuthentication yes/#ChallengeResponseAuthentication yes/" /etc/ssh/sshd_config
echo "ChallengeResponseAuthentication yes" >> /etc/ssh/sshd_config

sed -i -e "s/UseDNS no/#UseDNS no/" /etc/ssh/sshd_config
sed -i -e "s/UseDNS yes/#UseDNS yes/" /etc/ssh/sshd_config
echo "UseDNS no" >> /etc/ssh/sshd_config;

echo "AuthenticationMethods publickey,keyboard-interactive" >> /etc/ssh/sshd_config;


sed -i -e "s%@include common-auth%#@include common-auth\n auth  [success=1 default=ignore] /lib64/security/pam_duo.so\n auth  requisite pam_deny.so\n auth  required pam_permit.so%" /etc/pam.d/sshd

rm -rf /etc/pam.d/common-auth
cp common-auth /etc/pam.d/common-auth
