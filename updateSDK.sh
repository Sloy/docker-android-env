#!/bin/sh
expect -c '
set timeout -1   ;
spawn sudo /opt/android-sdk-linux/tools/android update sdk --no-ui --all --filter "platform-tools,build-tools-23.0.2,android-23,extra-android-m2repository,extra-google-m2repository"; 
expect { 
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'