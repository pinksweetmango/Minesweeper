import de.bezier.guido.*;
private final static int NUM_ROWS = 21;
private final static int NUM_COLS = 21;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); 
//ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  setMines();
}
public void setMines()
{
  //your code
  int r = (int)(Math.random()*(NUM_ROWS));
  int c = (int)(Math.random()*(NUM_COLS));
  for (int i = 0; i < 50; i++) {
    if (!mines.contains(buttons[r][c])) {
      mines.add(buttons[r][c]);
      r = (int)(Math.random()*(NUM_ROWS));
      c = (int)(Math.random()*(NUM_COLS));

    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon() {
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if (!buttons[r][c].clicked && !mines.contains(buttons[r][c])) {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O"); 
  buttons[9][8].setLabel("U");    
  buttons[9][10].setLabel("L");  
  buttons[9][11].setLabel("O");    
  buttons[9][12].setLabel("S");      
  buttons[9][13].setLabel("E");     
}
public void displayWinningMessage()
{
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O"); 
  buttons[9][8].setLabel("U");    
  buttons[9][10].setLabel("W");  
  buttons[9][11].setLabel("I");    
  buttons[9][12].setLabel("N");      
}
public boolean isValid(int r, int c)
{
  if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS) {
    return true;
  }
  return false;
}
public int countMines(int row, int col)
{
  int sum = 0;
  if (isValid(row+1, col) == true && mines.contains(buttons[row + 1][col])) {
    sum++;
  } 
  if (isValid(row-1, col) == true && mines.contains(buttons[row - 1][col])) {
    sum++;
  }  
  if (isValid(row+1, col+1) == true && mines.contains(buttons[row + 1][col + 1])) {
    sum++;
  }  
  if (isValid(row-1, col-1) == true && mines.contains(buttons[row - 1][col - 1])) {
    sum++;
  }  
  if (isValid(row, col+1) == true && mines.contains(buttons[row][col + 1])) {
    sum++;
  }  
  if (isValid(row+1, col-1) == true && mines.contains(buttons[row + 1][col - 1])) {
    sum++;
  }  
  if (isValid(row-1, col+1) == true && mines.contains(buttons[row - 1][col + 1])) {
    sum++;
  } 
  if (isValid(row, col-1) == true && mines.contains(buttons[row][col - 1])) {
    sum++;
  }  
  return sum;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    //your code here
    if (mouseButton == RIGHT) {
      flagged = !flagged;
      if (flagged == false) {
        clicked = false;
      }
    } else if (mines.contains(this)) {
      displayLosingMessage();
    } else if (countMines(myRow, myCol) > 0) {
      setLabel(countMines(myRow, myCol));
    } else {
      for (int r = myRow-1; r<=myRow+1; r++) {
        for (int c = myCol-1; c<=myCol+1; c++) {
          if (isValid(r, c) && !buttons[r][c].clicked) {
            buttons[r][c].mousePressed();
          }
        }
      }
    }
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) {
      fill(255, 0, 0);
    } else if (clicked)
      fill( 171, 133, 75 );
    else {
      if(myCol%2 == 0 && myRow%2 == 0){
    fill(  86, 125, 80);
      }
    else {
      fill(142, 201, 133);
    }
    }
    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
