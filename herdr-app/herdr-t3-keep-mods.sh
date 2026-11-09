#!/bin/sh
# Puts main-routing's panels and floats back into layouts/herdr-t3.json, so herdr-t3 hides none of the mods main-routing shows.
# Run it after every herdr-t3 `scripts/update.sh`, which rewrites the layout from the repo. Safe to run twice.
set -eu
app=${HERDR_APP_HOME:-$HOME/.config/herdr-app}
src="$app/layouts/main-routing.json"
dst="$app/layouts/herdr-t3.json"
command -v jq >/dev/null || { echo "needs jq" >&2; exit 1; }
jq empty "$src" "$dst"

jq --slurpfile from "$src" '
  ($from[0] | [.. | objects | select(.id? == "panel")][0]) as $panel
  | ($from[0] | [.. | objects | select(.id? == "skillshare-panel")][0]) as $skill
  | ($from[0] | [.. | objects | select(.id? == "work-body")][0].floating) as $floating
  | def drop(ids): map(select((.id as $i | ids | index($i)) | not));
    (.. | objects | select(.id? == "tabs-row") | .children) |= (drop(["panels"]) | .[0:2] + [{
      "id": "panels", "type": "block", "size": {"px": 232}, "window_drag": true, "content": {"mod": "panel-bar"}
    }] + .[2:])
  | (.. | objects | select(.id? == "work-body") | .children) |= (drop(["panel", "skillshare-panel"]) + [$panel, $skill])
  | (.. | objects | select(.id? == "work-body")) |= (.floating = $floating)
  | (.. | objects | select(.id? == "status")) |= del(.hidden)
' "$dst" > "$dst.tmp"
mv "$dst.tmp" "$dst"
