import processing.sound.*;
SoundFile SF_1,SF_2,SF_3,SF_4,SF_bg, SF_5;
PImage brick_img, brick_img_2, play_1, exit_1, pla;
Ball[] balls;
Box[] boxes;
int rr, num=0, rr_co, box_life_set=1, mxdbx, mydby, bb_num=0, ball_L=0, box_cl=0;
int color_r, color_g, color_b, H=0, H_b1=10, H_b2=25, H_b3=50, ball_dead, t_first=2;
int[] co_r;
float ballX1=200,ballY1=100,ballVX1=0,ballVY1=0;
float ballX2=300,ballY2=100,ballVX2=0,ballVY2=0;
float ballX3=400,ballY3=100,ballVX3=0,ballVY3=0;
boolean make_box=false, mlock=false, make_ball=false, ball_no1=true,record_score=false, touch=false;
String[] lines;
int [] score=new int[6];
int state=0;
void setup(){
  size(600, 800);
  SF_1=new SoundFile(this, "cupboard1_C.mp3");
  SF_2=new SoundFile(this, "damage1.mp3");
  SF_3=new SoundFile(this, "door2_C.mp3");
  SF_4=new SoundFile(this, "middle_punch1.mp3");
  SF_bg=new SoundFile(this, "future_world.mp3");
  SF_5=new SoundFile(this, "launcher1.mp3");
  colorMode(HSB,100);
  textSize(20);
  lines = loadStrings("score.txt");
  for (int i = 0 ; i < lines.length; i++) {
    score[i]=int(lines[i]);
  }
  brick_img=loadImage("brick_03_2.png");
  brick_img_2=loadImage("brick_01.jpg");
  play_1=loadImage("play.png");
  exit_1=loadImage("exit.jpeg");
  
  rr=int(random(0,15));
  num+=rr;
  co_r=new int[20];
  
  SF_bg.play(1,0.1);
  SF_bg.loop();
}
void draw(){
  if(state==0){
    image(brick_img, 0,0, width, 80);
    image(brick_img, 0,height-80, width, 80);
    image(brick_img_2, 0,80, width, height-160);
    
    ball1();
    ball2();
    ball3();
    boxes=new Box[2000000];
    balls=new Ball[2000];
    
    balls[bb_num]=new Ball();
    num=0;
    make_box=true;
    box_life_set=1;
    strokeWeight(10);
    stroke(#FFFFFF);line(130,300,500,300); line(320,425,500,425);
    strokeWeight(1);
    textSize(120);
    fill(0);text("FT-CB", 140, 400);
    textSize(20);
    fill(0);text("Fantasy Color Ball", 140, 430);
    H=(H+1)%100;
    image(play_1, 215, 500, 180, 100);
    if(mxdbx>215 && mxdbx<395 && mydby>500 && mydby<600){
      SF_1.play(1,0.5);
      state=1;
    }
  }
  if(state==1){
    ball_dead=0;
    image(brick_img, 0,0, width, 80);
    image(brick_img, 0,height-80, width, 80);
    image(brick_img_2, 0,80, width, height-160);
    textSize(20);
    stroke(#FFFF00);
    strokeWeight(10);
    line(0,75, width,75);
    line(0,height-75, width,height-75);
    stroke(0);
    strokeWeight(1);
    ball_L=0;
    for(int balli=0; balli<=bb_num; balli++){
      if(balls[balli].get_life()){
        balls[balli].Ball_run();
        balls[balli].Ball_Boundary();
      }
      else{
        ball_L++;
      }
    }
    if(ball_L==box_life_set-1){
      make_box=true;
      balls[0]=new Ball();
      balls[0].set_coordinate(0);
    }
    for(int i=0; i<num; i++){
      boxes[i].Box_display();
      
      for(int balli=0; balli<=bb_num; balli++){
        if(boxes[i].Box_Boundary(balls[balli].Ball_get_cox(),balls[balli].Ball_get_coy())==1){
          balls[balli].Ball_change_vy();
        }
        else if(boxes[i].Box_Boundary(balls[balli].Ball_get_cox(),balls[balli].Ball_get_coy())==2){
          balls[balli].Ball_change_vx();
        }
      }
      if(boxes[i].Box_get_coy()+40>=height-80 & boxes[i].get_Box_life()>0){ 
        state=2;
        record_score=true;
      }
    }
    if(make_box==true){
      color_r=int(random(100)); color_g=int(random(128,255)); color_b=int(random(128,255));
      for(int i=0; i<num; i++){
        boxes[i].Box_move();
      }
      rr=int(random(1,15));
      co_r=new int[15];
      for(int i=num; i<num+rr; i++){
        rr_co=int(random(1,15));
        if(co_r[rr_co]==1){
          i--;
          continue;
        }
        boxes[i]=new Box(40*rr_co, 120);
        boxes[i].Box_life(box_life_set);
        boxes[i].set_color(color_r,color_g,color_b);
        co_r[rr_co]=1;
      }
      box_life_set++;
      make_box=false;
      ball_L=0;
      num+=rr;
    }
    if(make_ball==true && mlock==true){ //&& touch==true
      if(ball_no1==false) {bb_num++;}
      else {ball_no1=false;}
      for(int i=0; i<=bb_num; i++){
        balls[i]=new Ball();
        balls[i].Ball_speed_set(mxdbx,mydby);
        balls[i].set_coordinate(i);
      }
  
      make_ball=false;
      mlock=false;
      touch=false;
    }
    fill(30,100,100);ellipse(300,height-70,50,50);
    fill(10,100,100);ellipse(300,height-70,30,30);
    level();
  }
  if(state==2){
    textSize(1);
    image(brick_img, 0,0, width, 80);
    image(brick_img, 0,height-80, width, 80);
    image(brick_img_2, 0,80, width, height-160);
    box_cl=0;
    if(record_score==true){
      score[5]=box_life_set-1;
      score=sort(score);
      score=reverse(score);
      //println();
      for(int i=0; i<score.length-1; i++) {lines[i]=str(score[i]);}
      saveStrings("score.txt", lines);
      record_score=false;
    }
    for(int i=0; i<num;i++){
      println("num",num);
      if(boxes[i].Box_get_cox()>300) {boxes[i].Box_movex(3);}
      else{boxes[i].Box_movex(-3);}
      if(boxes[i].Box_get_cox()+40<0 || boxes[i].Box_get_cox()>width) box_cl++;
      boxes[i].Box_display();
    }
    if(box_cl==num){
      textSize(70);
      fill(#FF0000);text("Game  Over", 100, 200);
      fill(#00FF00);rect(130, 225, 330, 375);
      image(play_1, 325, 625, 100, 75);
      image(exit_1,170, 625, 100, 75);
      textSize(40);
      fill(0);text("Top 5", 160, 290);
      fill(0);text("Level", 310, 290);
      for(int i=1; i<=5; i++){
        if(i==1) fill(#FFD700);
        else if(i==2) fill(#C0C0C0);
        else if(i==3) fill(#C47222);
        else fill(#555555);
        if(i<=5) {
          textSize(50-(i-1)*3);
          text(i, 195+i*1.5, 360+((i-1)*50));
          text(score[i-1], 325+i*1.5, 360+((i-1)*50));
        }
      } 
    }
    if(mxdbx>325 && mxdbx<425 && mydby>625 && mydby<700){
      SF_1.play(1,0.5);
      state=0;
      bb_num=0;
    }
    if(mxdbx>170 && mxdbx<270 && mydby>625 && mydby<700){
      SF_3.play(1);
      exit();
    }
    level();
  }
}

void keyPressed(){
  if(key==' '){
    make_box=true;
  }
}
void mouseReleased() {
  if(state==1){
   mlock=true;
   make_ball=true;
   SF_5.play(1, 0.5);
   //make_box=true;
  }
   mxdbx=mouseX; 
   mydby=mouseY;
}
void level(){
  textSize(50);
  fill(#FF0033);
  text("Level", 170, 60);
  if(box_life_set-1<10) text(box_life_set-1, 330, 60);//290, 60 
  else text(box_life_set-1, 310, 60);
}

class Ball{
  float x, y, vx, vy, ball_life_num;
  float xx,yy,vvx,vvy; //check
  float d;
  int H;
  boolean ball_life;
  Ball(){
    x=300; y=height-80;
    vx=0; vy=0;
    ball_life=true;
    ball_life_num=1;
    xx=x; yy=y;
    H=0;
  }
  void Ball_speed_set(int i, int j){
    if(vx==0 && vy==0){
      d=sqrt((x-i)*(x-i)+(y-j)*(y-j));
      if(y-j<0){ vx=(((x-i)/d)*10);} //int
      else{ vx=-(((x-i)/d)*10);} //int
      vy=(-(abs(y-j)/d)*10); //int
      //print(vy);
      vvx=vx; vvy=vy;
    }
  }
  void Ball_run(){
    x+=vx;
    y+=vy;
    if(y<height-85){
      fill(H, 100, 100); ellipse(x,y,10,10);
      H=(H+1)%100;
    }
  }
  void Ball_Boundary(){
    if(x<0) {vx*=-1;}
    else if(x>600) {vx*=-1;}
    if(y<85) {vy*=-1;}
    if(y>height-85 & (vy!=0 || vx!=0)) {
      if(ball_life_num==0){
        vy=0; /*vy*=-1;*/
        vx=0;
        ball_life=false;
      }
    }
    if(y>85 && y<height-85 && ball_life_num>0){ball_life_num--; }
  }
  float Ball_get_cox(){
    return x;
  }
  float Ball_get_coy(){
    return y;
  }
  void Ball_change_vx(){
    vx*=-1;
  }
  void Ball_change_vy(){
    vy*=-1;
  }
  void set_coordinate(int i){
    x=x-(vx*i*2);
    y=y-(vy*i*2);
  }
  boolean get_life(){
    return ball_life;
  }
  void ball_display(int i){
    //check
    fill(0, 0, 0); ellipse(xx-(vvx*i*2),yy-(vvy*i*2)-5,10,10);
  }
}
class Box{
  int x, y, life=0, r, g, b;
  boolean cleanBox;
  Box(int xx, int yy){
    x=xx;
    y=yy;
    cleanBox=false;
  }
  void Box_display(){
    if(life>0){
      fill(r, 100, 100); rect(x,y, 40,40);
      fill(0, 0, 0); text(life, x+10, y+30);
    }
  }
  int Box_Boundary(float bx, float by){
    int i=0;
    if(life>0){
      if((bx>x-10 & bx<x+50) && ((by>y-10 & by<y) | (by<y+50 & by>y+40))){ //bx>x-10 & bx<x+50
        i=1;
        if(life==1) SF_2.play(1);
        life--;
      }
      if((by>y-10 & by<y+50) && ((bx>x-10 & bx<x) | (bx<x+50 & bx>x+40))){ //by>y-10 & by<y+50
        i=2; 
        if(life==1) SF_2.play(1);
        life--;
      }
    }
    
    return i;
  }
  void Box_move(){
    y+=40;
  }
  void Box_life(int l){
    life=l;
  }
  void set_color(int cr,int cg,int cb){
    r=cr; g=cg; b=cb;
  }
  int Box_get_coy(){
    return y;
  }
  int Box_get_cox(){
    return x;
  }
  void Box_movex(int i){
    x+=i;
  }
  int get_Box_life(){
    return life;
  }
  void Box_state(boolean ii){
    cleanBox=ii;
  }
}

void ball1()
{
  strokeWeight(1);
  fill(H_b1, 100,100);
  ellipse(ballX1,ballY1,10,10);
  H_b1=(H_b1+1)%100;
  ballY1+=ballVY1;
  ballVY1+=0.98;
  if(ballY1>300)
  {
    ballVY1=-15;ballY1=243;
    SF_4.play(2,0.3);
  }
}
void ball2()
{
  strokeWeight(1);
  fill(H_b2, 100,100);
  ellipse(ballX2,ballY2,10,10);
  H_b2=(H_b2+1)%100;
  ballY2+=ballVY2;
  ballVY2+=0.98;
  if(ballY2>300)
  {
    ballVY2=-random(5,18);ballY2=243;
    SF_4.play(2,0.5);
  }
}
void ball3()
{
  strokeWeight(1);
  fill(H_b3, 100,100);
  ellipse(ballX3,ballY3,10,10);
  H_b3=(H_b3+1)%100;
  ballY3+=ballVY3;
  ballVY3+=0.98;
  if(ballY3>300)
  {
    ballVY3=-10;ballY3=243;
    SF_4.play(2,0.7);
  }
}
