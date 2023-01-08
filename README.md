# Steamlink Launcher for Kodi

Plugin for [Kodi](https://kodi.tv/) to launch [Steamlink](https://steamcommunity.com/app/353380/discussions/6/2806204039992195182/).
Based on work of [bigbrozer](https://github.com/bigbrozer/kodi-steamlink-launcher).

## Requirements

Any recent Linux distribution with following requirements:

* Systemd-based
* Flatpak support (hint: `sudo apt install flatpak`)
* Kodi v19 package installed as a service (hint: `sudo apt install kodi`)
* Install [steamlink](https://steamcommunity.com/app/353380/discussions/0/1743353164093954254)

    ```shell
    # Install SteamLink package
    flatpack install com.valvesoftware.SteamLink

    # Add a lancher script
    cat <<EOF > /usr/local/bin/steamlink
    #!/bin/bash
    flatpak run com.valvesoftware.SteamLink
    EOF

    # Make the launcher executable
    chmod +x /usr/local/bin/steamlink
    ```

    Adapt startup command if needed For example if SteamLink was installed through a Debian package, replace the `flatpack` line with just `steamlink`.

* Specfic for Openbox if used

    If not running a full Desktop Environment like Gnome, KDE or XFCE, some display-related tweaks are needed to properly launch SteamLink. The starting script becomes:

    ```bash
    /usr/bin/xinit /usr/bin/dbus-launch --exit-with-session /usr/bin/openbox-session -- :0 -nolisten tcp vt7 &
    sleep 3 # Allow some time for display initialization
    OUTPUT=`xrandr -display :0 -q | sed '/ connected/!d;s/ .*//;q'`
    xrandr -display :0 --output $OUTPUT --set "Broadcast RGB" "Full"
    export DISPLAY=:0
    flatpak run com.valvesoftware.SteamLink
    openbox --exit
    sleep 3 # Allow some time for display to shutdown (needed for proper Kodi restart)
    ```

## Plugin installation

* Log into ssh on your Kodi installation.

* Download the [zip](https://github.com/jacen05/kodi-steamlink-launcher/releases) of the launcher and install it via Kodi (*Extension → Install from Zip file*). You must **allow untrusted sources** in system settings prior to this.

* Setup sudo rules to allow `kodi` user to run steamlink:

    ```bash
    cat <<EOF > /etc/sudoers.d/kodi-steamlink
    kodi ALL=(root) NOPASSWD: /usr/bin/systemd-run /home/kodi/.kodi/addons/plugin.program.steamlink/resources/lib/launcher.sh
    EOF
    ```

* Make the launcher executable:

    ```bash
    chmod +x /home/kodi/.kodi/addons/plugin.program.steamlink/resources/lib/launcher.sh
    ```

## Acknowledgement

```plain
Steam Copyright 2003-2018 Valve Corp. All rights reserved. Use of Steam Link software is subject to the Steam Subscriber Agreement, https://store.steampowered.com/subscriber_agreement/.
```

## Inspiration

* [bigbrozer/kodi-steamlink-launcher](https://github.com/bigbrozer/kodi-steamlink-launcher) - Steamlink launcher for Kodi on Raspbian
* [grimlokason/osmc-steamlink](https://gitlab.com/grimlokason/osmc-steamlink) - scripting logic
* [swetoast/steamlink-launcher](https://github.com/swetoast/steamlink-launcher) - addon resources

## License

Steamlink Launcher for Kodi is licensed under GPLv2, see `LICENSE.txt`.
