"""
Steamlink Launcher for Kodi
"""

import os
import xbmc
import xbmcgui
import xbmcaddon

from subprocess import check_call

class KodiAddon(object):
    def __init__(self):
        self._addon = xbmcaddon.Addon()
        self.path = os.path.dirname(os.path.realpath(__file__))
    
    def run(self):
        check_call(['bash', '-c', 'flatpak run com.valvesoftware.SteamLink &>>./steamlink_launcher.log'])

def main():
    addon = KodiAddon()
    addon.run()

main()
