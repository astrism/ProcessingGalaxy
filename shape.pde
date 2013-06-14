// Spiral Galaxy Remix
// adapted from http://www.openprocessing.org/sketch/699
 
import gifAnimation.*; // http://www.extrapixel.ch/processing/gifAnimation/
 
float pi=4*atan(1);
 
int stars=4000; // only ...
int Rmax=document.width < document.height ? document.width / 2 : document.height / 2; // galaxy radius
int triSize = 20;
float speed=0.05;  // rotation speed
 
// stars follow elliptic orbits around the center
float eratio=.7; // ellipse ratio
float etwist=8.0/Rmax; // twisting factor (orbit axes depend on radius)
 
float []angle=new float[stars];
float []radius=new float[stars];
 
float cx; float cy; //center
 
color white = color(100, 175, 175, 85); // shapes
PImage textureImage;

void setup()
{
	size(document.width, document.height);
	background(34, 37, 57); // clear the canvas

	// begin in the center
	cx = width/2;
	cy = height/2;
	// itit stars
	for (int i=0; i< stars; i++){
		angle[i]= random(0,2*pi);
		radius[i]=random(1,Rmax);
	}


    textureImage = loadImage("sxc1337673_22204404.jpg");

	noLoop();
}
 
void draw(){
  noStroke();
  fill(white);
  alpha(white);
  for (int i =0; i< stars; i++){
	float r=radius[i];
	float a=angle[i]+speed; // increment angle
	angle[i]=a;
	float x = r*sin(a);
	float y= r*eratio*cos(a);
	float b=r*etwist;
	float s=sin(b);
	float c=cos(b);
	float newX = cx+s*x+c*y;
	float newY = cy+c*x-s*y;
	newX = floor(newX / triSize) * triSize;
	newY = floor(newY / triSize) * triSize;

	drawTriangle(newX, newY);
	
  }
}

void drawTriangle(float newX, float newY) {
	int rand = int(random(0, 3));
	switch (rand){
		case 3 :
			triangle(newX, newY, 
					newX + triSize, newY, 
					newX + triSize, newY + triSize);
			break;
		case 2 :
			triangle(newX + triSize, newY + triSize,
					newX, newY + triSize, 
					newX, newY);
			break;
		case 1 :
			triangle(newX + triSize, newY, 
					newX + triSize, newY + triSize, 
					newX, newY + triSize);
			break;
		case 0 :
		default :
			triangle(newX, newY, 
					newX + triSize, newY, 
					newX + triSize, newY + triSize);
			break;
	}
	// tl: x, y
	// tr: x + triSize, y
	// br: x + triSize, y + triSize
	// bl: x, y + triSize
}

void keyPressed() {
  println("code=" + keyCode);

  if(keyCode == UP) { eratio=eratio+0.1; draw();}
  if(keyCode == DOWN) { eratio=eratio-0.1; draw();}
  if(keyCode == LEFT) { etwist=etwist+0.0001; draw();}
  if(keyCode == RIGHT) { etwist=etwist-0.0001; draw();}
  if(keyCode == 80) { 
  	background(34, 37, 57);
  	draw();
  	save("export.png");
  }
  if(keyCode == 65) {
  	background(0, 0);
  	draw();
  	save("export.png");
  }
  
}
