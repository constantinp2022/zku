pragma circom 2.0.0;

template Multiplier() {

    signal input x;  //This are hidden from verifier unless specified otherwise in the component
    signal input y;  //This are hidden from verifier unless specified otherwise in the component
    signal output prod;

    prod <== x*y;

    // prod <== x*y //assigment simbol
    // prod === x*y //equality simbol

}

component main = Multiplier();