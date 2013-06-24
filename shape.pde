// Spiral Galaxy Remix
// adapted from http://www.openprocessing.org/sketch/699
 
import gifAnimation.*; // http://www.extrapixel.ch/processing/gifAnimation/
 
float pi=4*atan(1);
 
int DEFAULT_RADIUS = 500;
int DEFAULT_STARSIZE = 18;
float DEFAULT_ERATIO = 0.8;
float DEFAULT_ETWIST = 0.022;
int = DEFAULT_STARS = 8000;
float = DEFAULT_SPEED = 0.05;

int stars; // only ...
int Rmax; // galaxy radius
int triSize;
float speed;  // rotation speed
 
// stars follow elliptic orbits around the center
float eratio; // ellipse ratio
float etwist; // twisting factor (orbit axes depend on radius)
 
float []angle;
float []radius;
 
float cx; float cy; //center
 
color white = color(255, 255, 255, 50); // shapes

void setup()
{
	defaultSetup();
	noLoop();
}
 
void draw(){

	Rmax = width < height ? width / 2 : height / 2; // galaxy radius]
	float ratio = Rmax / DEFAULT_RADIUS;
	// println("Rmax: " + Rmax);
	// println("DEFAULT_RADIUS: " + DEFAULT_RADIUS);
	// println("ratio: " + ratio);
	triSize = DEFAULT_STARSIZE * ratio;
	eratio = DEFAULT_ERATIO;
	etwist = DEFAULT_ETWIST / ratio;
	stars = DEFAULT_STARS;
	speed = DEFAULT_SPEED;
	// println("vars: " + triSize + "; " + eratio + "; " + etwist + "; " + stars + "; " + speed);
	angle = new float[stars];
	radius = new float[stars];

	// begin in the center
	cx = width/2;
	cy = height/2;
	// itit stars
	for (int i=0; i< stars; i++){
		angle[i]= random(0,2*pi);
		radius[i]=random(1,Rmax);
	}

	noStroke();
	fill(white);
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

void defaultSetup()
{
	// size(5000, 5000);
	var newSize = DEFAULT_RADIUS * 2;
	size(newSize, newSize);
	background(34, 37, 57); // clear the canvas
}

void keyPressed() {
  println("code=" + keyCode);

	if(keyCode == UP) { 
		background(34, 37, 57);
		DEFAULT_STARSIZE = triSize+1; 
		println("DEFAULT_STARSIZE: " + DEFAULT_STARSIZE);
		draw();
	}
	if(keyCode == DOWN) {
		background(34, 37, 57);
		DEFAULT_STARSIZE = triSize-1; 
		println("DEFAULT_STARSIZE: " + DEFAULT_STARSIZE);
		draw();
	}
	if(keyCode == LEFT) { 
		background(34, 37, 57);
		DEFAULT_ETWIST = DEFAULT_ETWIST + 0.001; 
		println("DEFAULT_ETWIST: " + DEFAULT_ETWIST);
		draw();
	}
	if(keyCode == RIGHT) { 
		background(34, 37, 57);
		DEFAULT_ETWIST = DEFAULT_ETWIST - 0.001; 
		println("DEFAULT_ETWIST: " + DEFAULT_ETWIST);
		draw();
	}

	// P Key
	if(keyCode == 80) { 
		var newSize = 4000;
		size(newSize, newSize);
		background(34, 37, 57);
		draw();
		// save("export.png");
	}

	// A key
	if(keyCode == 65) {
		var newSize = 3000;
		size(newSize, newSize);
		background(0, 1);
		draw();
		save("export.png");
	}
	
}
