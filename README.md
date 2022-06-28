# Crypto lab 1
###### tags: `crypto` `Homework`

## Exercise 1
![](https://i.imgur.com/VKzFKfy.png)


1. Get modulus from public key:

`openssl x509 -in cacertificate.pem -noout --modulus`

2. Convert it to base10
`echo "ibase=16;E649D57F6FF9CFF655CB79EE38380C8F8278EB374A90059B0FF06534829D337C753D0E59AFED6FA489F015CF33" | bc` 
`2112664634855999140031945945998785346946804826144846396410436155861557104011009549879696604291518474904522547`
4. Use msieve to factor the modulus

`msieve 0xE649D57F6FF9CFF655CB79EE38380C8F8278EB374A90059B0FF06534829D337C753D0E59AFED6FA489F015CF33`

5. calculate d

$\phi = (p-1)(q-1)$
$e = 65537$
$d = e^{-1} \mod{\phi}$

6. Key params:

$p= 1524938362073628791222322453937223798227099080053904149$
$q= 1385409854850246784644682622624349784560468558795524903$
$e= 65537$
$d= 585377376205045827301220782663105468898592075285171211065018186416365699827074434761795565062334913589643145$
$n= 2112664634855999140031945945998785346946804826144846396410436155861557104011009549879696604291518474904522547$

6. Create the key in ASN.1 file format, for example using rsatool
`rsatool -p 1385409854850246784644682622624349784560468558795524903 -q 1524938362073628791222322453937223798227099080053904149`

## Exercise 2
![](https://i.imgur.com/4yeFses.png)

1. What properties does H need in order for this construction to be secure?
    1. H should be hard to invert, 
    2. H should not admit multiplicative relations, ie. it's hard to find messages $m,m_1,m_2$ such that $H(m)=H(m_1)*H(m_2) \mod{N}$
    3. **H should be collision resistant**

**MD5 is not collision resistant, but it is resistant to preimage and 2nd preimage attacks!**
if $H(m_1)=H(m_2)$ then $m_1$ and $m_2$ will obviously have the same signature!
2. MD5 is vulnerable to chosen prefix collision, which means that it's possible to create 2 files such that:
$$H(P_1 | S_1) = H(P_2 | S_2)$$
where $P_1,P_2$ are plaintext prefixes and $S_1,S_2$ are calculated binary values.

3. as $P_1$ use the original `grade.txt` file, and as $P_2$ use modified `grade_mod.txt` file. Calculate $S_1,S_2$ using a tool such as `hashclash`:

`../scripts/cpc.sh ../../grade_mod.txt ../../grade.txt`

4. check that md5 hashes of both files are the same:
`md5sum grade.txt.coll grade_mod.txt.coll` 

```
0aaf1172ed984c5364782937c361f181  grade.txt.coll
0aaf1172ed984c5364782937c361f181  grade_mod.txt.coll
```

5. first three lines of `grade.txt.coll` are the same as `grade.txt`, if we somehow got the signer to sign the file (because the first three lines are correct), then we can use the following signature to verify `grade_mod.txt.coll` file as well, achieving a succesfull forgery
