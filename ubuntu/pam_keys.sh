#!/bin/bash

sed -i -e "s/ikey =/ikey = $IKEY/" /tmp/etc/duo/pam_duo.conf
sed -i -e "s/skey =/skey = $SKEY/" /tmp/etc/duo/pam_duo.conf
sed -i -e "s/host =/host = $HOST/" /tmp/etc/duo/pam_duo.conf
