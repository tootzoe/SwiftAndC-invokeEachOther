//
//  myCfunc.c
//  SwiftAndC-invokeEachOther
//
//  Created by thor on 13/3/24
//  
//
//  Email: toot@tootzoe.com  Tel: +855 69325538 
//
//

#include <stdint.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

#include "myCfunc.h"




 
 
 


int myAddFunc(int x)  // this function can be called by Swift5
{ 
    while(x < 20)
    {
        printf("x: %d\n", x);
       x = callbackInSwift5(x);  // this function is from Swift5
        usleep(2000000);
    }
    
    return  0;
}
