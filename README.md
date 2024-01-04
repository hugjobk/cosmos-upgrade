# Simulate upgrading cosmos blockchain from v0.47.5 to v0.50.0

## Install the binaries

```
git clone git@github.com:cosmos/cosmos-sdk.git
cd cosmos-sdk
git checkout v0.47.5
make build
mkdir -p ../build
cp build/simd ../build/simd
git checkout v0.50.0
make build
mkdir -p ../build/v50
cp build/simd ../build/v50/simd
cd ..
```

## Install http-server

```
npm install -g http-server
```

## Start http-server

```
cd build/v50
http-server -p 8080
```

## Install cosmovisor

```
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest
```

## Start blockchain v0.47.5

```
sh start.sh
```

## Upgrade to v0.50.0

```
sh upgrade.sh
```
