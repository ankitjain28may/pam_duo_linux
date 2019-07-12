#!/bin/bash

sed -i -e "s/ikey =/ikey = $IKEY/" /etc/duo/pam_duo.conf
sed -i -e "s/skey =/skey = $SKEY/" /etc/duo/pam_duo.conf
sed -i -e "s/host =/host = $HOST/" /etc/duo/pam_duo.conf