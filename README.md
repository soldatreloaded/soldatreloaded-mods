# Soldat Reloaded mods

Mods for [Soldat Reloaded](https://github.com/soldatreloaded/soldatreloaded-odin): new looks
and sounds for the game, made by its players. Each mod here is published as a download,
and listed in an index the game reads, so players can find and install them from inside
the game.

A mod changes only how the game looks and sounds, never how it plays: everyone in a game
can wear a different one.

## Installing a mod

Take the mod's zip from the [releases](../../releases), unpack it into a folder of the
game's `mods/` named as the mod (`mods/NoNameMod/`), and pick it on the game's **Mods**
page. A browser of the mods here, on that page, is on its way.

## Making a mod

A mod is laid out as an OpenSoldat or original Soldat mod is, so most old mods work as
they are. It holds only what it changes: anything it doesn't have comes from Classic, the
game's own look and sound. A mod can be one sound.

| Folder | What is in it |
|---|---|
| `gostek-gfx/` | the soldier: `klata.png` (chest), `morda.png` (head), `noga.png`, `udo.png`, …, each with its mirrored `…2.png`; the second team's in `team2/`, the wounds in `ranny/`, the hair (`hair1`–`hair4`, `dred`) and headgear (`helm`, `kap`) beside them |
| `weapons-gfx/` | the guns, held and dropped, their bullets, casings and clips |
| `interface-gfx/` | the HUD: health, ammo and jet bars, icons, the cursor |
| `sparks-gfx/` | blood, smoke, explosions, flames, chips |
| `objects-gfx/`, `textures/objects/` | flags and kits |
| `scenery-gfx/`, `textures/` | maps' scenery and polygon textures |
| `sfx/` | the sounds, as `.wav` |

Images can be `.png` or `.bmp` (a `.png` is used before a `.bmp` of the same name), and
pure green (`#00FF00`) is see-through, as in the original game. A file's name is matched
whatever its case.

The game's own files, [Classic](https://github.com/soldatreloaded/soldatreloaded-odin/tree/main/assets/mods/builtin/Classic),
are the place to start: copy the ones you want to change. The game's Mods page can also
make you a copy of Classic in your `mods/` folder to work in, and uses a mod at once, so you
can see a change as you make it.

## Adding your mod here

1. **Fork** this repository (the Fork button, top right), and clone your fork.
2. **Add your mod's folder** under `mods/`, named as your mod: letters, digits, `-` and
   `_`, at most 32 of them (`mods/MyMod/`). Put its files in it as they sit in the
   game's `mods/MyMod/`.
3. **Add `about.json`** in that folder:

   ```json
   {
     "name": "MyMod",
     "version": "1.0.0",
     "author": "Your name",
     "description": "One or two sentences: what it looks and sounds like.",
     "licence": "What others may do with it, e.g. CC BY 4.0, or free to share with credit.",
     "source": "Where it came from, or how to reach you (optional)"
   }
   ```

   `name` is the folder's name; `version` is three numbers.
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
