/*
 ============================================================================
 Name        : main.c
 Author      : 
 Version     :
 Copyright   : Your copyright notice
 Description : Hello RISC-V World in C
 ============================================================================
 */

/*
 * Demonstrate how to print a greeting message on standard output
 * and exit.
 *
 * WARNING: This is a build-only project. Do not try to run it on a
 * physical board, since it lacks the device specific startup.
 *
 * If semihosting is not available, use `--specs=nosys.specs` during link.
 */

const unsigned int DELAY = 0x100000;

int
main(void)
{
  unsigned int* pLed = (unsigned int*)0x80000000;

  int i;
  int ledVal = 0;

  *pLed = 0x0;

  while (1) {
	  for (i = 0; i < DELAY; i = i + 1);
	  ledVal = ledVal ^ 0x00000001;
	  *pLed = ledVal;
  }

  return 0;
}
