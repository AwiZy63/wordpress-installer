#!/bin/bash

# Delete everything in terminal before start script
clear

# Chargement du fichier de traduction
source ./translation.sh
source ./functions.sh
source ./get_dependencies.sh
source ./colors.sh

welcome

# Vérification et installation des dépendances
depends_verify