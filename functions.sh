#!/bin/bash

function confirmation_form() {
    echo
    read -p "$confirmation_message_question" confirmForm

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
