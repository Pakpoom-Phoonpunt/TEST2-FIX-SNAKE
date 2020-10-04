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
  Robot robot ;
  Target target ;
  Wall[] walls ;
  int block_size;

  World(int block_size ) {
    this.robot = new Robot(5, 5, this);
    this.block_size = block_size;
    this.target = new Target(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
    this.walls = new Wall[90];

    for (int x = 0; x < walls.length; x += 1) { // create object walls
      walls[x] = new Wall(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
      if ((walls[x].column == robot.column && walls[x].rown == robot.rown) || (walls[x].column == target.column && walls[x].rown == target.rown)) {
        walls[x] = new Wall(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
      }
    }
  }

  void draw () {
    this.robot.draw();
    this.target.draw();
    line(0, 0, width, 0);  // draw world
    for (int x = this.block_size; x < width; x += this.block_size) {
      line(x, 0, x, height);
      line(0, x, width, x);
    }

    for (int i = 0; i < walls.length; i +=1) walls[i].draw(); //draw walls
  }

  void update() {   
    if (keyPressed) {  // pressed key
      delay(200);
      if (key == 'd') robot.left();
      else if (key == 'a') robot.right();
      else if (key == 'w') robot.move(walls);
    }
    
    if (robot.column == target.column && robot.rown == target.rown) {  // robot hit target
      target = new Target(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
      for (int i = 0; i < this.walls.length; i +=1) {
        if ((walls[i].column == target.column && walls[i].rown == target.rown) || robot.column == target.column && robot.rown == target.rown) {
          target = new Target(int(random(0, width/this.block_size)), int(random(0, height/this.block_size)), this);
        }
      }

    }
    
    this.draw();
  }

  void save() {
  }

  void load() {
  }
}

class Robot {
  World world;

  int column, rown ;
  char direction ;
  char[] directioncollection = {'w', 'd', 's', 'a'};

  Robot(int column, int rown, World world) {
    this.column = column ;
    this.rown = rown ;
    this.direction = 'w' ;
    this.world = world;
  }

  void draw() {
    float[] point1 = new float[2];
    float[] point2 = new float[2];
    float[] point3 = new float[2];
    float[] point4 = new float[2];
    float[] point5 = new float[2];
    float[] point6 = new float[2];
    float[] point7 = new float[2];
    float[] point8 = new float[2];
    background(255);
    point1[0] = this.column * world.block_size ;
    point1[1] = this.rown * world.block_size ;

    point2[0] = (this.column * world.block_size) + (world.block_size/2);
    point2[1] = (this.rown * world.block_size) ;

    point3[0] = (this.column * world.block_size) + (world.block_size);
    point3[1] = (this.rown * world.block_size);

    point4[0] = (this.column * world.block_size) + (world.block_size);
    point4[1] = (this.rown * world.block_size) + (world.block_size/2) ;

    point5[0] = (this.column * world.block_size) + (world.block_size);
    point5[1] = (this.rown * world.block_size) + (world.block_size);

    point6[0] = (this.column * world.block_size) + (world.block_size/2);
    point6[1] = (this.rown * world.block_size) + (world.block_size);

    point7[0] = (this.column * world.block_size);
    point7[1] = (this.rown * world.block_size) + (world.block_size);

    point8[0] = (this.column * world.block_size);
    point8[1] = (this.rown * world.block_size) + (world.block_size/2);
    if (this.direction == 'w') {
      line(point2[0], point2[1], point5[0], point5[1]);
      line(point5[0], point5[1], point7[0], point7[1]);
      line(point7[0], point7[1], point2[0], point2[1]);
    } else if (this.direction == 'd') {
      line(point1[0], point1[1], point4[0], point4[1]);
      line(point4[0], point4[1], point7[0], point7[1]);
      line(point7[0], point7[1], point1[0], point1[1]);
      //triangle(point1[0], point1[1], point4[0], point4[1], point7[0], point7[1]);
    } else if (this.direction == 's') {
      line(point1[0], point1[1], point3[0], point3[1]);
      line(point3[0], point3[1], point6[0], point6[1]);
      line(point6[0], point6[1], point1[0], point1[1]);
      //triangle(point1[0], point1[1], point3[0], point3[1], point6[0], point6[1]);
    } else if (this.direction == 'a') {
      line(point8[0], point8[1], point3[0], point3[1]);
      line(point3[0], point3[1], point5[0], point5[1]);
      line(point5[0], point5[1], point8[0], point8[1]);
      //triangle(point8[0], point8[1], point3[0], point3[1], point5[0], point5[1]);
    }
  }

  void move(Wall[] walls) {
    
    boolean check = true ;
    
    if (this.direction == 'w') {
      for (int i = 0; i < walls.length; i += 1) { // check wall at the font
        if (walls[i].rown == this.rown - 1 && walls[i].column == this.column) check = false;
      }
      if (this.rown > 0 && check) this.rown -= 1 ;
    } 
    else if (this.direction == 'd') {
      for (int i = 0; i < walls.length; i += 1) { // check wall at the right
        if (walls[i].rown == this.rown && walls[i].column == this.column + 1) check = false;
      }
      if (this.column < width/world.block_size-1 && check) this.column += 1;
    } 
    else if (this.direction == 's') {
      for (int i = 0; i < walls.length; i += 1) { // check wall at below
        if (walls[i].rown == this.rown + 1 && walls[i].column == this.column) check = false;
      }
      if (this.rown < height/world.block_size-1 && check) this.rown += 1;
    } 
    else if (this.direction == 'a') {
      for (int i = 0; i < walls.length; i += 1) { // check wall at the left
        if (walls[i].rown == this.rown && walls[i].column == this.column - 1) check = false;
      }
      if (this.column > 0 && check)this.column -= 1;
    }
  }

  void left() {

    for (int x = 0; x < directioncollection.length; x +=1) {
      if (directioncollection[x] == this.direction) {
        if (x == 3) this.direction = directioncollection[0];
        else  this.direction = directioncollection[x+1];
        break;
      }
    }
    background(255);
  }

  void right() {

    for (int x = 0; x < directioncollection.length; x +=1) {
      if (directioncollection[x] == this.direction) {
        if (x == 0) this.direction = directioncollection[3];
        else  this.direction = directioncollection[x-1];
        break;
      }
    }
    background(255);
  }
}

class Target {
  World world ;
  float column, rown;
  Target(int column, int rown, World world) {
    this.column = column ;
    this.rown = rown;
    this.world = world;
  }

  void draw() {
    fill(0);
    this.polygon(world.block_size/2 + (world.block_size*this.column), world.block_size/2 + (world.block_size*this.rown), world.block_size/2, 6);
  }

  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}

class Wall {
  World world;
  float column, rown;

  Wall(int column, int rown, World world) {
    this.column = column;
    this.rown = rown;
    this.world = world;
  }

  void draw() {
    fill(50, 50);
    rect((world.block_size*this.column), (world.block_size*this.rown), world.block_size, world.block_size);
  }
}

class InputProcessor {
  InputProcessor(char move_key, char turn_left, char turn_riht) {
  }

  void get_move_key() {
  }

  void get_turn_left() {
  }

  void get_turn_right() {
  }
}
