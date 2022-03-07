// To run gcc test_logic.c -o test_logic -lm
// ./test_logic


#include <stdio.h>
#include <math.h>

int main () {
   int n = 16;
   int number_parents = n -1;

   // Creat the rest of the parents from the results of the first pair of parents
    // A batch is all parents from a ceratin level
    int current_batch = n/4;
    int cur_poz_in_parent_array = n/2; // n/2 position in array is free at the moment 
    int j = 0;
    int inner_loop_poz = 0;
    int left_parent_poz = 0;
    int rigth_parent_poz = 0;

    while(current_batch >= 1)
    {
        j = 0;

        printf("\n");
        printf("current_batch = %d\n", current_batch);
        printf("cur_poz_in_parent_array = %d\n", cur_poz_in_parent_array);
        printf("number_parents = %d\n", number_parents);
        printf("\n");

        for (j=0; j < current_batch; j++)
        {
            // Set the pozition of the parents computation
            inner_loop_poz = cur_poz_in_parent_array + j;
            // left_parent_poz = number_parents - cur_poz_in_parent_array + j * 2 - current_batch;
            // rigth_parent_poz = number_parents - cur_poz_in_parent_array + j * 2 + 1 - current_batch;


            left_parent_poz = cur_poz_in_parent_array + j * 2 - current_batch * 2;
            rigth_parent_poz = cur_poz_in_parent_array + j * 2 + 1 - current_batch * 2;

            printf("inner_loop_poz = %d\n", inner_loop_poz);
            printf("left_parent_poz = %d\n", left_parent_poz);
            printf("rigth_parent_poz = %d\n", rigth_parent_poz);


        }
    

        // we go to the next level
        cur_poz_in_parent_array = cur_poz_in_parent_array + current_batch; // This is the next free position 
        // assert(cur_poz_in_parent_array < number_parents); //An extra check just to be sure

        current_batch = current_batch/2;

    }


   return(0);
}