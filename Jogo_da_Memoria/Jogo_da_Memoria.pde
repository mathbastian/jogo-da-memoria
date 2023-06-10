ArrayList<Card> cards;
int listSize = 18;
int points = 0;
int lifePoints = 12;
Card selectedCard;
boolean gameFinished;
StringDict imageDictionary;
PImage imgTelaInicial;
PImage imgTelaFinal;
boolean play = false;
boolean eventoBloqueadoJogo = true;
boolean eventoBloquadoTelaInicial = false;
String inputText = "";
boolean inputActive = false;
boolean button1Pressed = false;
boolean button2Pressed = false;
boolean button3Pressed = false;
int inputTamanho;
boolean teste = true;
boolean ganhou;

void setup(){
  size(1600, 900);
  imgTelaInicial = loadImage("backGround.jpg");
  imgTelaFinal = loadImage("gameOver.jpg");
}

void geraCard(){
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
  if(!play){
    background(imgTelaInicial);
    defineNome();
    dificuldade();
    fill(255);
    rect(150, 750, 150,50);
    fill(0);
    text("Jogar", 180, 725); 

  }else if(play==true && gameFinished == false){
    background(220,220,220);
    for (Card card : cards){
      card.print();
    }
    displayPoints();
  } else{
    println("fim chegou");
    background(imgTelaFinal);
    telaFinal();
  }
  

}
void telaFinal(){

  fill(255);
  textSize(25);
  text("Nome: " + inputText, width/2-300, 470);  
  text("pontuação atingida: " + points, width/2-300, 530);
}

void mouseReleased(){
  if(!eventoBloqueadoJogo){
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
    
    if (lifePoints == 0){
      gameFinished = true;
      ganhou = false;
      println(ganhou);  
    }
    if(points == listSize/2){
      gameFinished = true;
      ganhou = true;
      println(ganhou);
    }
  }
}

void displayPoints(){
  int previousFillColor = g.fillColor;
  fill(0);
  text("Pontos: " + String.valueOf(points), 40, 20, 280, 320);
  text("Vida: " + String.valueOf(lifePoints), 40, 60, 280, 320);
  fill(previousFillColor);
}

boolean isAnyCardShowingTemporarily(){
  for (Card card : cards){
    if (card.isCardShowingTemporarily())
      return true;
  }
  return false;
}

void mousePressed() {
  if(!eventoBloquadoTelaInicial){
    println("evento tela");
      if (mouseX >= 400 && mouseX <= 500 && mouseY >= 650 && mouseY <= 700) {
        button1Pressed = true;
        button2Pressed = false;
        button3Pressed = false;
      } else if (mouseX >= 520 && mouseX <= 620 && mouseY >= 650 && mouseY <= 700) {
        button1Pressed = false;
        button2Pressed = true;
        button3Pressed = false;
      } else if (mouseX >= 640 && mouseX <= 740 && mouseY >= 650 && mouseY <= 700) {
        button1Pressed = false;
        button2Pressed = false;
        button3Pressed = true;
      }else if (mouseX >= 100 && mouseX <= inputTamanho && mouseY >= 500 && mouseY <= 550) {
        inputActive = true;
      }else if(mouseX >=150 && mouseX <= 350 && mouseY >= 750 && mouseY <= 800 ){
        jogar();
      }else{
        inputActive = false;
      }
  }
}

void keyPressed() {
   if(!eventoBloquadoTelaInicial){
      if (inputActive) {
        if (keyCode == BACKSPACE) {
          if (inputText.length() > 0) {
            inputText = inputText.substring(0, inputText.length() - 1);
          }
        } else {
          inputText += key;
        }
      }
   }
}

void defineNome(){
  fill(255);
  noStroke();
  rect(98, 500, 300,50);
  rect(98, 500, textWidth(inputText) + 50, 50);
  fill(0);
  text("Informe seu nome: ", 100, 470);  
  if(textWidth(inputText) <= 400){
      inputTamanho = 400;
  }else{
    inputTamanho = int(textWidth(inputText) + 150);
  }
    
  if (inputActive) {
    fill(0);
    text(inputText + "|", 100, 530);
  } else if(inputText == ""){
    fill(150);
    text("Clique para digitar", 100, 530);
  }else{
    text(inputText, 100, 530);  
  }
}

void dificuldade(){
  fill(255);
  stroke(0);
  rect(400, 650, 100, 50);
  rect(520, 650, 100, 50);
  rect(640, 650, 100, 50);
  fill(0);
  textSize(20);
  text("Facil", 427, 635);
  text("Medio", 545, 635);
  text("Dificil", 662, 635);
  textSize(30);
  text("Dificuldade", 500, 590);
  if (button1Pressed) {
    fill(0, 255, 0);
    rect(400, 650, 100, 50);
    listSize=12;
  }
  if (button2Pressed) {
    fill(0, 255, 0);
    rect(520, 650, 100, 50);
    listSize=18;
  }
  if (button3Pressed) {
    fill(0, 255, 0);
    rect(640, 650, 100, 50);
    listSize=24;
  }

}

void jogar(){
  if(inputText != "" &&
     button1Pressed == true ||
     button2Pressed == true ||
     button3Pressed == true){
    println("entrei");
    background(220,220,220);
    eventoBloquadoTelaInicial = true;
    eventoBloqueadoJogo = false;
    geraCard();
    play = true;
  }else{
    println("nentrei");
  }
}
