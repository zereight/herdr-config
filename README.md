# herdr-config

Personal [Herdr](https://herdr.dev) setup (Herdr 0.9.3, Herdr App with GPUI), macOS.

## Layout

| Path | Installs to | What |
|---|---|---|
| `herdr/config.toml` | `~/.config/herdr/` | Daemon config: theme, keys, plugin key bindings, tab-bar widgets |
| `herdr/config-gpui.local.toml` | `~/.config/herdr/` | GUI overrides (layout, theme) |
| `herdr/plugins/*.config*` | `~/.config/herdr/plugins/config/<plugin>/` | Per-plugin settings |
| `herdr-app/keys.json`, `settings.json` | `~/.config/herdr-app/` | App keybinds and settings |
| `herdr-app/layouts/`, `themes/` | `~/.config/herdr-app/` | Layouts (incl. `herdr-t3`) and themes |
| `herdr-app/herdr-t3-keep-mods.sh` | `~/.config/herdr-app/` | Re-applies panels to `herdr-t3.json` after herdr-t3's `update.sh` |

`config.toml` has `__HOME__` where an absolute home path is needed; `install.sh` fills it in.

## Plugins (install separately)

- gitview: https://github.com/ChmaraX/herdr-gitview @ 2de9ea5
- Herdr Automatic Rename: https://github.com/qu8n/herdr-automatic-rename @ a997543
- herdr-pomodoro: https://github.com/michmos/herdr-pomodoro @ f532433
- mfp.player: https://github.com/pivoshenko/musicforprogramming (`plugins/herdr/mfp.player`) @ 185303d
- reviewr: https://github.com/persiyanov/herdr-reviewr @ 03d0230

Mods under `~/.config/herdr-app/mods/` (including the `t3-*` ones from herdr-t3) are not stored here: they are third-party and reinstallable.

## Install

```sh
./install.sh          # backs up existing files to *.bak-<timestamp> first
```

## Not included

Sessions, logs, window state, `shared.json` (machine names/addresses), and third-party mod/plugin code.

## Credits / licenses

`layouts/herdr-t3.*` derive from [JinJieBeWater/herdr-t3](https://github.com/JinJieBeWater/herdr-t3) (Apache-2.0); other layouts/themes derive from Herdr App's shipped ones or are local variants. Those files keep their upstream licenses.
