#!/bin/bash

die_func() {
        echo "Bye!"
        exit 0
}
trap die_func TERM

touch /etc/vsftpd/chroot_list

userList=`cat /root/users.list`

for userLine in $userList
do
    userName=( ${userLine%%:*} )
    userPass=( ${userLine#*:})

    echo "Adding user $userName"
    groupadd "$userName"
    useradd -m -d "/home/$userName" -s /usr/sbin/nologin -g "$userName" "$userName"
    
    mkdir -p "/app/ftp/$userName"
    chown -R "$userName:$userName" "/app/ftp/$userName"

    echo "$userName" >> /etc/vsftpd/user_list

    if [ "$userPass" == "--" ]
    then
            userPass="$(uuid)"
            echo "Generated password for $userName: $userPass"
    fi

    echo "Changing password for user $userName"
    echo "$userName:$userPass" | chpasswd

done

echo "Starting vsftpd"
vsftpd /etc/vsftpd/vsftpd.conf