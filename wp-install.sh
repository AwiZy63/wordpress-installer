#!/bin/bash

# Delete everything in terminal before start script
clear

# Chargement du fichier de traduction
source ./wpi_functions_call.sh

welcome

# Vérification et installation des dépendances
depends_verify

# Création de base de données
create_database