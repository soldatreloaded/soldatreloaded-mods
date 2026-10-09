# Soldat Reloaded mods

Mods for [Soldat Reloaded](https://github.com/soldatreloaded/soldatreloaded-odin): new looks
and sounds for the game, made by its players. Each mod here is published as a download,
and listed in an index the game reads, so players can find and install them from inside
the game.

A mod changes only how the game looks and sounds, never how it plays: everyone in a game
can wear a different one.

## Installing a mod

**From the game:** on the **Mods** page, **Get mods** lists every mod here. **Install**
puts it in the game's `mods/` folder and turns it on.

**By hand:** a mod is an `.smod` file, a zip under another name, as OpenSoldat's are.
Take the mod's zip from the [releases](../../releases), rename it from `NoNameMod.zip` to
`NoNameMod.smod`, and put it in the game's `mods/` folder, beside `classic/`. Don't
unpack it. An OpenSoldat `.smod` goes in the same way.

Then, on the **Mods** page, **Installed mods**, turn it **On**.

**Several at once:** any number of mods can be on together, in an order. Each file is
taken from the top mod that has it, then from Classic, the game's own look and sound, which
is always under them all. So a mod of the soldier's art and a mod of sounds are worn
together, and a mod higher up wins where two change the same file. **Up** and **Down**
change the order.

**From your old Soldat:** on **Get mods**, **From your Soldat 1.7.1** makes a mod of the
art and sounds you changed in an original Soldat 1.7.1: the game finds its folder where
it is usually installed, or you type it. Only what differs from the game as it came goes
in.

**If a mod changes nothing:** the Mods page says what each mod changes (graphics, sounds,
fonts, `mod.ini`), and warns when a mod holds nothing the game uses. Its files must be in
`gostek-gfx/`, `sfx/` and the rest (below), at its root. A zip whose files sit one
folder down (`MyMod/gostek-gfx/...`) is read from there.

## Making a mod

A mod is laid out as an OpenSoldat or original Soldat mod is, so most old mods work as
they are. It holds only what it changes: anything it doesn't have comes from the mods
under it, then Classic. A mod can be one sound.

| Folder | What is in it |
|---|---|
| `gostek-gfx/` | the soldier: `klata.png` (chest), `morda.png` (head), `noga.png`, `udo.png`, …, each with its mirrored `…2.png`; the second team's in `team2/`, the wounds in `ranny/`, the hair (`hair1`–`hair4`, `dred`) and headgear (`helm`, `kap`) beside them |
| `weapons-gfx/` | the guns, held and dropped, their bullets, casings and clips |
| `interface-gfx/` | the HUD: health, ammo and jet bars, icons, the cursor |
| `sparks-gfx/` | blood, smoke, explosions, flames, chips |
| `objects-gfx/`, `textures/objects/` | flags and kits |
| `scenery-gfx/`, `textures/` | maps' scenery and polygon textures |
| `sfx/` | the sounds, as `.wav`, `.mp3` or `.ogg` (a `.wav` is used first) |
| `mod.ini` | `[SCALE]`: how big images are in the world; `[GOSTEK]`: where each of the soldier's parts and weapons is pinned (`Left_Thigh_CenterX=0.2`) |
| `txt/font.ini` | the HUD's two fonts (`Font1File`, `Font2File`, a `.ttf` in `fonts/` or beside `mod.ini`), their widths and sizes |

Images can be `.png` or `.bmp` (a `.png` is used before a `.bmp` of the same name), and
pure green (`#00FF00`) is see-through, as in the original game. A file's name is matched
whatever its case. `mod.ini` and `txt/font.ini` are written as the original game's are,
and a key a mod leaves out keeps Classic's value.

A mod's `mod.ini` sizes and pins only that mod's own images; a mod without one is sized
by Classic's. Art drawn at the original game's old, small size (before Soldat 1.6) wants
a scale of 1 for its folders (`gostek-gfx=1`, `gostek-gfx/team2=1`, ...); without it, the
game finds such a folder by its images' size and draws it so anyway.

The game's own files, [Classic](https://github.com/soldatreloaded/soldatreloaded-odin/tree/main/assets/mods/classic),
are the place to start: copy the ones you want to change. To work on a mod, make it a
folder of `mods/` rather than an `.smod` (the Mods page's **New mod** makes an empty
one): the game reads a folder as it reads an `.smod`, and turning the mod off and on
again shows what you changed. Zip it, and name it `.smod`, to share it.

## Adding your mod here

1. **Fork** this repository (the Fork button, top right), and clone your fork.
2. **Add your mod's folder** under `mods/`, named as your mod: letters, digits, `-` and
   `_`, at most 32 of them (`mods/MyMod/`). Put its files in it as they sit in the
   game's `mods/MyMod/`.
3. **Add `about.json`** in that folder:

   ```json
   {
     "name": "MyMod",
     "title": "My Mod",
     "version": "1.0.0",
     "author": "Your name",
     "description": "One or two sentences: what it looks and sounds like.",
     "licence": "What others may do with it, e.g. CC BY 4.0, or free to share with credit.",
     "source": "Where it came from, or how to reach you (optional)"
   }
   ```

   `name` is the folder's name; `version` is three numbers. `title` is optional: the name
   the game shows, which may have spaces and capitals as you like, at most 48 characters
   (`name`, if it has none).
4. **Check it** (needs bash and [jq](https://jqlang.org)): `scripts/check.sh`. It says what
   is wrong, if anything. The same check runs on your pull request, so you can also skip
   this and read its result there.
5. **Commit, push, and open a pull request** to this repository's `main`, saying what
   your mod is. A maintainer reviews it; once it is merged, it is published and shows up
   in the game.

### Updating your mod

Change its files, **raise its `version`** in `about.json` (`1.0.0` to `1.1.0`), and open a
pull request as before. A version is published once and never changed: a change with
the same version isn't published.

### What is accepted

- **Your own work, or work you may share.** Say whose it is and what may be done with it
  in `about.json`, and include any credits or licence file it came with. A mod made from
  Classic's files carries Classic's licence (CC BY 4.0, from OpenSoldat's base content)
  and its `NOTICE.md`.
- **Only the mod's files**: no `Thumbs.db`, `desktop.ini`, `.DS_Store` or `__MACOSX`.
- **At most 150 MB.**
- Nothing hateful, sexual or otherwise unfit for a game anyone may play.

If a mod here is yours and you want it credited differently or taken down, open an issue.

## How it is published

Nothing here is published by hand. When a pull request is merged into `main`,
[the publish workflow](.github/workflows/publish.yml) runs `scripts/check.sh`, then
`scripts/publish.sh`, which:

- releases each mod's new version as a release of its own, tagged `<name>-<version>`,
  holding the mod as `<name>.zip`, its folder's files at the zip's root;
- writes `mods.json`, every mod's newest version with where its zip is, its size and
  SHA-256, onto the `index` release, where the game reads it:
  `https://github.com/soldatreloaded/soldatreloaded-mods/releases/download/index/mods.json`

```json
{
  "format": 1,
  "mods": [
    {
      "name": "NoNameMod",
      "title": "NoNameMod",
      "version": "1.0.0",
      "author": "Calp",
      "description": "…",
      "licence": "…",
      "source": "…",
      "url": "https://github.com/soldatreloaded/soldatreloaded-mods/releases/download/NoNameMod-1.0.0/NoNameMod.zip",
      "size": 3500000,
      "sha256": "…"
    }
  ]
}
```

## Licence

Each mod is its author's, under the terms in its `about.json` and any licence or credits
file in its folder. This repository's scripts and workflows are under the MIT licence.
