#!/bin/bash
# macOS Productivity Tweaks Script
# Run: chmod +x macos_tweaks.sh && ./macos_tweaks.sh
# Some changes require logout or restart to fully apply.

echo "Applying macOS tweaks..."

###############################################################################
# Keyboard & Input                                                            #
###############################################################################

# Disable press-and-hold for accented characters (enable key repeat)
defaults write -g ApplePressAndHoldEnabled -bool false

# Faster key repeat
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 15

# Full keyboard navigation (tab through dialogs)
defaults write -g AppleKeyboardUIMode -int 3

###############################################################################
# Trackpad & Mouse                                                            #
###############################################################################

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

###############################################################################
# Dock                                                                        #
###############################################################################

# Remove dock show/hide delay
defaults write com.apple.dock autohide-delay -float 0

# Speed up dock animation
defaults write com.apple.dock autohide-time-modifier -float 0.2

# Dock icon size
defaults write com.apple.dock tilesize -int 36

# Show hidden apps as translucent
defaults write com.apple.dock showhidden -bool true

# Restart Dock
killall Dock &>/dev/null

###############################################################################
# Animations                                                                  #
###############################################################################

# Speed up Mission Control
defaults write com.apple.dock expose-animation-duration -float 0.15

# Disable window resize animation
defaults write -g NSWindowResizeTime -float 0.001

# Disable automatic window animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Disable Quick Look animation
defaults write -g QLPanelAnimationDuration -float 0

###############################################################################
# Finder                                                                      #
###############################################################################

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Restart Finder
killall Finder &>/dev/null

###############################################################################
# Other Tweaks                                                                #
###############################################################################

# Expand save and print dialogs by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true

# Avoid creating .DS_Store on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable automatic substitutions (better for coding)
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Done                                                                        #
###############################################################################

echo "✅ macOS tweaks applied. Some may require logout/restart."
