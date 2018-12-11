# neo-cli Docker
NEO Blockchain neo-cli RPC server

https://hub.docker.com/r/edmhs/neo-cli/

NEO cli running inside docker, access to running cli provided using linux "screen", shortcut commands using "make". Default configuration will start synchronize mainnnet.

~~~sh

# cat Makefile to see shortcut commands
cat Makefile

~~~

### Quickstart mainnet

~~~sh

# clone repo
git clone https://github.com/edmhs/neo-cli.git
cd neo-cli

# pull image from docker hub
docker pull edmhs/neo-cli

# start cli node
make run

#check if neo-rpc is working
curl -d '{"jsonrpc": "2.0", "method": "getblockcount", "params": [], "id": 5}'  http://localhost:10332

# To access neo cli (To detach from screen and keep it running (CTRL+A then CTRL+D))
make cli

~~~

### Custom NEO chain

~~~sh

# clone repo
git clone https://github.com/edmhs/neo-cli.git
cd neo-cli

# edit config/protocol.json
# change these things:
# - Magic (This for each chain is different)
# - StandbyValidators (Public keys for masternode wallets)
# - SeedList (Seed list for privatr chain)

# edit docker-compose.yml
# - change volume folders, folders are changed when changing "Magic" in prototcol , (from _00746E41 to HEX(magic), Hex -signed 2's complement)

# pull image from docker hub
docker pull edmhs/neo-cli

# start cli node
make run

#check if neo-rpc is working
curl -d '{"jsonrpc": "2.0", "method": "getblockcount", "params": [], "id": 5}'  http://localhost:10332

# To access neo cli (To detach from screen and keep it running (CTRL+A then CTRL+D))
make cli

~~~

