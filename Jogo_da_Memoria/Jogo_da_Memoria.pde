ArrayList<Card> cards;
int listSize = 30;

void setup(){
  size(1600, 900);
  
  cards = new ArrayList<Card>();
  
  //quantidade depende da dificuldade  
  for (int i = 1; i <= listSize; i++){
    cards.add(new Card(i, listSize, (char) int(random(33, 127)))); //gerar só para metade e dps randomizar os que foram gerados entre o resto
  }
}

void draw(){
  background(220,220,220);
  for (Card card : cards){
    card.print();
  }  
}

void mouseReleased(){
  for (Card card : cards){
    if (card.isClickedByMouse())
      card.showTemporarily();
  }
}
