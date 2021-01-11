#!/bin/bash

source wpi_colors.sh

function welcome() {
    clear
    echo -e "${normal}"
    echo "=| $scriptTitle |="
    sleep 2
}

function confirmation_form() {
    echo
    read -n 1 -p "$confirmation_message_question" confirmForm

    case $confirmForm in
    [yY][eE][sS] | [yY] | [oO][uU][iI] | [oO])
        echo
        echo "$confirmation"
        echo
        sleep 1
        confirmForm=true
        ;;
    *)
        confirmForm=false
        ;;
    esac
}
