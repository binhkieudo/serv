//============================================================================
// Name        : main.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello RISC-V World in C++
//============================================================================

#include <iostream>
using namespace std;

//
// Demonstrate how to print a greeting message on standard output
// and exit.
//
// WARNING: This is a build-only project. Do not try to run it on a
// physical board, since it lacks the device specific startup.
//
// If semihosting is not available, use `--specs=nosys.specs` during link.
//

int
main()
{
  cout << "Hello RISC-V World!" << endl;
  return 0;
}
