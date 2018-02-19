//Global variables
Cell[][] Board;
int rows=3;
int cols=3;
int player=0;
int win=0;
int game=0;
int full;
void setup()
{
  size(400,400);
  smooth();
  Board = new Cell[cols][rows];
  
  for(int i=0;i<rows;i++)
  {
    for(int j=0;j<cols;j++)
    {
      Board[i][j] = new Cell(width/3*i,height/3*j,width/3,height/3);
    }
  } 
}

void draw()
{
  background(255);
  
  if(game==0)
  {
    fill(0);
    textSize(20);
    text("Press Enter to start",width/2-width/4,height/2);
    
  }
  
  else if(game==1)
  {
    updateDisplay();
    CheckGame(); 
  }
  
}

void updateDisplay()
{
  fill(255);
  
  for(int i=0;i<rows;i++)
  {
    for(int j=0;j<cols;j++)
    {
      Board[i][j].Display();
    }
  }
}

void mousePressed()
{
  for(int i=0;i<3;i++)
  {
    for(int j=0;j<3;j++)
    {
      if(mouseX>Board[i][j].checkX() && mouseX<Board[i][j].checkX()+Board[i][j].w && mouseY>Board[i][j].checkY() && mouseY<Board[i][j].checkY()+Board[i][j].h)
      {
        Board[i][j].click();
      }
    }
  }
}

void keyPressed()
{
  if(game==0)
  {
    if(key==ENTER)
    {
      game=1;
    }
  }
  
  else if(game==1)
  {
    if(key==ENTER)
    {
      game=0;
      
      for(int i=0;i<rows;i++)
      {
        for(int j=0;j<cols;j++)
        {
          Board[i][j].clean();
          win=0;
        }
      }
    }
  }

}

int checkFull()
{
  full=9;
  
  for(int i=0;i<rows;i++)
  {
    for(int j=0;j<cols;j++)
    {
      if(Board[i][j].checkState()!=0)
      {
        full=full-1;
      }
    }
  }
  
  return full;
}

void CheckGame()
{
  int row=0;
  
  full= checkFull();
  
  if(full!=0)
  {
      for(int col=0;col<cols;col++)
    {
      if(Board[col][row].checkState()==1 && Board[col][row+1].checkState()==1 && Board[col][row+2].checkState()==1)
      {
        win=1; //vertical 0 win
      }
      
      else if(Board[row][col].checkState()==1 && Board[row+1][col].checkState()==1 && Board[row+2][col].checkState()==1)
      {
        win=1; //Horizontal 0 win
      }
      
      else if(Board[col][row].checkState()==2 && Board[col][row+1].checkState()==2 && Board[col][row+2].checkState()==2)
      {
        win=2; //vertical X win
      }
      
      else if(Board[row][col].checkState()==2 && Board[row+1][col].checkState()==2 && Board[row+2][col].checkState()==2)
      {
        win=2; //Horizontal X win
      }
    }
  
    if(Board[row][row].checkState()==1 && Board[row+1][row+1].checkState()==1 && Board[row+2][row+2].checkState()==1)
    {
      win=1; //diagonal 0 win
    }
    
     else if(Board[row][row].checkState()==2 && Board[row+1][row+1].checkState()==2 && Board[row+2][row+2].checkState()==2)
    {
      win=2; //diagonal X win
    }
    
     else if(Board[0][row+2].checkState()==2 && Board[1][row+1].checkState()==2 && Board[2][row].checkState()==2)
    {
      win=2; //diagonal X win
    }
  
     else if(Board[0][row+2].checkState()==1 && Board[1][row+1].checkState()==1 && Board[2][row].checkState()==1)
    {
      win=1; //diagonal X win
    }
    
  }
  
  else
  {
    fill(0);
    text("Draw",Board[1][1].checkX()+40,Board[1][1].checkY()+50);
  }

  //display the winner
  
  fill(255);
  textSize(20);
  
  if(win==1)
  {
    fill(0);
    text("Player 1 \n Won",Board[1][1].checkX()+40,Board[1][1].checkY()+50);
    
  }
  else if(win==2)
  {
    fill(0);
    text("Player 2\n Won",Board[1][1].checkX()+40,Board[1][1].checkY()+50);
  }
  
  if(win==1 || win==2)
  {
    textSize(35);
    text("Press enter to start",width/2-width/2+23,height/2-height/6-20);
  }
  
}

class Cell
{
  int x;
  int y;
  int w;
  int h;
  int state;
  
  Cell(int x,int y,int w,int h)
  {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    
  }
  
  void click()
  {
          if(player==0 && state==0)
          {
            state=1;
            player=1;
            
          }
          
          else if(player==1 && state==0)
          {
            state =2;
            player=0;
          }

  }
  
  void clean()
  {
    state=0;
  }
  
  int checkState()
  {
    return state;
  }
  
  int checkX()
  {
    return x;
  }
  
  int checkY()
  {
    return y;
  }
  
  void Display()
  {

    stroke(0);
    strokeWeight(3);
    rect(x,y,w,h);
    
    if(state==1)
    {
      ellipseMode(CORNER);
      stroke(0);
      ellipse(x,y,w,h);
      
    }
    
    else if(state==2)
    {
      stroke(0);
      line(x,y,x+w,y+h);
      line(x+w,y,x,y+h);
    }
    
  }
}