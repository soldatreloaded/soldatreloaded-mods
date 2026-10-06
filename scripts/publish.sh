#!/usr/bin/env bash
# Publishes the mods, from GitHub Actions on main (.github/workflows/publish.yml):
#
#   - each mod's version is a release of its own, tagged <name>-<version>, holding the
#     mod as <name>.zip (its folder's files at the zip's root). A version released
#     already is left as it is: to publish a change, raise the version.
#   - the "index" release holds mods.json: every mod's newest version, where its zip is,
#     its size and SHA-256. The game's mod browser reads it from
#     https://github.com/<repo>/releases/download/index/mods.json
#
# Needs bash, jq, zip, sha256sum and gh, with GH_TOKEN and GITHUB_REPOSITORY set.
set -euo pipefail
cd "$(dirname "$0")/.."

repo=${GITHUB_REPOSITORY:?the repository, as owner/name}
dist=dist
rm -rf "$dist"
mkdir -p "$dist"

entries=()
for dir in mods/*/; do
  dir=${dir%/}
  name=$(basename "$dir")
  about="$dir/about.json"
  version=$(jq -r .version "$about")
  tag="$name-$version"
  zip="$dist/$name.zip"

  if gh release view "$tag" --repo "$repo" >/dev/null 2>&1; then
    # out already: the index lists the zip that is there, as it is
    gh release download "$tag" --repo "$repo" --pattern "$name.zip" --dir "$dist" --clobber
    echo "$tag: released already"
  else
    (cd "$dir" && find . -type f -print | LC_ALL=C sort | zip -q -X "../../$zip" -@)
    gh release create "$tag" "$zip" --repo "$repo" --latest=false \
      --title "$name $version" --notes "$(jq -r .description "$about")"
    echo "$tag: released"
  fi

  size=$(stat -c %s "$zip")
  sha256=$(sha256sum "$zip" | cut -d' ' -f1)
  url="https://github.com/$repo/releases/download/$tag/$name.zip"
  entries+=("$(jq -c --arg url "$url" --argjson size "$size" --arg sha256 "$sha256" \
    '{name, version, author, description, licence, source: (.source // ""), url: $url, size: $size, sha256: $sha256}' "$about")")
done

printf '%s\n' "${entries[@]}" | jq -s '{format: 1, mods: (. | sort_by(.name | ascii_downcase))}' > "$dist/mods.json"

if ! gh release view index --repo "$repo" >/dev/null 2>&1; then
  gh release create index --repo "$repo" --latest=false --title "Index" \
    --notes "mods.json: every mod's newest version, for the game's mod browser. Updated by the publish workflow; not to be edited by hand."
fi
gh release upload index "$dist/mods.json" --repo "$repo" --clobber
echo "Index: $(jq '.mods | length' "$dist/mods.json") mods."
