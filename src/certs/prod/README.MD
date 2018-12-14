### NEVER CHECKIN ANY CERTS INTO THE GIT REPOSITORY
* Server Certs

Ensure server certs are copied into this folder as per the following naming convention 
```
"ssl_cert_for_<server full name>.zip"
```

Example:

```
$ ls -1 ssl_cert_for*
ssl_cert_for_x01grioapp1a.vsi.sgp.mydomain.com.zip
ssl_cert_for_x01grioapp2a.vsi.sgp.mydomain.com.zip
ssl_cert_for_x01grioapp3a.vsi.sgp.mydomain.com.zip
.....
````

* CA Certs

Ensure server CA certs are copied into this folder as zip files as per the following naming convention 
```
"DBSBank-CA_<server full name>.zip"
```

Example:

```
$ ls -1d DBSBank-CA_*
DBSBank-CA_x01grioapp1a.vsi.sgp.mydomain.com.zip
DBSBank-CA_x01grioapp2a.vsi.sgp.mydomain.com.zip
DBSBank-CA_x01grioapp3a.vsi.sgp.mydomain.com.zip
.....
````