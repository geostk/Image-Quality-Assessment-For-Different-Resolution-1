// openGLplayer.cpp : entrance of console
//

#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "glut.h"
#include <string>
#include <iostream>
#include "TextureManager.h"
#include <fstream>

using  std::string;
using namespace std;

#define IMG_PATH "E:/images/test/"

static GLubyte* allPixelData[1000];

int fileNum = 1;

ofstream rateresult("E:/images/rate_result/person1/rate_result_720.txt");

static GLint     ImageWidth;
static GLint     ImageHeight;
static GLint     PixelLength;
GLubyte* PixelData;

static GLfloat angle = 0.0f;

void ReadAllImage(int &width, int &height)
{
	char name[50] = IMG_PATH;
	strcat(name, "");
	char num[10];
	int number = 1;
	FILE* pFile = NULL;
	while (1)
	{
		strcpy(name, IMG_PATH);
		strcat(name, _itoa(number, num, 10));
		strcat(name, ".bmp");
		cout << name << endl;
		pFile = fopen(name, "rb");


		if (pFile == NULL)
		{
			break;
		}

		// read the size of image
		fseek(pFile, 0x0012, SEEK_SET);
		fread(&ImageWidth, sizeof(ImageWidth), 1, pFile);
		fread(&ImageHeight, sizeof(ImageHeight), 1, pFile);

		//return the image size
		width=ImageWidth;
		height=ImageHeight;

		// calculate the length of pixel
		PixelLength = ImageWidth * 3;
		while (PixelLength % 4 != 0)
			++PixelLength;
		PixelLength *= ImageHeight;

		// read pixel
		PixelData = (GLubyte*)malloc(PixelLength);
		if (PixelData == 0)
			printf("dead");

		fseek(pFile, 54, SEEK_SET);
		fread(PixelData, PixelLength, 1, pFile);

		allPixelData[number] = PixelData;

		number++;
	}
}

void myDisplayBmp(void)
{
	//all image displayed, exit
	if (allPixelData[fileNum] == NULL)
	{
		rateresult.close();
		exit(0);
	}
	
	glDrawPixels(ImageWidth, ImageHeight,
		GL_BGR_EXT, GL_UNSIGNED_BYTE, allPixelData[fileNum]);

	glutSwapBuffers();
	
}

void myIdleBmp(void)
{
	int score;
	myDisplayBmp();
	//request for rate
	cout << "Please rate the image: ";
	cin >> score;
	cout << score << endl;
	rateresult << score << endl;
	fileNum++;
}


GLuint texture[1];

int main(int argc, CHAR* argv[])
{
	int width,height;
	ReadAllImage(width,height);
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
	glutInitWindowPosition(100, 100);
	glutInitWindowSize(width,height);
	glutCreateWindow("OpenGL");
	glutDisplayFunc(&myDisplayBmp);
	glutIdleFunc(&myIdleBmp);
	glutMainLoop();
	return 0;
}

