#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
neofetch --ascii "$DIR/ascii_distro_art" --config "$DIR/config_file.conf"
