#!/bin/bash

set -e

chmod +x pam_duo_setup.sh pam_keys.sh
/bin/bash pam_keys.sh
/bin/bash pam_duo_setup.sh

cp /lib64/security/pam_duo.so /out
cp /etc/duo/* /duo