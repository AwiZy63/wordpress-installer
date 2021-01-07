#!/bin/bash

function get_language() {
	if [[ $LANG == "fr_FR.UTF-8" ]]; then
		lang="fr"
	else
		lang="en"
	fi
}

