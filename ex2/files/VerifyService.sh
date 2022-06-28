#!/bin/sh
openssl dgst -md5 -verify <(openssl x509 -in cacertSec.pem -pubkey -noout) -signature $1 $2
