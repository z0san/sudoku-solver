int size = 9;
int selected = 0;
boolean clicked = false, repeat = false, repeat2 = false, solving = false, solved = false;
int textSize = 50;

int [] tested = new int[0];

Block[] blocks = new Block [size * size];


void setup(){
  textSize(textSize);
  size(1000, 1000);
  for(int i = 0; i < size * size; i++){
    blocks[i] = new Block(size, (i%size) * width/size, floor(i/size) * height/size, i);
  }
}
  
void draw(){
  while(!solved && solving){
  frameRate(99999999);
  background(255);
  drawGrid();
  println(frameRate);
  
  for(int i = 0; i < blocks.length; i++){
    
    blocks[i].fill = color(255);
    if(blocks[i].checkMouse()){
      if(!clicked){
        selected = i;
      }
    }
  }
  
  if(clicked){
    blocks[selected].fill = color(100);
  }else{
    blocks[selected].fill = color(200);
  }
  
  
  
  if(mousePressed && !repeat && !solving){
    key = 0;
    repeat = true;
    clicked = !clicked;
  }else if(!mousePressed){
    repeat = false;
  }
  
  if(clicked && int(key) > 48 && int(key) < 58 && !solving){
    blocks[selected].value = key - 48;
  }
  
  if(keyPressed && key == ENTER && !repeat2){
    solving = !solving;
    repeat2 = true;
  }else if(!keyPressed){
    repeat2 = false;
  }

  int check = 0;
  if(solving){
    clicked = false;
    int found = findNext();
    if(found == -1 && check()){
      println("The puzzel is solved :)");
      noLoop();
      solved = true;
    }else if(found != -1){
      check = found;
    }
    //println(check());
    
    if(tested.length == 0){
      tested = append(tested, findNext());
    }
   
    if(!solved){
      //tested = append(tested, check);
      if(blocks[tested[tested.length -1]].value < 9){
        blocks[tested[tested.length -1]].value ++;
        if(check()){
          tested = append(tested, findNext());
        }
      }else{
        blocks[tested[tested.length -1]].value = 0;
        tested = shorten(tested);
      }
    }
    
    
    
  }
  }
  drawGrid();
  //println(solving);
}


int findNext(){
  for(int box = 0; box < size * size; box++){
    if(blocks[box].value == 0){
      return box;
    }
  }
  return -1;
}







void drawGrid(){
  background(255);
  for(int i = 0; i < blocks.length; i++){
    blocks[i].draw();
  }
  strokeWeight(5);
  for(int i = 0; i < 2; i++){
    line((width/3) * (i + 1), 0, (width/3) * (i + 1), height);
  }
  for(int j = 0; j < 2; j++){
    line(0, (height/3) * (j + 1), width, (height/3) * (j + 1));
  }
}

boolean check(){
  //for every columb
  for(int i = 0; i < size; i++){
    //for square
    for(int j = 0; j < size; j++){
      //check columb
      for(int columb = 0; columb < size; columb++){
        if(blocks[toInt(i, columb)].value == blocks[toInt(i, j)].value && columb != j && blocks[toInt(i, j)].value != 0){
          return false;
        }
      }
      //check row
      for(int row = 0; row < size; row++){
        if(blocks[toInt(row, j)].value == blocks[toInt(i, j)].value && row != i && blocks[toInt(i, j)].value != 0){
          return false;
        }
      }
      //check square
      //int square = floor(i/3)* 3  + floor(j/3);
      int baseX = floor(i/3) * 3;
      int baseY = floor(j/3) * 3;
      for(int squareX = 0; squareX < 3; squareX++){
        for(int squareY = 0; squareY < 3; squareY++){
          if(blocks[toInt(baseX + squareX, baseY + squareY)].value == blocks[toInt(i, j)].value && baseX + squareX != i && baseY + squareY != j && blocks[toInt(i, j)].value != 0){
            return false;
          }
        }
      }
    }
  }
  return true;
}



int toInt(int x, int y){
  return (9 * y) + x;
}
