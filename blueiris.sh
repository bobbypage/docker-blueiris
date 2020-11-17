#!/bin/bash

WINEPREFIX_DIR="/root/wineprefix/prefix"

if [ ! -d "${WINEPREFIX_DIR}" ]; then
    mkdir -p "${WINEPREFIX_DIR}"
fi

BLUEIRIS_EXE="${WINEPREFIX_DIR}/drive_c/Program Files/Blue Iris ${BLUEIRIS_VERSION}/BlueIris.exe"
BLUEIRIS_INSTALL_PATH="${WINEPREFIX_DIR}/drive_c/Program Files/Blue Iris ${BLUEIRIS_VERSION}"
INSTALL_EXE="/root/blueiris.exe"
WINETRICKS="/root/winetricks"
UI3_SCRIPT="/root/get_latest_ui3.sh"

#if [ ! -d "${WINEPREFIX_DIR}/drive_c" ]; then
  #"${WINETRICKS}" win10
  #"${WINETRICKS}" -q corefonts wininet vcrun2019 mfc42
#fi

if [ ! -d "${BLUEIRIS_INSTALL_PATH}" ]; then
    echo "Installing blueiris for first time..."
    wine "${INSTALL_EXE}"

    sleep 10

    echo "installing ui3..."
    bash "${UI3_SCRIPT}"

    echo "extracting ui3..."

    if [ "$BLUEIRIS_VERSION" == "5" ]; then
       unzip -o "${BLUEIRIS_INSTALL_PATH}/ui3.zip" -d "${BLUEIRIS_INSTALL_PATH}/www/"
    fi
    #wine reg import service.reg && sleep 5
    #kill 1
fi

echo "BI install complete; sleeping for a bit..."
sleep 10

wine reg import service.reg && sleep 5 && wine net start blueiris && sleep 5
wine "${BLUEIRIS_EXE}"
