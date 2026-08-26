#!/usr/bin/env bash

THEME="$HOME/.config/rofi/spotify.rasi"

query=$(rofi -dmenu -p "󰓇 Search Spotify" -theme "$THEME") || exit 0
[ -z "$query" ] && exit 0

results=$(spotify_player search "$query") || exit 1

selected=$(
    printf '%s' "$results" |
    jq -r '.tracks[] | "\(.name) — \(.artists | map(.name) | join(", "))|\(.id)"' |
    rofi -dmenu -p "Play Spotify" -theme "$THEME"
) || exit 0

[ -z "$selected" ] && exit 0

track_id="${selected##*|}"

spotify_player playback start track --id "$track_id"
