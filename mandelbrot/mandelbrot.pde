import peasy.*;

int DIM=128;
PeasyCam cam;

ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

void setup(){
  size(900,800,P3D);
  //windowMove(400, 100);
  cam = new PeasyCam(this,2500);
  
  for(int i=0;i<DIM;i++){
    for(int j=0;j<DIM;j++){
      
      boolean edge = false;
      for (int k=0;k<DIM;k++){
        float x= map(i,0,DIM,-1,1);
        float y= map(j,0,DIM,-1,1);
        float z= map(k,0,DIM,-1,1);
        
        
        PVector zeta = new PVector(0,0,0);
        int n = 50;
        
        int maxit = 5;
        int it = 0;
        while(true){
          //zeta = pow(zeta,n)+c;
          
          Spherical sz= spherical(zeta.x,zeta.y,zeta.z); 
                  
          float nx = pow(sz.r,n)*sin(sz.theta*n)*cos(sz.phi*n);
          float ny = pow(sz.r,n)*sin(sz.theta*n)*cos(sz.phi*n);
          float nz = pow(sz.r,n)*cos(sz.theta*n);
          
          zeta.x=nx+x;
          zeta.y=ny+y;
          zeta.z=nz+z;
          it++;
          
          if(sz.r>16){
            if(edge){
              edge=false;
            }
          break;
        }
                  
          if(it>maxit){
            if(!edge){
              edge=true;
              mandelbulb.add(new PVector(x*100,y*100,z*100));
            }
          break;
        }
        }
        
        
      }
    }
  } 
}

class Spherical{
  float r;
  float theta;
  float phi;
  Spherical(float r, float theta, float phi){
    this.r=r;
    this.theta=theta;
    this.phi=phi;
  }
}

Spherical spherical(float x, float y, float z){
          float r = sqrt(x*x+y*y+z*z);
          float theta = atan2(sqrt(x*x+y*y),z);
          float phi = atan2(y,x);
          return new Spherical(r,theta,phi);
}

void draw(){
  background(0);
  translate(width/2,height/2); 
   
  for(PVector v: mandelbulb){
      stroke(255);
      point(v.x,v.y,v.z);
  }
}
