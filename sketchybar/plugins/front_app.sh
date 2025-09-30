#!/bin/bash

# Always fetch the current workspace and app name from aerospace
WORKSPACE=$(aerospace list-workspaces --focused --json | jq -r '.[0].workspace')
APP_NAME=$(aerospace list-windows --focused --json | jq -r '.[0]."app-name"')

# If no app is focused (empty workspace), default to Finder
if [ -z "$APP_NAME" ] || [ "$APP_NAME" = "null" ]; then
    APP_NAME="Finder"
fi

# Format: workspace - application name
if [ -n "$WORKSPACE" ] && [ "$WORKSPACE" != "null" ]; then
    LABEL="$WORKSPACE - $APP_NAME"
else
    LABEL="$APP_NAME"
fi

sketchybar --set "$NAME" label="$LABEL"
