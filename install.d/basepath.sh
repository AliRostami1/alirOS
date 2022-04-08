#! /bin/sh

C_PATH=$(dirname "$0")            # relative
C_PATH=$(cd "$C_PATH" && pwd)    # absolutized and normalized
if [[ -z "$C_PATH" ]] ; then
	# error; for some reason, the path is not accessible
	# to the script (e.g. permissions re-evaled after suid)
	exit 1  # fail
fi

printf $(dirname ${C_PATH})