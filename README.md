# neo-cli
NEO Blockchain neo-cli RPC server

https://hub.docker.com/r/edmhs/neo-cli/

NEO cli running inside docker, access to running cli provided using linux "screen", shortcut commands using "make". Default configuration will start synchronize mainnnet.

~~~

# cat Makefile to see shortcut commands


~~~

### Quickstart mainnet

~~~

# clone repo
git clone https://github.com/edmhs/neo-cli.git
cd neo-cli
make run

#check if neo-rpc is working
curl -d '{"jsonrpc": "2.0", "method": "getblockcount", "params": [], "id": 5}'  http://localhost:10332

# To access neo cli (To detach from screen and keep it running (CTRL+A then CTRL+D))
make cli

~~~