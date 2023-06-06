ArrayList<Card> cards;
int listSize = 18;
int points = 0;
int lifePoints = 10;
Card selectedCard;
boolean gameFinished;
StringDict imageDictionary;

void setup(){
  size(1600, 900);
  cards = new ArrayList<Card>();
  ArrayList<Card> valueCards = new ArrayList<Card>();
  Card card;
  imageDictionary = new StringDict();
  
  //quantidade vai depender da dificuldade
  for (int i = 1; i <= listSize; i++){
    if (i <= listSize/2){  //gerando só para metade e dps randomizar os que foram gerados entre o resto
      card = new Card(i, listSize, (char) int(random(33, 127)), imageDictionary);
      cards.add(card);
      valueCards.add(card);
    } else{
      int valueIndex = int(random(0,valueCards.size()/2+1));
      cards.add(new Card(i, listSize, valueCards.get(valueIndex).getValue(), imageDictionary));
      valueCards.remove(valueIndex);
    }
    println("Card ", cards.get(cards.size()-1).getIndex(), ", valor: ", cards.get(cards.size()-1).getValue());
  }
  
  for (Card cardToBeUpdated : cards){
    if (!imageDictionary.hasKey( String.valueOf(cardToBeUpdated.getValue()) )){
      imageDictionary.set(String.valueOf(cardToBeUpdated.getValue()), new String("https://picsum.photos/seed/" + String.valueOf(cardToBeUpdated.getIndex()) + "/100"));
    }
  }
  
}

void draw(){
  background(220,220,220);
  for (Card card : cards){
    card.print();
  }
  
  displayPoints();
}

void mouseReleased(){
  if (gameFinished)
    return;
  
  if (isAnyCardShowingTemporarily())
    return;
  
  for (Card card : cards){
    if (card.isClickedByMouse()){
      
      if (selectedCard == null){
        card.flip();
        selectedCard = card;
      } else if (selectedCard.getValue() == card.getValue() && selectedCard != card){
        points += 1;
        selectedCard.flipAndStayInactive();
        card.flipAndStayInactive();
        selectedCard = null;
      } else if (selectedCard.getValue() != card.getValue() && selectedCard != card){
        lifePoints -= 1;
        card.showTemporarily();
        selectedCard.showTemporarily();
        selectedCard = null;
      }
      
    }
  }
  
  if (lifePoints == 0 || points == listSize/2)
    gameFinished = true;
}

void displayPoints(){
  int previousFillColor = g.fillColor;
  fill(0);
  text("Pontos: " + String.valueOf(points), 40, 40, 280, 320);
  text("Vida: " + String.valueOf(lifePoints), 40, 80, 280, 320);
  fill(previousFillColor);
}

boolean isAnyCardShowingTemporarily(){
  for (Card card : cards){
    if (card.isCardShowingTemporarily())
      return true;
  }
  return false;
}
