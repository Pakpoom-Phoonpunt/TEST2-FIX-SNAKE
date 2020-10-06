World robot_world ;

void setup() {
  size(500, 500);
  robot_world = new World(10, 50); // World (world_size,block_size)  world_size*block_size = 800 value for width height
  surface.setSize( (robot_world.world_size*robot_world.block_size)+1, (robot_world.world_size*robot_world.block_size)+1  );
  //surface.setResizable(true);
  //surface.setResizable(false);
}

void draw() {
  background(255);
  robot_world.update_game();
}


class World {
  int world_size, block_size;
  Robot my_bot ; 
  Wall[] walls;
  Target target;

  World(int world_size, int block_size) {
    this.world_size = world_size;
    this.block_size = block_size;
    this.my_bot = new Robot(0, 0, this);
    this.walls = new Wall[20];
    this.target = new Target( int(random(0, world_size)), int(random(0, world_size)) );

    for (int j = 0; j < this.walls.length; j++) {
      walls[j] = new Wall(int(random(0, this.world_size)), int(random(0, this.world_size)));
    }
  }


  void draw () {
    fill(255);
    rectMode(CENTER);
    int x  = this.block_size/2;
    int y  = this.block_size/2;
    for (int i = 0; i < world_size; i ++) {
      for (int k = 0; k < world_size; k ++) {
        rect(x + (this.block_size*k), y + (this.block_size*i), this.block_size, this.block_size);
      }
    }
    for (int j = 0; j < this.walls.length; j++) {
      walls[j].draw(this);
    }
    this.my_bot.draw();
    this.my_bot.move();
    this.target.draw(this);
  }

  void update_game() {
    this.draw();
  }
}


class Robot {

  float x1, y1, x2, y2, x3, y3;
  int form = 0;
  World world;

  Robot(float positionX, float positionY, World world) {
    this.x1 = world.block_size/2 + (world.block_size * positionX);
    this.y1 = 0 + (world.block_size * positionY);
    this.x2 = 0 + (world.block_size * positionX);
    this.y2 = world.block_size + (world.block_size * positionY);
    this.x3 = world.block_size + (world.block_size * positionX);
    this.y3 = world.block_size + (world.block_size * positionY);
    this.world = world;
  }

  void move () {

    float temp_x1 = this.x1;
    float temp_y1 = this.y1;
    float temp_x2 = this.x2;
    float temp_y2 = this.y2;
    float temp_x3 = this.x3;
    float temp_y3 = this.y3;

    if (keyPressed) {
      // turn left
      if (key == 'a' || key == 'A') {
        if (form == 0) {
          this.x1 = temp_x2;
          this.y1 = temp_y1 + (this.world.block_size/2);
          this.x2 = temp_x3;
          this.y3 = temp_y1;
          delay(400);
          form = 1;
        } else if (form == 1) {
          this.x1 = temp_x1+ (this.world.block_size/2);
          this.y1 = temp_y2;
          this.y2 = temp_y3;
          this.x3 = temp_x1;
          delay(400);
          form = 2;
        } else if (form == 2) {
          this.x1 = temp_x2;
          this.y1 = temp_y1 - (this.world.block_size/2);
          this.x2 = temp_x3;
          this.y3 = temp_y1;
          delay(400);
          form = 3;
        } else if (form == 3) {
          this.x1 = temp_x1 - (this.world.block_size/2);
          this.y1 = temp_y2;
          this.y2 = temp_y3;
          this.x3 = temp_x1;
          delay(400);
          form = 0;
        }
      }

      // turn right
      if (key == 'd' || key == 'D') {
        if (form == 0) {
          this.x1 = temp_x3;
          this.y1 = temp_y1 + (this.world.block_size/2);
          this.x3 = temp_x2;
          this.y2 = temp_y1;
          delay(400);
          form = 3;
        } else if (form == 1) {
          this.x1 = temp_x1 + (this.world.block_size/2);
          this.y1 = temp_y3;
          this.y3 = temp_y2;
          this.x2 = temp_x1;
          delay(400);
          form = 0;
        } else if (form == 2) {
          this.x1 = temp_x3;
          this.y1 = temp_y1 - (this.world.block_size/2);
          this.x3 = temp_x2;
          this.y2 = temp_y1;
          delay(400);
          form = 1;
        } else if (form == 3) {
          this.x1 = temp_x1 - (this.world.block_size/2);
          this.y1 = temp_y3;
          this.y3 = temp_y2;
          this.x2 = temp_x1;
          delay(400);
          form = 2;
        }
      }
      // move forward
      if (key == 'w' || key == 'W') {
        if (( this.x1 != 0 & this.y1 !=0 ) & (this.x1 < width & this.y1 < height) ) {
          if ( form == 0 ) {
            this.y1 -= this.world.block_size;
            this.y2 -= this.world.block_size;
            this.y3 -= this.world.block_size;
            delay(400);
          }
          if ( form == 1 ) {
            this.x1 -= this.world.block_size;
            this.x2 -= this.world.block_size;
            this.x3 -= this.world.block_size;
            delay(400);
          }
          if ( form == 2 ) {
            this.y1 += this.world.block_size;
            this.y2 += this.world.block_size;
            this.y3 += this.world.block_size;
            delay(400);
          }
          if ( form == 3 ) {
            this.x1 += this.world.block_size;
            this.x2 += this.world.block_size;
            this.x3 += this.world.block_size;
            delay(400);
          }
        }
      }
    }
  }

  void draw() {
    fill(100);
    triangle(this.x1, this.y1, this.x2, this.y2, this.x3, this.y3);
  }
  boolean check_arrival(Target target) {
    boolean arrival = false;

    return arrival;
  }
}


class Target {
  World world ;
  float positionX, positionY ;
  Target(int x, int y) {
    this.positionX = x ;
    this.positionY = y ;
  }

  void draw(World world) {
    fill(#ffff00);
    this.polygon(world.block_size/2 + (world.block_size*this.positionX), world.block_size/2 + (world.block_size*this.positionY), world.world_size*2.5, 6);
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
  float positionX, positionY;

  Wall(float positionX, float positionY) {
    this.positionX = positionX;
    this.positionY = positionY;
  }

  void draw(World world) {
    fill(#008000); 
    rect(world.block_size/2 + (world.block_size*this.positionX), world.block_size/2 + (world.block_size*this.positionY), world.block_size, world.block_size);
  }
}
