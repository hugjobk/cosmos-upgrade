cd build/v50
zip -r simd.zip simd
export BIN_HASH=$(sha256sum simd.zip | cut -d ' ' -f 1)
envsubst < ../../simd-info.template.json > simd-info.json
export INFO_HASH=$(sha256sum simd-info.json | cut -d ' ' -f 1)
cd ../..
envsubst < upgrade-proposal.template.json > upgrade-proposal.json

./build/simd tx gov submit-proposal ./upgrade-proposal.json --from validator --yes
sleep 6
./build/simd tx gov deposit 1 10000000stake --from validator --yes
sleep 6
./build/simd tx gov vote 1 yes --from validator --yes
