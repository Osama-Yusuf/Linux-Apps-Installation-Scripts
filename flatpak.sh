# To install Flatpak on Ubuntu 18.10 (Cosmic Cuttlefish) or later, simply run:
sudo apt install flatpak
# The Flatpak plugin for the Software app makes it possible to install apps without needing the command line. To install, run:
sudo apt install gnome-software-plugin-flatpak
# Flathub is the best place to get Flatpak apps. To enable it, run:
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# now restart 
echo "Restart your pc now"
