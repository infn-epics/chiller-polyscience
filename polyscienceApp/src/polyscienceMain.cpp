/* polyscienceMain.cpp
 * Main program for Polyscience Chiller IOC
 */

#include <stddef.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <stdio.h>

#include "epicsExit.h"
#include "epicsThread.h"
#include "iocsh.h"

int main(int argc, char *argv[])
{
    if (argc >= 2) {
        iocsh(argv[1]);
        epicsThreadSleep(0.2);
    }
    iocsh(NULL);
    epicsExit(0);
    return 0;
}
