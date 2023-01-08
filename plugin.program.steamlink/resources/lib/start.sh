#!/bin/bash
# Run the launcher script as a "service"
# in order for the script to survive kodi shutdown
# Need to give kodi user the matching sudo right

DIRNAME=$( dirname "${BASH_SOURCE[0]}" )
sudo systemd-run "${DIRNAME}/launcher.sh"
