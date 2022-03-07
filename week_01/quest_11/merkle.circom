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

    //A tree with n leaves will have n - 1 "parents"(not leaves) in whole tree. 
    // we will calculate on the first position the root 
    var number_parents = n-1;
    component parents[number_parents];
    var input_is_power_of_2 = check_if_power_of_2(n);

    //output
    signal output root;

    //Check if is power of 2 and log error otherwise
    log(n);
    assert(input_is_power_of_2 == 1);

    //Instantiate 
    var i =0;
    for (i = 0; i < number_parents; i++) {
        parents[i] = merkle_element();
    }

    // create the first pair of parents
    // Current batch is nthe number of elemts on the current level
    var current_batch = n/2;
    for (i=0; i < n/2; i++) {
        parents[i].left_child <== leaves[i*2];
        parents[i].right_child <== leaves[i*2+1];
    }

    // Creat the rest of the parents from the results of the first pair of parents
    // A batch is all parents from a ceratin level
    current_batch = current_batch/2;
    var cur_poz_in_parent_array = n/2; // n/2 position in array is free at the moment 
    var j = 0;
    var inner_loop_poz = 0;
    var left_parent_poz = 0;
    var rigth_parent_poz = 0;

    // up to the root found batch >= 1 repeat 
    while(current_batch >= 1)
    {
        j = 0;
        for (j=0; j < current_batch; j++)
        {
            // Set the pozition of the parents computation
            inner_loop_poz = cur_poz_in_parent_array + j; // It you vizualize the merkle tree as a triangle this is the left line
            left_parent_poz = cur_poz_in_parent_array + j * 2 - current_batch * 2; // we go back one batch
            rigth_parent_poz = cur_poz_in_parent_array + j * 2 + 1 - current_batch * 2; // we go back one batch + 1
            
            parents[inner_loop_poz].left_child <== parents[left_parent_poz].parent;
            parents[inner_loop_poz].right_child <== parents[rigth_parent_poz].parent;
        }
    

        // we go to the next level
        cur_poz_in_parent_array = cur_poz_in_parent_array + current_batch; // This is the next free position 
        // assert(cur_poz_in_parent_array < number_parents); //An extra check just to be sure

        current_batch = current_batch/2;

    }

    // In this case the array was saved as n_leanfs goes to an array of n_leanfs - 1 
    // First n_leanfs/2 positions are the hashes of the leafs
    // Second n_leanfs/2/2 position are the hashes of hashes

    root <== parents[number_parents - 1].parent; // the top parent is the root 


}

// Call the template or you could say initialize the template
component main {public [leaves]} = merkle_root(4);