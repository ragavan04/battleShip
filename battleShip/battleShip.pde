int[][] grid = new int[10][10];
int state = 0;
int playerShips, enemyShips, player2Ships, player3Ships;
int row, col, targetRow, targetCol;
int gameScreen;
int turn, multiplayerTurn = 0;
int enemyGuess = 0;
int playerGuess, player2Guess, player3Guess = 0;
int playerPoints, player2Points, player3Points = 0;
int enemyPoints = 0;
int winner = 2;
int gridx;
int gridy;
int startX = 165;
int startY = 209;
int flag = 0;
int multiX = 165;
int multiY = 280;
PImage mainMenu;

void setup() {
  size(500, 500);

  mainMenu = loadImage("mainMenu.jpg");
  for (int i=0; i < 10; i++) { 
    for (int j=0; j < 10; j++) {
      grid[i][j] = 0;  
      floor(random(3));
    }
  }
}


void draw() {
  //main menu
  
  //main menu screen
  if (gameScreen == 0) {
    state = -1;
    background(mainMenu);

    //start button 
    fill(#000003);
    rect(startX, startY, 209, 48);
    fill(#fffff0);
    textSize(30);
    text("Start Game", startX + 24, startY + 34);

    //multiplayer button
    fill(#000003);
    rect(multiX, multiY, 209, 48);
    fill(#fffff0);
    textSize(30);
    text("Multiplayer", multiX + 24, multiY + 34);
  }

  //in game screen
  if (gameScreen == 1) {
  
    //colours for squares
    for (int i=0; i < 10; i++) {
      for (int j=0; j < 10; j++) {
        if (grid[i][j] == 0) fill(#0028FF);
        else if (grid[i][j] == 1) fill(#FF0000);
        else if (grid[i][j] == 2) fill(#D400FF);
        else if (grid[i][j] == 3) fill(#000000);
        else if (grid[i][j] == 4) fill(#D6D00D);
        else if (grid[i][j] == 5) fill(#2EDB00);
        rect(i * 50, j*50, 100, 100);
      }
    }

    //text for where mouse is
    fill(255);
    textSize(20);
    text(int(mouseX / 50) + " " + int(mouseY / 50), mouseX, mouseY);

    //display player points and enemy points
    text("Player points: " + playerPoints, 5, 20);
    text("Enemy points: " + enemyPoints, width - 150, 20);

    //if all guesses are done then call the win checker
    if (playerGuess == 4 && enemyGuess == 3) {
      winChecker();
    }
  }

  //two player
  if (gameScreen == 2) {
    for (int i=0; i < 10; i++) {
      for (int j=0; j < 10; j++) {
        if (grid[i][j] == 0) fill(#0028FF);
        else if (grid[i][j] == 1) fill(#FF0000);
        else if (grid[i][j] == 2) fill(#D400FF);
        else if (grid[i][j] == 3) fill(#000000);
        else if (grid[i][j] == 4) fill(#D6D00D);
        else if (grid[i][j] == 5) fill(#2EDB00);
        rect(i * 50, j*50, 100, 100);
      }
    }

    fill(255);
    textSize(20);
    text(int(mouseX / 50) + " " + int(mouseY / 50), mouseX, mouseY);

    text("Player 1 points: " + playerPoints, 5, 20);
    text("Player 2 points: " + player2Points, width - 150, 20);

    if (player3Guess == 3 && player3Guess == 3) {
      multiplayerWinChecker();
    }
  }

  //win screen 
  if (gameScreen == 3) {
    background(120);
    fill(#000000);
    if (winner == 1) {
      text("Red wins!", width/2, height/2);
    }
    if (winner == 0) {
      text("Purple wins!", width/2, height/2);
    }
    if (winner == 2) {
      text("TIE!", width/2, height/2);
    }
  }
}

void mousePressed() {

  //start button
  if (mouseX > startX && mouseX < startX + 209 && mouseY > startY && mouseY < startY + 48) { //button to start the game
    gameScreen = 1;
    state = 0;
  }
  
  //multiplayer button 
  if (mouseX > multiX && mouseX < multiX + 209 && mouseY > multiY && mouseY < multiY + 48) { //button to start the game
    gameScreen = 2;
    state = 0;
  }


  if (gameScreen == 1) {  
    //place player ship and spawn enemy ships
    if (state == 0) {
      placePlayerShip();
      placeEnemyShip();
    }

    // player vs enemy turns
    if (state == 1) {
    //player shoot turn
      if (turn == 0) {
        playerShipAttack();
        turn = 1;
        playerGuess++;
  
        //if player guess are done, calculated using mouse clicks
        if (playerGuess == 4) {
          println("playerGuess donee");
        }
      }
      //enemy ship attacks 
      if (turn == 1) {
        enemyShipAttack();
        turn = 0;
      }
    }
  }

  //two player
  if (gameScreen == 2) {
    if (state == 0) {
      placePlayer2Ship();
      placePlayer3Ship();
    }

    if (state == 1) {
      if (multiplayerTurn == 0) {
        player2ShipAttack();
        player2Guess++;
        multiplayerTurn = 1;
      }
      if (multiplayerTurn == 1) {
        player3ShipAttack();
        player3Guess++;
        multiplayerTurn = 0;
      }
    }
  }
}









//place enemy ship function
void placePlayerShip(){
  if (state == 0) {
    gridx = int(mouseX /50);
    gridy = int(mouseY /50);
    if (grid[gridx][gridy] == 0) grid[gridx][gridy] = 1;
    playerShips++;
    if (playerShips >= 3) state = 1;
  }
}


//player ship attack function
void playerShipAttack() {
  gridx = int(mouseX /50);
  gridy = int(mouseY /50);
  if (grid[gridx][gridy] == 0) grid[gridx][gridy] = 5; //if player guesses water then turn square to black
  else if (grid[gridx][gridy] == 1) grid[gridx][gridy] = 1; //if player guess its own square then keep the colour the same
  else if (grid[gridx][gridy] == 2) { //if player guesses the enemy square
    grid[gridx][gridy] = 3; 
    playerPoints++; //add to player points
  } else if (grid[gridx][gridy] == 3) grid[gridx][gridy] = 3;
}

//enemyship placing
void placeEnemyShip() {
  row = floor(random(10));
  col = floor(random(10));
  
  //spawn random enemeyships while the squares are not the player or another enemy ship
  while (grid[row][col] != 0  && grid[row][col] != 1 && enemyShips <= 2) {
    row = floor(random(10));
    col = floor(random(10));
  }
  //limit it so only 3 enemy ships can be placed
  if (enemyShips <=2) {
    grid[row][col] = 2;
    enemyShips++;
  }
}


//enemyship attack function
void enemyShipAttack() {
  targetRow = floor(random(10));
  targetCol = floor(random(10));

  //enemy ship guesses its shots
  while (grid[targetRow][targetCol] != 1 && grid[targetRow][targetCol] != 2 && enemyGuess < 3) {
    targetRow = floor(random(10));
    targetCol = floor(random(10));
    grid[targetRow][targetCol] = 4;
    enemyGuess++;
    break;
  }
 
  //if the enemy ship sucessfully shoots a player
  if (grid[targetRow][targetCol] == 1 && enemyGuess < 3) {
    grid[targetRow][targetCol] = 3;
    enemyPoints++; //add to enemy points
  }
  if (enemyGuess == 3) {
    println ("out of guesses");
  }
}

//win checker function
void winChecker() {
  if (playerPoints > enemyPoints) {
    winner = 1;
  }
  if (enemyPoints > playerPoints) {
    winner = 0;
  }
  if (enemyPoints == playerPoints) {
    winner = 3 ;
  }
  gameScreen = 3;
}


//multiplayer code
void placePlayer2Ship() {
  if (state == 0 && flag == 0) {
    gridx = int(mouseX /50);
    gridy = int(mouseY /50);
    if (grid[gridx][gridy] == 0) grid[gridx][gridy] = 1;
    player2Ships++;
    if (player2Ships >= 3) flag = 1;
  }
}

void placePlayer3Ship() {
  if (flag == 1 && player3Ships <= 4) {
    gridx = int(mouseX /50);
    gridy = int(mouseY /50);
    if (grid[gridx][gridy] == 0) grid[gridx][gridy] = 2;
    player3Ships++;
    print(player3Ships);
    if (player3Ships >= 4) state = 1;
  }
}

void player2ShipAttack() {

  gridx = int(mouseX /50);
  gridy = int(mouseY /50);
  if (grid[gridx][gridy] == 0) grid[gridx][gridy] = 4; 
  else if (grid[gridx][gridy] == 1) grid[gridx][gridy] = 1;
  else if (grid[gridx][gridy] == 2) {
    grid[gridx][gridy] = 3; 
    player2Points++;
  } else if (grid[gridx][gridy] == 3) grid[gridx][gridy] = 3;
}

void player3ShipAttack() {
  print("player3");
  gridx = int(mouseX /50);
  gridy = int(mouseY /50);
  if (grid[gridx][gridy] == 0) grid[gridx][gridy] = 5; 
  else if (grid[gridx][gridy] == 2) grid[gridx][gridy] = 2;
  else if (grid[gridx][gridy] == 1) {
    grid[gridx][gridy] = 3; 
    player2Points++;
  } else if (grid[gridx][gridy] == 3) grid[gridx][gridy] = 3;
}

void multiplayerWinChecker() {
  if (player2Points > player3Points) {
    winner = 1;
  }
  if (player3Points > player2Points) {
    winner = 0;
  }
  if (player2Points == player3Points) {
    winner = 3 ;
  }
  gameScreen = 3;
}
