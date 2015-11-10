#!/usr/bin/env bash
# Base16 Paraiso - Gnome Terminal color scheme install script
# Jan T. Sott

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Paraiso Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-paraiso-dark"
[[ -z "$DCONF" ]] && DCONF=dconf
[[ -z "$UUIDGEN" ]] && UUIDGEN=uuidgen

dset() {
    local key="$1"; shift
    local val="$1"; shift

    if [[ "$type" == "string" ]]; then
        val="'$val'"
    fi

    "$DCONF" write "$PROFILE_KEY/$key" "$val"
}

# because dconf still doesn't have "append"
dlist_append() {
    local key="$1"; shift
    local val="$1"; shift

    local entries="$(
        {
            "$DCONF" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
            echo "'$val'"
        } | head -c-1 | tr "\n" ,
    )"

    "$DCONF" write "$key" "[$entries]"
}

# Newest versions of gnome-terminal use dconf
if which "$DCONF" > /dev/null 2>&1; then
    [[ -z "$BASE_KEY_NEW" ]] && BASE_KEY_NEW=/org/gnome/terminal/legacy/profiles:

    if [[ -n "`$DCONF list $BASE_KEY_NEW/`" ]]; then
        if which "$UUIDGEN" > /dev/null 2>&1; then
            PROFILE_SLUG=`uuidgen`
        fi

        if [[ -n "`$DCONF read $BASE_KEY_NEW/default`" ]]; then
            DEFAULT_SLUG=`$DCONF read $BASE_KEY_NEW/default | tr -d \'`
        else
            DEFAULT_SLUG=`$DCONF list $BASE_KEY_NEW/ | grep '^:' | head -n1 | tr -d :/`
        fi

        DEFAULT_KEY="$BASE_KEY_NEW/:$DEFAULT_SLUG"
        PROFILE_KEY="$BASE_KEY_NEW/:$PROFILE_SLUG"

        # copy existing settings from default profile
        $DCONF dump "$DEFAULT_KEY/" | $DCONF load "$PROFILE_KEY/"

        # add new copy to list of profiles
        dlist_append $BASE_KEY_NEW/list "$PROFILE_SLUG"

        # update profile values with theme options
        dset visible-name "'$PROFILE_NAME'"
        dset palette "['#2f1e2e', '#ef6155', '#48b685', '#fec418', '#06b6ef', '#815ba4', '#5bc4bf', '#a39e9b', '#776e71', '#ef6155', '#48b685', '#fec418', '#06b6ef', '#815ba4', '#5bc4bf', '#e7e9db']"
        dset background-color "'#2f1e2e'"
        dset foreground-color "'#a39e9b'"
        dset bold-color "'#a39e9b'"
        dset bold-color-same-as-fg "true"
        dset use-theme-colors "false"
        dset use-theme-background "false"

        # Refer: http://unix.stackexchange.com/questions/133914/set-gnome-terminal-background-text-color-from-bash-script
        # override colors
        # default palette bright colors
        dset palette "'Tango'"
        # ubuntu background's color #2C001E. But, this is a bit brighter
        dset background-color "'#411934'"
        dset foreground-color "'#ffffff'"


        unset PROFILE_NAME
        unset PROFILE_SLUG
        unset DCONF
        unset UUIDGEN
        exit 0
    fi
fi

# Fallback for Gnome 2 and early Gnome 3
[[ -z "$GCONFTOOL" ]] && GCONFTOOL=gconftool
[[ -z "$BASE_KEY" ]] && BASE_KEY=/apps/gnome-terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

gset() {
    local type="$1"; shift
    local key="$1"; shift
    local val="$1"; shift

    "$GCONFTOOL" --set --type "$type" "$PROFILE_KEY/$key" -- "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
    local type="$1"; shift
    local key="$1"; shift
    local val="$1"; shift

    local entries="$(
        {
            "$GCONFTOOL" --get "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
            echo "$val"
        } | head -c-1 | tr "\n" ,
    )"

    "$GCONFTOOL" --set --type list --list-type $type "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append string /apps/gnome-terminal/global/profile_list "$PROFILE_SLUG"

gset string visible_name "$PROFILE_NAME"
gset string palette "#2f1e2e:#ef6155:#48b685:#fec418:#06b6ef:#815ba4:#5bc4bf:#a39e9b:#776e71:#ef6155:#48b685:#fec418:#06b6ef:#815ba4:#5bc4bf:#e7e9db"
gset string background_color "#2f1e2e"
gset string foreground_color "#a39e9b"
gset string bold_color "#a39e9b"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"

# Refer: http://unix.stackexchange.com/questions/133914/set-gnome-terminal-background-text-color-from-bash-script
# override colors
# default palette bright colors
gset string palette "Tango"
# ubuntu background's color #2C001E. But, this is a bit brighter
#gset string background_color "#411934"
gset string background_color "#2C001E"
gset string foreground_color "#ffffff"

# set profile font and custom settings
gset string font "Hack Regular 10"
gset bool use_system_font "false"
gset bool default_show_menubar "false"
gset int default_size_rows 28
gset int default_size_columns 88

# set this profile as default
gconftool --set /apps/gnome-terminal/global/default_profile --type string "$PROFILE_SLUG"

unset PROFILE_NAME
unset PROFILE_SLUG
unset DCONF
unset UUIDGEN