pragma circom 2.0.0; //Circom version specification

// Import the hash algorithm
include "../circomlib/circuits/mimcsponge.circom";

//Create a template 

// Check if we have a perfect merkle tree leafs power of 2
function check_if_power_of_2(m)
{
    var i = 1;
    while ( i <= m)
    {
        if(i==m)
        {
            return 1;
        }
        i = 2 * i;
    }

    return 0;
}

template merkle_element()
{
    signal input left_child;
    signal input right_child;
    signal output parent;

    component memory_components = MiMCSponge(2, 220, 1);
    memory_components.k <== 0;
    memory_components.ins[0] <== left_child;
    memory_components.ins[1] <== right_child;

}

template merkle_root(n) {  

    //define the leaves 
    signal input leaves[n]; 

    //A tree with n leaves will have 2*n - 1 "parents"(not leaves) in whole tree. True for power of 2.
    // we will calculate on the first position the root 
    number_parents = 2*n-1;
    component parents[number_parents];
    var input_is_power_of_2 = check_if_power_of_2(n);

    //output
    signal output root;

    //Check if is power of 2 and log error otherwise
    log(n);
    assert(input_is_power_of_2 == 1);

    //Instantiate 
    var i =0;
    for (i=0; i < n/2; i++) {
        parents[i] = merkle_element()
    }

    // create the first pair of parents
    for (i=0; i < n/2; i++) {
        parents[i].left_child = leaves[i*2];
        parents[i].right_child = leaves[i*2+1];
    }

    // Creat the rest of the parents from the results of the first pair of parents
    // A batch is all parents from a ceratin level
    var current_batch = n/2;
    var cur_poz_in_parent_array = n/2; // n/2 position in array is free at the moment 
    var j = 0;
    while(current_batch > 1)
    {
        j = 0;
        for (j=0; j < current_batch/2; j++)
        {
            parents[i].left_child = parents[i];
            parents[i].right_child = parents[i];
        }
    

        // we go to the next level
        cur_poz_in_parent_array = cur_poz_in_parent_array + current_batch; // This is the next free position 
        assert(cur_poz_in_parent_array < number_parents); //An extra check just to be sure

        current_batch = current_batch/2;

    }


}

// Call the template or you could say initialize the template
component main {public [leaves]} = merkle_root(4);