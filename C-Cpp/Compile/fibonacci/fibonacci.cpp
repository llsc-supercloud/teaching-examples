
#include <stdio.h>
#include <iostream>
#include <cstdlib>
#include <fstream>

using namespace std;
 
int main(int argc, char *argv[])
{
   int n=4;  /* default value */
   int first = 0, second = 1, next, c;

   /* check to see that arguments came in through command line */
   if (argc !=2)
   {
    cout << "no input arguments, using default values, number of integers = " << n << endl;
   }
   else
   {
    n = atoi(argv[1]);
    cout << "number of integers = " << n << endl;
   }

   printf("First %d terms of Fibonacci series are :\n",n);
 
   for ( c = 0 ; c < n ; c++ )
   {
      if ( c <= 1 )
         next = c;
      else
      {
         next = first + second;
         first = second;
         second = next;
      }
      printf("%d\n",next);
   }

   return 0;
}
