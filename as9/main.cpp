// CS 218 - Provided C++ program
//	This programs calls assembly language routines.

//  NOTE: To compile this program, and produce an object file
//	must use the "g++" compiler with the "-c" option.
//	Thus, the command "g++ -c main.c" will produce
//	an object file named "main.o" for linking.

//  Must ensure g++ compiler is installed:
//	sudo apt-get install g++

// ***************************************************************************

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <string>
#include <iomanip>

using namespace std;

#define MAX_INPUT_LENGTH 1000
#define MIN_INPUT_LENGTH 3

#define SUCCESS 0
#define NOSUCCESS 1
#define OUTOFRANGEMIN 2
#define OUTOFRANGEMAX 3
#define INPUTOVERFLOW 4
#define ENDOFINPUT 5


// ***************************************************************
//  Prototypes for external functions.
//	The "C" specifies to use the C/C++ style calling convention.

extern "C" int readSenaryNum(int *);
extern "C" void oddEvenSort(int[], int);
extern "C" void listStats(int[], int, int *, int *, int *, int *, int *);
extern "C" int estimatedMedian(int[], int);
extern "C" int estimatedSkew(int[], int, int);


// ***************************************************************
//  Begin a basic C++ program.
//	Notes, does not use any objects.

int main()
{

// --------------------------------------------------------------------
//  Declare variables and simple display header
//	By default, C++ integers are doublewords (32-bits).

	string	bars;
	bars.append(50,'-');

	int	i, status, newNumber;
	int	list[MAX_INPUT_LENGTH];
	int	len = 0;
	int	iMin, iMax, iMed, iSum, iAve;
	int	iEstMed;
	int	iSkew;
	bool	endOfNumbers = false;

	cout << bars << endl;
	cout << "CS 218 - Assignment #9" << endl << endl;

// --------------------------------------------------------------------
//  Loops to read numbers from user.

	while (!endOfNumbers && len<MAX_INPUT_LENGTH) {

		cout << "Enter Senary Value (base-6): ";
		fflush(stdout);
		status = readSenaryNum(&newNumber);

		switch (status) {
			case SUCCESS:
				list[len] = newNumber;
				len++;
				break;
			case NOSUCCESS:
				cout << "Error, invalid number. ";
				cout << "Please re-enter." << endl;
				break;
			case OUTOFRANGEMIN:
				cout << "Error, number below minimum value. ";
				cout << "Please re-enter." << endl;
				break;
			case OUTOFRANGEMAX:
				cout << "Error, number above maximum value. ";
				cout << "Please re-enter." << endl;
				break;
			case INPUTOVERFLOW:
				cout << "Error, user input exceeded " <<
					"length, input ignored. ";
				cout << "Please re-enter." << endl;
				break;
			case ENDOFINPUT:
				endOfNumbers = true;
				break;
			default:
				cout << "Error, invalid return status, ";
				cout << "programer fail..." << endl;
				cout << "Program terminated" << endl;
				exit(EXIT_FAILURE);
				break;
		}
		if (len > MAX_INPUT_LENGTH)
			break;
	}

// --------------------------------------------------------------------
//  Ensure some numbers were read and, if so, display results.

	if (len < MIN_INPUT_LENGTH) {
		cout << "Error, not enough numbers entered." << endl;
		cout << "Program terminated." << endl;
	} else {
		cout << bars << endl;
		cout << endl << "Program Results" << endl << endl;

		iEstMed = estimatedMedian(list, len);

		oddEvenSort(list, len);
		listStats(list, len, &iMin, &iMax, &iMed, &iSum, &iAve);
		iSkew = estimatedSkew(list, len, iAve);

		cout << "Sorted List: " << endl;
		for ( i = 0; i < len; i++) {
			cout << list[i] << "  ";
			if ( (i%10)==9 || i==(len-1) ) cout << endl;
		}
		cout << endl;
		cout << "      Length =  " << setw(12) << len << endl;
		cout << "     Minimum =  " << setw(12) << iMin << endl;
		cout << "      Median =  " << setw(12) << iMed << endl;
		cout << "     Maximum =  " << setw(12) << iMax << endl;
		cout << "         Sum =  " << setw(12) << iSum << endl;
		cout << "     Average =  " << setw(12) << iAve << endl;
		cout << " Est. Median =  " << setw(12) << iEstMed << endl;
		cout << "   Est. Skew =  " << setw(12) << iSkew << endl;
		cout << endl;
	}

// --------------------------------------------------------------------
//  All done...

	return	EXIT_SUCCESS;
}

