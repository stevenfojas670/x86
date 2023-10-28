// ----------------------------------------------------------------------
//  CS 218 -> Assignment #10
//  Spirograph Program.
//  Provided main.
//  Uses openGL (which must be installed).
//  openGL installation:
//	sudo apt-get update
//	sudo apt-get upgrade
//	sudo apt-get install libgl1-mesa-dev
//	sudo apt-get install freeglut3 freeglut3-dev
//  Compilation:
//	g++ -Wall -pedantic -g -c spiro.cpp -lglut -lGLU -lGL -lm

// ----------------------------------------------------------------------

#include <cstdlib>
#include <iostream>
#include <GL/gl.h>
#include <GL/glut.h>
#include <GL/freeglut.h>

using	namespace	std;

// ----------------------------------------------------------------------
//  External functions (in seperate file).

extern "C" void drawSpiro();
extern "C" int getRadii(int, char* [], int *, int *, int *, int *, char *);

// ----------------------------------------------------------------------
//  Global variables
//	Must be globally accessible for the openGL
//	display routine, drawSpiro().

int	radius1 = 0;		// radius 1, dword, integer valu
int	radius2 = 0;		// radius 2, dword, integer value
int	offPos = 0;		// offset position, dword, integer value
int	speed = 0;		// rotation, dword, integer value
char	color = ' ';		// color code letter, byte, ASCII value

// ----------------------------------------------------------------------
//  Key handler function.
//	Terminates for 'x', 'q', or ESC key.
//	Ignores all other characters.

void	keyHandler(unsigned char key, int x, int y)
{
	if (key == 'x' || key == 'q' || key == 27) {
		glutLeaveMainLoop();
		exit(0);
	}
}

// ----------------------------------------------------------------------
//  Main routine.

int main(int argc, char* argv[])
{
	int	width = 800;			// change as desired
	int	height = 800;
	bool	stat;

	stat = getRadii(argc, argv, &radius1, &radius2, &offPos,
						&speed, &color);

	// Debug call for display function
	//drawSpiro();

	if (stat) {
		glutInit(&argc, argv);
		glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
		glutInitWindowSize(width, height);
		glutInitWindowPosition(200, 100);
		glutCreateWindow("CS 218 Assignment #10 - Spirograph Program");
		glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrtho(-400.0, 400.0, 400.0, -400.0, -1.0, 1.0);
	
		glutKeyboardFunc(keyHandler);
		glutDisplayFunc(drawSpiro);

		glutMainLoop();
	}

	return	EXIT_SUCCESS;
}

