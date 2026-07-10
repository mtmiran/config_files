#!/bin/bash

volume_step=5

while true; do
	volume=$(amixer -D pulse sget Master | grep -o -m 1 '[0-9]\+%')
	volume="${volume%\%}"

	if [ "$volume" -ge 0 ]; then
		xsetroot -name "Vol: $volume%"
	fi

	sleep 2
done
