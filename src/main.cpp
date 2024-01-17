#ifdef _DRIVER_OGL3
#include "driver_ogl3.h"
#endif

// Main code
int main(int, char**)
{
    OGL3_DRIVER driver;
    if(!driver.init_driver())
        return 1;
    
    driver.loop();

    driver.clean_driver();

    return 0;
}