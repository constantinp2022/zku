# !/bin/bash

# 1. Compile the *.circom file
# You can see in the compile file *.json the constrain info ..

#It looks like id does not work like in video possibly because of migration to version 2
# the commands gets: "" invalid output path |> previous errors were found ""
# circom multiplier.circom -o multiplier.json
circom multiplier.circom --r1cs --wasm --sym
#Further explanation
    # --r1cs: generates multiplier.r1cs (the r1cs constraint system of the multiplier in binary format).
    # --wasm: generates multiplier.wasm (the wasm code to generate the witness).
    # --sym: generates multiplier.sym (a symbols file required for debugging and printing the constraint system in an annotated mode).
# r1cs (or rank-1 constraint system) is the first step in converting an algebraic multiplier into a zk-snark.
# Link https://medium.com/@VitalikButerin/quadratic-arithmetic-programs-from-zero-to-hero-f6d558cea649


# you can see the info by running
# snarkjs info -r multiplier.r1cs -- Does not work

# RUN THIS
# snarkjs info -r multiplier.r1cs

# 2. Setup using snarkjs
# Create a trusted setup for our multiplier. This will generate both a proving and a verification key 
# in the form of two files: proving_key.json and verification_key.json
snarkjs setup -r multiplier.r1cs

##THE END THIS EXAMPLE IS NOT RELIABLE AS THE snarkjs seems to be modified quite a lot 




