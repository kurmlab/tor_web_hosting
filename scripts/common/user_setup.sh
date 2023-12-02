#!/bin/bash
### every exit != 0 fails the script

create_sudo_user(){
    # RUN addgroup -S app && adduser -S app -G app
    useradd -m $1
    usermod -a -G sudo $1
    # Allow the user to use sudo without a password
    echo "$1 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    chsh -s /bin/bash $1
}

set_rwx_perm_2_user(){
    chown -R $2:$2 $1 && chmod -R u+rwX,g+rX,o-rwx $1
}


create_sudo_user $1
