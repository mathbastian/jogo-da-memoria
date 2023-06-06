class Card{
  
  private int index;
  private char value;
  private int x;
  private int y;
  private int size = 100;
  private boolean inactive;
  private boolean flipped;
  private boolean showingTemporarily;
  private int counterStartTime;
  private StringDict imageDictionary;
  PImage image;
  
  public Card(int index, int listSize, char value, StringDict imageDictionary){
    this.index = index;
    this.value = value;
    this.imageDictionary = imageDictionary;
    calculateCoordinates(index, listSize);
    inactive = false;
    flipped = false;
  }
  
  public void flipAndStayInactive(){
    flipped = true;
    inactive = true;
  }
  
  public void flip(){
    flipped = !flipped;
  }
  
  public void showTemporarily(){
    showingTemporarily = true;
    counterStartTime = millis();
    if(!flipped)
      flip();
  }
  
  public boolean isClickedByMouse(){
    if (inactive)
      return false;
    
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
      if(image == null){
        image = loadImage(imageDictionary.get(String.valueOf(this.value)), "jpg");
      }
      image(image,x,y);
      fill(previousFillColor);
    }
    
    if (showingTemporarily){
      int secondsElapsed = ( millis() - counterStartTime ) / 1000;
      if (secondsElapsed > 3){
        flip();
        showingTemporarily = false;
      } 
    }
  }
  
  public int getIndex(){
    return this.index;
  }
  
  public char getValue(){
    return this.value;
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
  
  public boolean isCardShowingTemporarily(){
    return showingTemporarily;
  }
}
