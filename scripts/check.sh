#!/usr/bin/env bash
# Checks every mod in mods/: what a pull request must pass, and what is checked again
# before anything is published. Needs bash, jq and du. Prints each problem; exits 1 if
# there are any.
set -euo pipefail
cd "$(dirname "$0")/.."

MAX_MB=150 # a mod's size, at most
fail=0
problem() { echo "::error::$*"; fail=1; }

shopt -s nullglob
dirs=(mods/*/)
[[ ${#dirs[@]} -gt 0 ]] || problem "no mods in mods/"

for dir in "${dirs[@]}"; do
  dir=${dir%/}
  name=$(basename "$dir")

  # the folder's name is the mod's: the game's folder, its release's tag and its URL
  if [[ ! $name =~ ^[A-Za-z0-9][A-Za-z0-9_-]{0,31}$ ]]; then
    problem "$name: a mod's folder is named with letters, digits, - and _ only, at most 32 of them"
  fi
  shopt -s nocasematch
  if [[ $name == classic || $name == builtin || $name == default ]]; then
    problem "$name: that name is the game's own"
  fi
  shopt -u nocasematch

  about="$dir/about.json"
  if [[ ! -f $about ]]; then
    problem "$name: no about.json"
    continue
  fi
  if ! jq -e 'type == "object"' "$about" >/dev/null 2>&1; then
    problem "$name: about.json isn't a JSON object"
    continue
  fi
  for field in name version author description licence; do
    if [[ -z $(jq -r --arg f "$field" '.[$f] // "" | strings' "$about") ]]; then
      problem "$name: about.json has no \"$field\""
    fi
  done
  if [[ $(jq -r '.name // ""' "$about") != "$name" ]]; then
    problem "$name: about.json's name isn't the folder's"
  fi
  if [[ ! $(jq -r '.version // ""' "$about") =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    problem "$name: about.json's version is three numbers, as 1.0.0"
  fi

  if [[ $(find "$dir" -type f ! -name about.json | wc -l) -eq 0 ]]; then
    problem "$name: nothing but about.json"
  fi
  while IFS= read -r junk; do
    problem "$name: $junk is a system file, not the mod's"
  done < <(find "$dir" \( -iname thumbs.db -o -iname desktop.ini -o -name .DS_Store -o -name '__MACOSX' -o -name '._*' \))

  mb=$(du -sm "$dir" | cut -f1)
  if (( mb > MAX_MB )); then
    problem "$name: ${mb} MB, more than $MAX_MB MB"
  fi
done

if (( fail )); then
  echo "Some mods need fixing; see above."
else
  echo "Every mod is in order."
fi
exit $fail
