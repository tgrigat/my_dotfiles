#!/usr/bin/bash
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
# setting environmental variables under wayland
if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
else
    # fix x11 crashing when relogin from wayland
    unset MOZ_ENABLE_WAYLAND
    unset QT_QPA_PLATFORM
fi
setxkbmap -option caps:escape_shifted_capslock


export PATH=~/.local/bin:$PATH

# for synology support
export QT_QPA_PLATFORM="wayland;xcb"

# enable firefox wayland
export MOZ_ENABLE_WAYLAND=1
