#!/bin/sh

KEYDIR=/home/antony/efisb-keys
PRIVKEY="pkcs11:object=Antony%20Vennard%20Whiteprophet%20Secureboot%20Signing%20Key%202016"
PUBKEY=$KEYDIR/whiteprophet_db.cer
# SIGN_CMD=/usr/src/kernels/$(uname -r)/scripts/sign-file 
SIGN_CMD=/root/sign-file 
export OPENSSL_CONF=/root/uefisb/openssl.cnf

echo "OpenSSL Config file should be $OPENSSL_CONF"

rm -rf /root/signmodules
mkdir /root/signmodules
pushd /root/signmodules

cp /lib/modules/$(uname -r)/extra/wl/wl.ko .
cp /lib/modules/$(uname -r)/misc/vmmon.ko .
cp /lib/modules/$(uname -r)/misc/vmnet.ko .

$SIGN_CMD sha256 $PRIVKEY $PUBKEY wl.ko
$SIGN_CMD sha256 $PRIVKEY $PUBKEY vmmon.ko
$SIGN_CMD sha256 $PRIVKEY $PUBKEY vmnet.ko

cp -f wl.ko /lib/modules/$(uname -r)/extra/wl/wl.ko
cp -f vmmon.ko /lib/modules/$(uname -r)/misc/vmmon.ko
cp -f vmnet.ko /lib/modules/$(uname -r)/misc/vmnet.ko

popd
