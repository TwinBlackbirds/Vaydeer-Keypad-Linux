#!/bin/bash

<<'###OVERVIEW'
 based on a solution i found online that said performing the below cat command gets the keypad to work.
 it does somehow!! they didnt know how it works and neither do i. but it does!
 this script automates the process and can be put in the bashrc so it runs at login.
 (running the commands manually meant closing the terminal made the keypad stop functioning again)

 https://www.reddit.com/r/keyboards/comments/18qms0b/comment/kvvv0a3/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

 and where i found the tutorial to find hidraw devices:
 https://arvchristos.github.io/post/matching-dev-hidraw-devices-with-physical-devices/
###OVERVIEW

[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@" # prompt login for root if terminal isnt auth'd

FILES=/dev/hidraw*

for f in $FILES
do
  FILE=${f##*/}
  DEVICE="$(cat /sys/class/hidraw/${FILE}/device/uevent | grep HID_NAME | cut -d '=' -f2)"
  if [[ $DEVICE =~ "Vaydeer" ]]; then
      sudo cat /dev/$FILE > /dev/null &
  fi
done
