#!/bin/bash
jack_control start
jack_control ds alsa
jack_control dps device hw:MKII
jack_control dps rate 44100
jack_control dps nperiods 3 # 2 for MoBo/PCI, 3 for USB
jack_control dps period 512
sleep 10
qjackctl -platform wayland &
