Errors encounter when running a 8 leaf merkle tree

1 ERROR
    Not all inputs have been set. Only 4 out of 8
    merkle: main.cpp:212: int main(int, char**): Assertion `false' failed.
    ./run_circum.sh: line 37:  7446 Aborted                 (core dumped) ./merkle ../input.json witness.wtns

    Reprezented by running:
    cd merkle_cpp
    # Make to compile the cpp code that generates witness
    make

    # Run the executable and generate the witness
    ./merkle ../input.json witness.wtns # THIS FAILED on an assertion

    code main.cpp:212 
        loadJson(ctx, jsonfile);
        if (ctx->getRemaingInputsToBeSet()!=0) {
            std::cerr << "Not all inputs have been set. Only " << get_main_input_signal_no()-ctx->getRemaingInputsToBeSet() << " out of " << get_main_input_signal_no() << std::endl;
            assert(false);
        }

1. SOLUTION
    My input.json had only 4 elemnts in array :(

2. ERROR

    [ERROR] snarkJS: circuit too big for this power of tau ceremony. 9240*2 > 2**12
    [ERROR] snarkJS: Error: merkle_0000.zkey: Invalid File format
        at Object.readBinFile (/usr/local/lib/node_modules/snarkjs/node_modules/@iden3/binfileutils/build/main.cjs:36:35)
        at async phase2contribute (/usr/local/lib/node_modules/snarkjs/build/cli.cjs:4874:45)
        at async clProcessor (/usr/local/lib/node_modules/snarkjs/build/cli.cjs:300:21)
    [ERROR] snarkJS: [Error: ENOENT: no such file or directory, open 'merkle_0001.zkey'] {
    errno: -2,
    code: 'ENOENT',
    syscall: 'open',
    path: 'merkle_0001.zkey'
    }
    [ERROR] snarkJS: [Error: ENOENT: no such file or directory, open 'merkle_0001.zkey'] {
    errno: -2,
    code: 'ENOENT',
    syscall: 'open',
    path: 'merkle_0001.zkey'
    }
    [ERROR] snarkJS: Error: ENOENT: no such file or directory, open 'verification_key.json'
        at Object.openSync (node:fs:585:3)
        at Object.readFileSync (node:fs:453:35)
        at Object.groth16Verify [as action] (/usr/local/lib/node_modules/snarkjs/build/cli.cjs:8332:82)
        at clProcessor (/usr/local/lib/node_modules/snarkjs/build/cli.cjs:302:31)
        at Object.<anonymous> (/usr/local/lib/node_modules/snarkjs/build/cli.cjs:8127:1)
        at Module._compile (node:internal/modules/cjs/loader:1097:14)
        at Object.Module._extensions..js (node:internal/modules/cjs/loader:1151:10)
        at Module.load (node:internal/modules/cjs/loader:975:32)
        at Function.Module._load (node:internal/modules/cjs/loader:822:12)
        at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:77:12) {
    errno: -2,
    syscall: 'open',
    code: 'ENOENT',
    path: 'verification_key.json'
    }
2. SOLUTION https://github.com/iden3/snarkjs/issues/123 eigmax response
        https://github.com/iden3/snarkjs/issues/123

3. ERROR
    [ERROR] snarkJS: Error: Power must be between 1 and 28
    at Object.powersOfTauNew [as action] (/usr/local/lib/node_modules/snarkjs/build/cli.cjs:8460:15)
    at clProcessor (/usr/local/lib/node_modules/snarkjs/build/cli.cjs:300:31)
    at Object.<anonymous> (/usr/local/lib/node_modules/snarkjs/build/cli.cjs:8127:1)
    at Module._compile (node:internal/modules/cjs/loader:1097:14)
    at Object.Module._extensions..js (node:internal/modules/cjs/loader:1151:10)
    at Module.load (node:internal/modules/cjs/loader:975:32)
    at Function.Module._load (node:internal/modules/cjs/loader:822:12)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:77:12)
    at node:internal/main/run_main_module:17:47

3. SOLUTION
    PUT 28

4. ERROR
    the execution took too much
4. SOLUTION
    use 15 