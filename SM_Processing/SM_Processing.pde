int radiusL = 50, size = 100, level = 5;
float radiusS = 0.25, zoom;
float[][][][] circles;

void setup() {
  fullScreen(P3D);
  //size(1920, 300, P3D);
  noiseDetail(10);
  sphereDetail(6);
  zoom = sqrt((float)width/height);
  FindComp();
  Circle();
}

float x, y, easing = 0.05, seal;
void draw() {
  background(0);

  Split();

  seal = millis()/2000.0;

  if (IMUa != null && IMUa[0]!="Hello") {
    try {
      x = abs(Float.valueOf(IMUa[0])*Float.valueOf(IMUa[2]))*50;
      y = abs(Float.valueOf(IMUa[1])*Float.valueOf(IMUa[2]))*50;
    }
    catch(Exception e) {
    }
  }

  if (JS != null)
  try {
    radiusS = map(abs(Float.valueOf(JS[0])), 0, 512, 0, 5)*map(abs(Float.valueOf(JS[1])), 0, 512, 0, 5);
  }
  catch(Exception e) {
  }
  if (radiusS<0.25)
    radiusS=0.25;

  if (IMUg != null && IMUg[0]!="Hello" )
  try {
    camera(200*cos(Float.valueOf(IMUg[0])*PI)/zoom, 100*sin(Float.valueOf(IMUg[2])*PI)/zoom, 200*cos(Float.valueOf(IMUg[1])*PI)/zoom, 0, 0, 0, 1, 1, -1);
  }
  catch(Exception e) {
  }
  ambientLight(100, 100, 100);
  directionalLight(255, 255, 255, -1, -1, -1);
  pointLight(255, 255, 100, 0, 0, 0);

  Seal();
}

//=========={ 建立圓四維陣列 }=====================================================
void Circle() {
  float angle = TWO_PI/size;
  circles = new float[level][size*(size/2)][2][];
  for (int k = 0; k<level; k++) {
    float R =  255/level*(k+1);
    float scale = (k+1)/(float)(level);
    for (int i = 0; i<size; i++)
      for (int j = 0; j<size/2; j++) {
        float radius = radiusL*scale;
        float[] pos = {radius*cos(angle*j)*cos(angle*i), radius*sin(angle*j)*cos(angle*i), radius*sin(angle*i)};
        float[] col = {R, 100};
        circles[k][i + size*j][0] = pos;
        circles[k][i + size*j][1] = col;
      }
  }
}

//=========={ 處理陣列並執行 }=====================================================
void Seal() {
  noStroke();
  for (float[][][] steps : circles)
    for (float[][] circle : steps) {
      float[] pos = circle[0];
      float[] col = circle[1];
      float noise = noise(pos[0], pos[1]+seal*5, pos[2]);
      push();
      fill(col[0], noise*255, col[1], 70);
      noise = map(noise, 0, 1, -1, 1)*3;
      translate(pos[0]*map(x, 0, width, -10, 10)+noise, pos[1]*map(y, 0, height, -10, 10), pos[2]);
      sphere(radiusS);
      pop();
    }
}

float wheel;
void mouseWheel(MouseEvent event) {
  wheel = radiusS + event.getCount()/10.0;
}

/*=========={ Copyright }========================================================
 /
 /          ⏜                        ⏜
 /        ⎛ ◕ᴥ◕⎞   ---------------  ⎛◕ᴥ◕ ⎞
 /        ⎝ ⊃   ⊃ | @超可愛小海豹  | ⊂   ⊂ ⎠
 /         \　 ⎠   ---------------   ⎝   /
 /          \ /       |陳奕銓|         \ /
 /           ω                         ω
 */
