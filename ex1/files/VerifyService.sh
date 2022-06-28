#!/bin/sh
openssl dgst -md5 -verify <(openssl x509 -in cacertificate.pem -pubkey -noout) -signature $1 $2 
