# !/bin/bash

rm circuit.r1cs  #Remove previously generated files
rm circuit.sym
rm circuit_*
rm -r circuit_*
rm pot*
rm proof.json
rm public.json
rm verifier.sol
rm verification_key.json
rm witness.wtns
rm parameters.txt


# Compiles the circom circuit to get a system of arithmetic equati1ons representing the circuit
#--r1cs generates a file that contains the r1cs constraint system of circuit in binary format
# --wasm generates wasm code that can be used to generate witness
# --c gene rates c code that can be used to generate witness
# --sym generates symbols file that can be used for debugging  # This is the run command for circom
circom circuit.circom --r1cs --wasm --sym --c


if [[ $* == *--nodejs* ]]
then
    echo "Using nodejs"
    cd circuit_js
    node generate_witness.js circuit.wasm ../input.json witness.wtns
else
    echo "Using cpp"
    cd circuit_cpp
    # Make to compile the cpp code that generates witness
    make

    # Run the executable and generate the witness
    ./circuit ../input.json witness.wtns
fi

cp witness.wtns ../witness.wtns
cd ..

# Use snarkjs to generate and validate a proof
# The groth16 zk-snark protocol requires a trusted setup for each circuit which consists of
# 1. Powers of tau

# Create new powersoftau ceremonyy
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v

# Contribute to the created ceremony
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v -e=" random text"

# 2. Phase 2
# Prepare for start of phase 2
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -V

# Generate zkey file that contains the proving and verification keys together with phase 2 contributions
snarkjs groth16 setup circuit.r1cs pot12_final.ptau circuit_0000.zkey
snarkjs zkey contribute circuit_0000.zkey circuit_0001.zkey --name="1st Contributor Name" -v -e="random text"

# Export verification key to json file
snarkjs zkey export verificationkey circuit_0001.zkey verification_key.json

# Generate a zero knowLedge proof using the Zkey and witness
# This outputs a proof file and a public file containing public inputs and outputs
snarkjs groth16 prove circuit_0001.zkey witness.wtns proof.json public.json

#Use the verification key, proof and public file to verify if proof is valid
snarkjs groth16 verify verification_key.json public.json proof.json

#snarkjs zkey export solidityverifier circuit_0001.zkey verifier.sol

#Generate and print parameters of call
#snarkjs generatecall | tee parameters.txt