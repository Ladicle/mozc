#!/usr/local/bin/fish

# Set environment
set -x GYP_DEFINES "mac_sdk=10.15 mac_deployment_target=10.15"
set -x PATH $PWD/depot_tools $PATH

cd src

# Build
GYP_DEFINES="mac_sdk=10.15 mac_deployment_target=10.15" python build_mozc.py gyp --qtdir=/usr/local/opt/qt5
./replace-version.sh 2>/dev/null &
python build_mozc.py build -c Release mac/mac.gyp:GoogleJapaneseInput gui/gui.gyp:config_dialog_main
python build_mozc.py build -c Release mac/mac.gyp:GoogleJapaneseInput mac/mac.gyp:gen_launchd_confs
python build_mozc.py build -c Release mac/mac.gyp:GoogleJapaneseInput unix/emacs/emacs.gyp:mozc_emacs_helper

# installation
sudo cp -r out_mac/Release/Mozc.app /Library/Input\ Methods/; and echo "✓ Install InputMethod"
sudo cp -r out_mac/Release/gen/mac/org.mozc.inputmethod.Japanese.Converter.plist /Library/LaunchAgents; and echo "✓ Install Launchagents for Converter"
sudo cp -r out_mac/Release/gen/mac/org.mozc.inputmethod.Japanese.Renderer.plist /Library/LaunchAgents; and echo "✓ Install Launchagents for Renderer"
sudo cp -r out_mac/Release/mozc_emacs_helper /usr/local/bin; and echo "✓ Install EmacsHelper"
