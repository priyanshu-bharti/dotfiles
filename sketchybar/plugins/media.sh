#!/bin/bash
truncate_text() {
    local text="$1"
    local max_length=${2:-28}
    if [ ${#text} -le "$max_length" ]; then
        echo "$text"
    else
        echo "${text:0:$max_length}..."
    fi
}
MEDIA_CONTROL="/opt/homebrew/bin/media-control"
# Initialize
current_label="Not Playing"
sketchybar --set media label="$current_label"
media-control stream |
    while IFS= read -r line; do
        if [ "$(jq -r '.diff == false' <<<"$line")" = "true" ]; then
            raw_title=$(jq -r '.payload.title' <<<"$line")
            raw_artist=$(jq -r '.payload.artist' <<<"$line")
            if [ -n "$raw_title" ] && [ "$raw_title" != "null" ] ||
                [ -n "$raw_artist" ] && [ "$raw_artist" != "null" ]; then
                title=$(truncate_text "$raw_title" 12)
                artist=$(truncate_text "$raw_artist" 8)
                label="$title – $artist"
            else
                label="Not Playing"
            fi
            # Only update SketchyBar if label changed
            if [ "$label" != "$current_label" ]; then
                sketchybar --set media label="$label"
                current_label="$label"
            fi
        fi
    done
