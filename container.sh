#!/bin/bash

die_func() {
        echo "Bye!"
        exit 0
}
trap die_func TERM

userList=`cat /root/users.list`

for userLine in $userList
do
    userName=( ${userLine%%:*} )
    userPass=( ${userLine#*:})

    echo "Adding user $userName"
    useradd -m -d /app/ftp/$userName -s /usr/sbin/nologin $userName

    if [ "$userPass" == "--" ]
    then
            userPass="$(uuid)"
            echo "Generated password for $userName: $userPass"
    fi

    echo "Changing password for user $userName"
    echo "$userName:$userPass" | chpasswd

done

echo "Starting vsftpd"
vsftpd /etc/vsftpd.conf