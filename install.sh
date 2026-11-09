#!/bin/sh
# Copies this repo's config into ~/.config. Existing files are backed up first. Safe to rerun.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
cfg=${XDG_CONFIG_HOME:-$HOME/.config}
ts=$(date +%Y%m%d-%H%M%S)

put() { # put <src> <dst>
  mkdir -p "$(dirname "$2")"
  if [ -f "$2" ] && ! sed "s#__HOME__#$HOME#g" "$1" | cmp -s - "$2"; then cp "$2" "$2.bak-$ts"; fi
  sed "s#__HOME__#$HOME#g" "$1" > "$2"
}

for f in config.toml config-gpui.local.toml; do put "$here/herdr/$f" "$cfg/herdr/$f"; done
put "$here/herdr/plugins/herdr-pomodoro.config" "$cfg/herdr/plugins/config/herdr-pomodoro/config"
put "$here/herdr/plugins/persiyanov.reviewr.config.toml" "$cfg/herdr/plugins/config/persiyanov.reviewr/config.toml"
put "$here/herdr/plugins/sazardev.pomodoro.config.toml" "$cfg/herdr/plugins/config/sazardev.pomodoro/config.toml"
for f in keys.json settings.json herdr-t3-keep-mods.sh; do put "$here/herdr-app/$f" "$cfg/herdr-app/$f"; done
for f in "$here"/herdr-app/layouts/* "$here"/herdr-app/themes/*; do
  rel=${f#"$here"/herdr-app/}; put "$f" "$cfg/herdr-app/$rel"
done
echo "installed to $cfg (backups: *.bak-$ts)"
