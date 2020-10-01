#!/bin/bash
jack_control start
jack_control ds alsa
jack_control dps device hw:MKII
jack_control dps capture hw:Microphone
jack_control dps playback hw:MKII
jack_control dps rate 44100
jack_control dps nperiods 3
jack_control dps period 512
sleep 2
qjackctl -platform wayland &
