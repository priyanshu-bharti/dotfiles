#!/bin/bash

# Get the focused workspace from aerospace
if [ "$SENDER" = "aerospace_workspace_change" ]; then
    FOCUSED_WORKSPACE="$FOCUSED_WORKSPACE"
else
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

# Determine which monitor this bar should show workspaces for
# by checking which workspace range the focused workspace belongs to
if [[ "$FOCUSED_WORKSPACE" =~ ^[1-4]$ ]]; then
    # If focused workspace is 1-4, this bar should show 1-4
    DISPLAY_WORKSPACES=("1" "2" "3" "4")
    HIDDEN_WORKSPACES=("5" "6" "7" "8")
elif [[ "$FOCUSED_WORKSPACE" =~ ^[5-8]$ ]]; then
    # If focused workspace is 5-8, this bar should show 5-8
    DISPLAY_WORKSPACES=("5" "6" "7" "8")
    HIDDEN_WORKSPACES=("1" "2" "3" "4")
else
    # Fallback: try to detect based on aerospace monitor assignment
    MONITOR_1_WS=$(aerospace list-workspaces --monitor 1 --json | jq -r '.[].workspace')

    # Check if current bar's first workspace (space.1) exists
    # If workspace 1 is on monitor 1, show 1-4, otherwise show 5-8
    if echo "$MONITOR_1_WS" | grep -q "^1$"; then
        DISPLAY_WORKSPACES=("1" "2" "3" "4")
        HIDDEN_WORKSPACES=("5" "6" "7" "8")
    else
        DISPLAY_WORKSPACES=("5" "6" "7" "8")
        HIDDEN_WORKSPACES=("1" "2" "3" "4")
    fi
fi

# Hide workspaces that don't belong to this display
for workspace in "${HIDDEN_WORKSPACES[@]}"; do
    sketchybar --set space."${workspace}" drawing=off
done

# Show and update workspaces for this display
for workspace in "${DISPLAY_WORKSPACES[@]}"; do
    sketchybar --set space."${workspace}" drawing=on

    if [ "$workspace" = "$FOCUSED_WORKSPACE" ]; then
        # Highlight focused workspace
        sketchybar --set space."${workspace}" \
            background.color=0xFF7AA2f7 \
            icon.color=0xFF1A1B26 \
            label.color=0xFF1A1B26
    else
        # Dim unfocused workspaces
        sketchybar --set space."${workspace}" \
            background.color=0x40ffffff \
            icon.color=0xFFc0caf5 \
            label.color=0xFFc0caf5
    fi
done
