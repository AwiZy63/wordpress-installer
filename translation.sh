#!/bin/bash

source ./get_language.sh

get_language

if [[ $lang == "fr" ]]; then
	scriptTitle="Bienvenue sur le script d'installation wordpress"
else
	scriptTitle="Welcome to the wordpress installation script"
fi
