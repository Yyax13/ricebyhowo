chmod +x "$HOME/.nfetch/nfetch.sh"
grep -qxF "alias nfetch=\"$HOME/.nfetch/nfetch.sh\"" "$HOME/.bashrc" || \
echo "alias nfetch=\"$HOME/.nfetch/nfetch.sh\"" >> "$HOME/.bashrc"

source $HOME/.bashrc