if [ -z "$XDG_CURRENT_DESKTOP" ] && [ -z "$DESKTOP_SESSION" ] && [ -z "$GDMSESSION" ]; then
  echo "No Desktop Environment (DE) detected."
  exit 0
fi

stow alacritty

cargo install alacritty --locked

echo "postbuild(alacritty)"
# Alacritty desktop dependencies
assets=(
	extra/linux/Alacritty.desktop
	extra/logo/alacritty-term.svg
	extra/man/alacritty.1.scd
	extra/man/alacritty-msg.1.scd
	extra/man/alacritty.5.scd
	extra/man/alacritty-bindings.5.scd
	extra/alacritty.info
)
mkdir -p /tmp/extra/{man,linux,logo}
for item in "${assets[@]}"; do
	curl -sfL https://raw.githubusercontent.com/alacritty/alacritty/refs/heads/master/$item > /tmp/$item
done
# Terminfo
if ! infocmp alacritty > /dev/null 2>&1; then
	sudo tic -xe alacritty,alacritty-direct /tmp/extra/alacritty.info
fi
# Desktop Entry
install -Dm 644 /tmp/extra/logo/alacritty-term.svg $XDG_DATA_HOME/icons/Alacritty.svg
install -Dm 755 /tmp/extra/linux/Alacritty.desktop $XDG_DATA_HOME/applications/
update-desktop-database $XDG_DATA_HOME/applications/
# Manual Page
mkdir -p $XDG_DATA_HOME/man/{man1,man5}
scdoc < /tmp/extra/man/alacritty.1.scd | gzip -c | sudo tee $XDG_DATA_HOME/man/man1/alacritty.1.gz > /dev/null
scdoc < /tmp/extra/man/alacritty-msg.1.scd | gzip -c | sudo tee $XDG_DATA_HOME/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < /tmp/extra/man/alacritty.5.scd | gzip -c | sudo tee $XDG_DATA_HOME/man/man5/alacritty.5.gz > /dev/null
scdoc < /tmp/extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee $XDG_DATA_HOME/man/man5/alacritty-bindings.5.gz > /dev/null

