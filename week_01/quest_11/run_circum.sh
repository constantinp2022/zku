# !/bin/bash

rm merkle.r1cs  #Remove previously generated files
rm merkle.sym
rm merkle_*
rm -r merkle_*
rm pot*
rm proof.json
rm public.json
rm verifier.sol
rm verification_key.json
rm witness.wtns
rm parameters.txt


# Compiles the circom merkle to get a system of arithmetic equati1ons representing the merkle
#--r1cs generates a file that contains the r1cs constraint system of merkle in binary format
# --wasm generates wasm code that can be used to generate witness
# --c gene rates c code that can be used to generate witness
# --sym generates symbols file that can be used for debugging  # This is the run command for circom
circom merkle.circom --r1cs --wasm --sym --c


if [[ $* == *--nodejs* ]]
then
    echo "Using nodejs"
    cd merkle_js
    node generate_witness.js merkle.wasm ../input.json witness.wtns
else
    echo "Using cpp"
    cd merkle_cpp
    # Make to compile the cpp code that generates witness
    make

    # Run the executable and generate the witness
    ./merkle ../input.json witness.wtns
fi

cp witness.wtns ../witness.wtns
cd ..

# Use snarkjs to generate and validate a proof
# The groth16 zk-snark protocol requires a trusted setup for each merkle which consists of
# 1. Powers of tau

# Create new powersoftau ceremonyy
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v

# Contribute to the created ceremony
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v -e=" random text"

# 2. Phase 2
# Prepare for start of phase 2
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -V

# Generate zkey file that contains the proving and verification keys together with phase 2 contributions
snarkjs groth16 setup merkle.r1cs pot12_final.ptau merkle_0000.zkey
snarkjs zkey contribute merkle_0000.zkey merkle_0001.zkey --name="1st Contributor Name" -v -e="random text"

# Export verification key to json file
snarkjs zkey export verificationkey merkle_0001.zkey verification_key.json

# Generate a zero knowLedge proof using the Zkey and witness
# This outputs a proof file and a public file containing public inputs and outputs
snarkjs groth16 prove merkle_0001.zkey witness.wtns proof.json public.json

#Use the verification key, proof and public file to verify if proof is valid
snarkjs groth16 verify verification_key.json public.json proof.json

#snarkjs zkey export solidityverifier merkle_0001.zkey verifier.sol

#Generate and print parameters of call
#snarkjs generatecall | tee parameters.txt