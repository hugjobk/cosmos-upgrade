rm -rf $HOME/.simapp

./build/simd tendermint unsafe-reset-all
./build/simd config chain-id test
./build/simd config keyring-backend test
./build/simd config broadcast-mode sync
./build/simd init test --chain-id test --overwrite
./build/simd keys add validator
./build/simd genesis add-genesis-account validator 1000000000stake --keyring-backend test
./build/simd genesis gentx validator 1000000stake --chain-id test
./build/simd genesis collect-gentxs

cat <<< $(jq '.app_state.gov.params.voting_period = "20s"' $HOME/.simapp/config/genesis.json) > $HOME/.simapp/config/genesis.json

export DAEMON_NAME=simd
export DAEMON_HOME=$HOME/.simapp
export DAEMON_RESTART_AFTER_UPGRADE=true
export DAEMON_ALLOW_DOWNLOAD_BINARIES=true

cosmovisor init ./build/simd
cosmovisor run start
