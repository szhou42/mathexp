#include <stdio.h>
#include <windows.h>

 

//红色的是为了让代码能同时用于C和C++( 不加的话,用于c正常,C++可能不正常 )

#ifdef __cplusplus

extern "C" {

#endif


__declspec(dllexport)void _stdcallTest1();

 

#ifdef __cplusplus

  }

#endif /* end of __cplusplus */


