ArrayList<Card> cards;
int listSize = 30;

void setup(){
  size(1600, 900);
  
  cards = new ArrayList<Card>();
  
  //quantidade vai depender da dificuldade
  for (int i = 1; i <= listSize; i++){
    if (i <= listSize/2){  //gerando só para metade e dps randomizar os que foram gerados entre o resto
      cards.add(new Card(i, listSize, (char) int(random(33, 127))));
    } else{
      cards.add(new Card(i, listSize, cards.get(int(random(0,listSize/2+1))).getValue()));
    }
    println("Card ", cards.get(cards.size()-1).getIndex(), ", valor: ", cards.get(cards.size()-1).getValue());
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
