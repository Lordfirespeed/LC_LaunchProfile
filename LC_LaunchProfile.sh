#!/bin/bash

# Unless you know what you're doing, leave these variables alone.
proton-launch-pre-init() {
  STEAM_HOME="${HOME}/.steam/steam"
  STEAM_HOME_APPS_PATH="${STEAM_HOME}/steamapps"
  
  export SteamAppId="1966720"
  export SteamGameId="1966720"
}

proton-launch-user-specific-init() {
  # Set this to the Proton version in use for the given game:
  PROTON_VERSION="Proton - Experimental"
  # Specify the fully-qualified path to the SteamLibrary Lethal Company is
  # installed in here, if different from the default home directory SteamLibrary:
  STEAM_GAME_LIBRARY="${STEAM_HOME}"
  # Specify launch config
  declare -A CONFIG=( [windowCount]=1 )
}

# Unless you know what you're doing, leave these variables alone.
proton-launch-post-init() {
  ##### Unless you know what you're doing, leave the rest of these alone: #####
  # Fully-qualified Steam apps library path
  STEAM_GAME_LIBRARY_APPS="${STEAM_GAME_LIBRARY}/steamapps"
  # Application subpath in `steamapps` folder
  APP_SUBPATH="Lethal Company"
  # Application executable name
  APP_EXEC="Lethal Company.exe"
  # Application executable path
  APP_PATH="${STEAM_GAME_LIBRARY_APPS}/common/${APP_SUBPATH}"
  cd "${APP_PATH}"
  # Fully qualified path to application executable
  APP_EXEC_FULL_PATH="${APP_PATH}/${APP_EXEC}"
  # Steam client path
  export STEAM_COMPAT_CLIENT_INSTALL_PATH="${STEAM_GAME_LIBRARY_APPS}"
  # Steam compat data path
  export STEAM_COMPAT_DATA_PATH="${STEAM_GAME_LIBRARY_APPS}/compatdata/${SteamAppId}"
  # Proton path
  PROTON_PATH="${STEAM_HOME_APPS_PATH}/common/${PROTON_VERSION}"
  # Fully-qualified path to Proton executable
  PROTON_EXEC="${PROTON_PATH}/proton"
}

proton-launch-pre-init
proton-launch-user-specific-init
proton-launch-post-init

for i in $(seq 1 ${CONFIG[windowCount]});
do
    # Run the game 
    python3 "${PROTON_EXEC}" run "${APP_EXEC_FULL_PATH}" ${ARGUMENTS} &
done
