World world;

void setup() {
  size(1200, 600); 
  background(255);
  world = new World(50);
  world.update();
}

void draw() {
  world.update();
}


class World {

  int block_size;

  World(int block_size ) {

    this.block_size = block_size;
   
  }

  void draw () {

    line(0, 0, width, 0);  // draw world
    for (int x = this.block_size; x < width; x += this.block_size) {
      line(x, 0, x, height);
      line(0, x, width, x);
    }
  }
  
  void update() {   
    this.draw();
  }
  
  void save(){
  
  }
  
  void load(){
  
  }
  
}

class Robot{
  
  Robot(int column, int rown){
    
  }
  
  void draw(){
  
  }
  
  void move(){
  
  }
  
  void left(){
  
  }
  
  void right(){
  
  }
}

class Target{
  
  Target(int column, int rown){
      
  }
  
  void draw(){
  
  }
  
}

class Wall{
  
  Wall(int column, int rown){
    
  }
  
  void draw(){
    
  }
}

class InputProcessor {
  InputProcessor(char move_key, char turn_left, char turn_riht){
    
  }
  
  void get_move_key(){
  
  }
  
  void get_turn_left(){
  
  }
  
  void get_turn_right(){
  
  }
}
