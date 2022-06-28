#!/bin/bash
openssl dgst -md5 -sign $1 -out $2 $3
