#!/bin/bash

function install_dependencies(){
    sudo apt update
    sudo apt -y install cryptsetup initramfs-tools yubikey-personalization
}

function install_file(){
    echo "Install $1 at $2 with permissions $3"
    sudo cp $1 $2
    sudo chown root:root $2
    sudo chmod $3 $2
}

function install_files(){
    install_file key-script /usr/share/yubikey-luks/ykluks-keyscript '755'
    install_file yubikey-luks-open /usr/bin/yubikey-luks-open '755'
    install_file yubikey-luks-enroll /usr/bin/yubikey-luks-enroll '755'
    install_file ykluks.cfg /etc/ykluks.cfg '644'
}

function update_ramfs(){
    sudo update-initramfs -u
}

install_dependencies
install_files
