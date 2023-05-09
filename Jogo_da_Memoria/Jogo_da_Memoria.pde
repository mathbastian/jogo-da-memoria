ArrayList<Card> cards;
int listSize = 30;

void setup(){
  size(1600, 900);
  
  cards = new ArrayList<Card>();
  ArrayList<Card> valueCards = new ArrayList<Card>();
  Card card;
  
  //quantidade vai depender da dificuldade
  for (int i = 1; i <= listSize; i++){
    if (i <= listSize/2){  //gerando só para metade e dps randomizar os que foram gerados entre o resto
      card = new Card(i, listSize, (char) int(random(33, 127)));
      cards.add(card);
      valueCards.add(card);
    } else{
      int valueIndex = int(random(0,valueCards.size()/2+1));
      cards.add(new Card(i, listSize, valueCards.get(valueIndex).getValue()));
      valueCards.remove(valueIndex);
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
    if (card.isClickedByMouse()){
      card.showTemporarily();
    }
  }
}
