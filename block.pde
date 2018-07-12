
class Block {
  int size;
  float x, y;
  int place;
  int value = 0;
  color fill = color(255);
  
  Block(int sizesize, float xx, float yy, int placeEnter){
    size = sizesize;
    x = xx;
    y = yy;
    place = placeEnter;
  }
  
  void draw(){
    fill(fill);
    strokeWeight(1);
    stroke(0);
    rect(x, y, width/size, height/size);
    fill(0);
    if(value != 0){
      text(value, x + width/(size*2) - textSize/2.2, y + height/(size * 2) + textSize/2.2);
    }
  }
  
  boolean checkMouse(){
    if(mouseX < x + (width/size) && mouseX > x && mouseY > y && mouseY < y + (height/size)){
      return true;
    }else{
      return false;
    }
  }
}
