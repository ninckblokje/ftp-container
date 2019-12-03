# ftp-container

A Linux container running `vsftd`. The file [vsftpd.conf](vsftpd.conf) contains a sample configuration (copied to Docker image `/etc/vsftpd.conf`).

The file [users.list](users.list) contains a list of users to be created by the container. Format: `USERNAME:PASSWORD` or `USERNAME:--` for a generated password.

Configuration documentation can be found here: https://linux.die.net/man/5/vsftpd.conf

Run container (with current settings): `docker run -p 20-21:20-21 -p 65500-65515:65500-65515 ninckblokje/ftp-container:latest`