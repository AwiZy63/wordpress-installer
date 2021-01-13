#!/bin/bash

function wpi_language() {
	if [[ $LANG == "fr_FR.UTF-8" ]] || [[ $LANGUAGE == "fr" ]]; then
		lang="fr"
	else
		lang="en"
	fi
}