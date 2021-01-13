#!/bin/bash

if [[ -e ./functions/ ]]; then
    source ./functions/wpi_translation.sh
    source ./functions/wpi_functions.sh
    source ./functions/wpi_dependencies.sh
    source ./functions/wpi_createdatabase.sh
    source ./functions/wpi_colors.sh
    source ./functions/wpi_webconfiguration.sh
    source ./functions/wpi_wordpressinstallation.sh
else
    source ./wpi_translation.sh
    source ./wpi_functions.sh
    source ./wpi_dependencies.sh
    source ./wpi_createdatabase.sh
    source ./wpi_colors.sh
    source ./wpi_webconfiguration.sh
    source ./wpi_wordpressinstallation.sh
fi
