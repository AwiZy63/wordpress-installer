#!/bin/bash

if [[ -e ./functions/ ]]; then
    source ./functions/wpi_colors.sh
    source ./functions/wpi_translation.sh
else
    source ./wpi_colors.sh
    source ./wpi_translation.sh
fi

function welcome() {
    clear
    echo -e "${normal}"
    echo "=| $scriptTitle |="
    echo
    sleep 2
}

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
