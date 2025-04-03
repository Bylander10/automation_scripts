#!bin/bash

CONFIG_FILE=~/dotfiles/.config/hypr/conf/keyboard.conf
CURRENT_LAYOUT=$(grep "kb_layout" "$CONFIG_FILE" | grep -v "^#" | awk -F '=' '{print $2}' | xargs)

if [[ "$CURRENT_LAYOUT" == "br" ]]; then
    sed -i 's/kb_layout = br/kb_layout = us/' "$CONFIG_FILE"
    sed -i 's/kb_variant = abnt2/kb_variant = /' "$CONFIG_FILE"
else
    sed -i 's/kb_layout = us/kb_layout = br/' "$CONFIG_FILE"
    sed -i 's/kb_variant = /kb_variant = abnt2/' "$CONFIG_FILE"
fi

hyprctl reload

