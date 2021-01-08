#!/bin/bash

function get_language() {
	if [ $LANG == "fr_FR.UTF-8" ] || [ $LANGUAGE == "fr" ]; then
		lang="fr"
	else
		lang="en"
	fi
}

