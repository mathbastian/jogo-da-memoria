class Card{
  
  private int index;
  private char value;
  private int x;
  private int y;
  private int size = 100;
  private boolean inactive;
  private boolean flipped;
  
  public Card(int index, int listSize, char value){
    this.index = index;
    this.value = value;
    calculateCoordinates(index, listSize);
    inactive = false;
    flipped = false;
  }
  
  public void flipAndStayInactive(){
    flipped = true;
    inactive = true;
  }
  
  public void showTemporarily(){
    flipped = true;
  }
  
  public boolean isClickedByMouse(){
    if (mouseX >= x && mouseX <= x+size && 
      mouseY >= y && mouseY <= y+size) {
      return true;
    } else {
      return false;
    }
  }
  
  public void print(){
    int previousFillColor = g.fillColor;
    square(x, y, size);
    
    if(flipped){
      fill(0);
      text(value, x+size/2, y+size/2);
      fill(previousFillColor);
    }
  }
  
  public int getIndex(){
    return this.index;
  }
  
  private void calculateCoordinates(int index, int listSize){
    x = size*(index%(listSize/3));
    x += 100; //Só para dar espaço
    y = size;
    if (index > (listSize/3) && index <= (listSize/3*2)){
      y = y * 2;
    } else if (index > (listSize/3*2)){
      y = y * 3;
    }
  }
}
