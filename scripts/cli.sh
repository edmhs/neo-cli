#!/usr/bin/expect -f

set timeout -1

cd /neo-cli
spawn dotnet neo-cli.dll --rpc
expect "neo>"
interact