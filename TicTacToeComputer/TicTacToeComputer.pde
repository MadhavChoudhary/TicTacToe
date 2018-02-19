import java.util.*;

//Global variables
Cell[][] Board;
int rows=3;
int cols=3;
int player=1;
int game=0;
int first_move=0;
int difficulty=0;

void setup()
{
  size(400,400);
  smooth();
  Board = new Cell[cols][rows];
  
  for(int i=0;i<rows;i++)
  {
    for(int j=0;j<cols;j++)
    {
      Board[j][i] = new Cell(width/rows*i,height/rows*j);
    }
  } 
  
}

void draw()
{
  int temp=CheckGame();

  if(game==0)
  {
    background(255);
    fill(0);
    textSize(35);
    text("Tic Tac Toe",width/4,height/4);
    textSize(20);
    text("Enter difficulty level",width/4,height/4+height/8);
    text("Press 1 - Easy",width/4,height/4+height/16+height/8);
    text("Press 2 - Moderate",width/4,height/2);
    text("Press 3 - Difficult",width/4,height/2+height/16); 
  System.out.println(game);    
  }
  
  else if(game==1)
  {
    background(255);
    fill(0);    
    textSize(20);
    text("Press Enter to start",width/4,height/2);    
  }
    
    else if(temp==1)
    {
      delay(300);     
      background(255);
      fill(0);
      text("You Win",width/2-width/8,height/2);
    }
    
    else if(temp==2)
    {
      delay(300);
      background(255);
      fill(0);      
      text("You Loose",width/2-width/8,height/2);      
    }
    
    else if(temp==rows)
    {
      delay(300);      
      background(255);
      fill(0);      
      text("Draw",width/2-width/12,height/2); 
    }
    
    else
    {
      background(255);
      updateDisplay();
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
  for(int i=0;i<rows;i++)
  {
    for(int j=0;j<cols;j++)
    {
      if(mouseX>Board[i][j].x && mouseX<Board[i][j].x+width/cols && mouseY>Board[i][j].y && mouseY<Board[i][j].y+height/rows)
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
    if(key==1)
    {
      difficulty=0;
    }
    else if(key==2)
    {
      difficulty=1;
    }
    else if(key==3)
    {
      difficulty=2;
    } 
    game=1;
  }
  
  else if(game==1)
  {
    if(key==ENTER)
    {
      game=2;
    }
  }
  else if(game==2)
  {
    if(key==ENTER)
    {
      game=2;
      first_move=0;
      player=1;
      
      for(int i=0;i<rows;i++)
      {
        for(int j=0;j<cols;j++)
        {
          Board[i][j].clean();
        }
      }
    }
  }

}

int CheckGame()
{
  int sum1=0,sum2=0,i,j;
  
  //rows check
  for(i=0;i<rows;i++)
  {
    sum1=0;sum2=0;
    
    for(j=0;j<cols;j++)
    {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
    }
    
    if(sum1==cols)
      return 1;
      
    if(sum2==cols)
      return 2;
    
    if(sum2==cols-1 && player==2 && sum1==0)
    {
      //win move
      comp_move(i,j);
      return 0;
    }
    
  }
  
  //coloums check
  for(j=0;j<cols;j++)
  {
    sum1=0;sum2=0;
    
    for(i=0;i<rows;i++)
    {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
    }
  
    if(sum1==rows)
      return 1;
      
    if(sum2==rows)
      return 2;
    
    if(sum2==rows-1 && player==2 && sum1==0)
    {
      //win move
      comp_move(i,j);
      return 0;
    }
    
  }
  
  sum1=0;sum2=0;
  //diagonal 1 check
  for(i=0,j=0;i<rows;i++,j++)
  {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
  }
 
    if(sum1==rows)
      return 1;
      
    if(sum2==rows)
      return 2;
    
    if(sum2==2 && player==2 && sum1==0)
    {
      //win move
      comp_move(i,j);
      return 0;
    }
    
  
  sum1=0;sum2=0;
  //diagonal 2 check
  for(j=cols-1,i=0;j>=0;j--,i++)
  {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
  }
 
    if(sum1==rows)
      return 1;
      
    if(sum2==rows)
      return 2;
    
    if(sum2==rows-1 && player==2 && sum1==0)
    {
      //win move
      comp_move(i,j);
      return 0;
    }
    
  //check again for all block moves  
  //rows check
  for(i=0;i<rows;i++)
  {
    sum1=0;sum2=0;
    
    for(j=0;j<cols;j++)
    {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
    }
    
    if(sum1==cols-1 && player==2 && sum2==0)
    {
      //block move
      comp_move(i,j);
      return 0;
    }
    
  }
  
  //coloums check
  for(j=0;j<cols;j++)
  {
    sum1=0;sum2=0;
    
    for(i=0;i<rows;i++)
    {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
    }
    
    if(sum1==rows-1 && player==2 && sum2==0)
    {
      //block move
      comp_move(i,j);
      return 0;
    }
    
  }
  
  sum1=0;sum2=0;
  //diagonal 1 check
  for(i=0,j=0;i<rows;i++,j++)
  {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
  }
    
    if(sum1==rows-1 && player==2 && sum2==0)
    {
      //block move
      comp_move(i,j);
      return 0;
    }
  
  sum1=0;sum2=0;
  //diagonal 2 check
  for(j=cols-1,i=0;j>=0;j--,i++)
  {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
  }
    
    if(sum1==rows-1 && player==2 && sum2==0)
    {
      //block move
      comp_move(i,j);
      return 0;
    }
    
  //check again for all first moves  
  
  if(first_move==0)
  {
    
  sum1=0;sum2=0;
  //diagonal 1 check
  for(i=0,j=0;i<rows;i++,j++)
  {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
  }
    
    if(sum1==1 && player==2)
    {
      //first move
      comp_move(i,j);
      return 0;
    }
  
  sum1=0;sum2=0;
  //diagonal 2 check
  for(j=cols-1,i=0;j>=0;j--,i++)
  {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
  }
    
    if(sum1==1 && player==2)
    {
      //first move
      comp_move(i,j);
      return 0;
    }
    
  //rows check
  for(i=0;i<rows;i++)
  {
    sum1=0;sum2=0;
    
    for(j=0;j<cols;j++)
    {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
    }
    
    if(sum1==1 && player==2)
    {
      //first move
      comp_move(i,j);
      return 0;
    }
    
  }
  
  //coloums check
  for(j=0;j<cols;j++)
  {
    sum1=0;sum2=0;
    
    for(i=0;i<rows;i++)
    {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
    }
    
    if(sum1==1 && player==2)
    {
      //first move
      comp_move(i,j);
      return 0;
    }
    
  }
 
  }    
    
  //check again for all grow moves  
  //rows check
  for(i=0;i<rows;i++)
  {
    sum1=0;sum2=0;
    
    for(j=0;j<cols;j++)
    {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
    }
    
    if(sum1==0 && player==2 && sum2<rows-1)
    {
      //grow move
      comp_move(i,j);
      return 0;
    }
    

    
  }
  
  //coloums check
  for(j=0;j<cols;j++)
  {
    sum1=0;sum2=0;
    
    for(i=0;i<rows;i++)
    {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
    }
    
    if(sum1==0 && player==2 && sum2<rows-1)
    {
      //grow move
      comp_move(i,j);
      return 0;
    }
    
  }
  
  sum1=0;sum2=0;
  //diagonal 1 check
  for(i=0,j=0;i<rows;i++,j++)
  {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
  }
    
    if(sum1==0 && player==2 && sum2<rows-1)
    {
      //grow move
      comp_move(i,j);
      return 0;
    }
  
  sum1=0;sum2=0;
  //diagonal 2 check
  for(j=cols-1,i=0;j>=0;j--,i++)
  {
      if(Board[i][j].state==1)
        sum1++;
        
      else if(Board[i][j].state==2)
        sum2++;
  }
    
    if(sum1==0 && player==2 && sum2<rows-1)
    {
      //grow move
      comp_move(i,j);
      return 0;
    }   
 
    //other options
    else if(checkFull())
    {
      return rows;
    } 
    
    else if(player ==2)
      random_move();
      
      
 return 0;

}

boolean checkFull()
{
  int temp=0;

  for(int i=0;i<rows;i++)
  {
    for(int j=0;j<cols;j++)
    {
      if(Board[i][j].state!=0)
      {
        temp++;
      }
    }
  }
  
  return(temp==rows*cols);
  
}

void comp_move(int i,int j)
{
  //move of computer
  player=1;
  first_move=1;
  
  //easy level
  if(difficulty==0)
  {
    if(i==rows && j!=cols && j!=-1)
    {
      
      //if(Board[0][j].state==0)
      //  Board[0][j].state=2;
        
      //else if(Board[rows-1][j].state==0)
      //  Board[rows-1][j].state=2;
        

        for(i=0;i<rows;i++)
        {
          if(Board[i][j].state==0)
          {
            Board[i][j].state=2;
            break;
          }
        }
      
    }
    
    else if(j==cols && i!=rows)
    {
      //if(Board[i][0].state==0)
      //  Board[i][0].state=2;
        
      //else if(Board[i][cols-1].state==0)
      //  Board[i][cols-1].state=2;
         
        for(j=0;j<cols;j++)
        {
          if(Board[i][j].state==0)
          {
              Board[i][j].state=2;
              break;
          }
        }
      
    }
    
    else if(i==rows && j==rows)
    {
      
      //if(Board[rows/2][rows/2].state==0)
      //  Board[rows/2][rows/2].state=2;
        
          for(j=0,i=0;i<rows;j++,i++)
          {
            if(Board[i][j].state==0)
            {
                Board[i][j].state=2;
                break;
            }
            
          }
        
    }
      
    else if(i==rows && j==-1)
    { 
      //if(Board[rows/2][rows/2].state==0)
        //Board[rows/2][rows/2].state=2;
        
      for(j=cols-1,i=0;j>=0;j--,i++)
        {
          if(Board[i][j].state==0)
          {
              Board[i][j].state=2;
              break;
          }
          
        }
    }
  }
  
  if(difficulty==1)
  {
    if(i==rows && j!=cols && j!=-1)
    {
      
      //if(Board[0][j].state==0)
      //  Board[0][j].state=2;
        
      //else if(Board[rows-1][j].state==0)
      //  Board[rows-1][j].state=2;

        for(i=0;i<rows;i++)
        {
          if(Board[i][j].state==0)
          {
            Board[i][j].state=2;
            break;
          }
        }
    }
    
    else if(j==cols && i!=rows)
    {
      //if(Board[i][0].state==0)
      //  Board[i][0].state=2;
        
      //else if(Board[i][cols-1].state==0)
      //  Board[i][cols-1].state=2;
        
        for(j=0;j<cols;j++)
        {
          if(Board[i][j].state==0)
          {
              Board[i][j].state=2;
              break;
          }
        }
    }
    
    else if(i==rows && j==rows)
    {
      
      if(Board[rows/2][rows/2].state==0)
        Board[rows/2][rows/2].state=2;
        
        else
        {
          
          for(j=0,i=0;i<rows;j++,i++)
          {
            if(Board[i][j].state==0)
            {
                Board[i][j].state=2;
                break;
            }
            
          }
        
       }
    }
      
    else if(i==rows && j==-1)
    { 
      if(Board[rows/2][rows/2].state==0)
        Board[rows/2][rows/2].state=2;
      
      else{
        
      for(j=cols-1,i=0;j>=0;j--,i++)
        {
          if(Board[i][j].state==0)
          {
              Board[i][j].state=2;
              break;
          }
          
        }
      }
    }
  }
  
  //hard level
  if(difficulty==2)
  {
    if(i==rows && j!=cols && j!=-1)
    {
      
      if(Board[0][j].state==0)
        Board[0][j].state=2;
        
      else if(Board[rows-1][j].state==0)
        Board[rows-1][j].state=2;
        
      else
      {
        for(i=1;i<rows-1;i++)
        {
          if(Board[i][j].state==0)
          {
            Board[i][j].state=2;
            break;
          }
        }
      }
    }
    
    else if(j==cols && i!=rows)
    {
      if(Board[i][0].state==0)
        Board[i][0].state=2;
        
      else if(Board[i][cols-1].state==0)
        Board[i][cols-1].state=2;
       
      else
      {  
        for(j=1;j<cols-1;j++)
        {
          if(Board[i][j].state==0)
          {
              Board[i][j].state=2;
              break;
          }
        }
      }
    }
    
    else if(i==rows && j==rows)
    {
      
      if(Board[rows/2][rows/2].state==0)
        Board[rows/2][rows/2].state=2;
        
        else
        {
          
          for(j=0,i=0;i<rows;j++,i++)
          {
            if(Board[i][j].state==0)
            {
                Board[i][j].state=2;
                break;
            }
            
          }
        
       }
    }
      
    else if(i==rows && j==-1)
    { 
      if(Board[rows/2][rows/2].state==0)
        Board[rows/2][rows/2].state=2;
      
      else{
        
      for(j=cols-1,i=0;j>=0;j--,i++)
        {
          if(Board[i][j].state==0)
          {
              Board[i][j].state=2;
              break;
          }
          
        }
      }
    }
  }

}

void random_move()
{
  Random rand = new Random();
  player=1;
  first_move=1;
  
  while(1!=0)
  {
    int i=rand.nextInt(rows);
    int j=rand.nextInt(cols);
    
    if(Board[i][j].state==0)
    {
      Board[i][j].state=2;
      break;
    }

  }  
}

class Cell
{
  int x;
  int y;
  int state;
  
  Cell(int x,int y)
  {
    this.x=x;
    this.y=y;
    
  }
  
  void clean()
  {
    state=0;
  }
  
  void click()
  {
    if(state==0 && player==1)
      state=1;
      player=2;

  }
  
  void Display()
  {

    stroke(0);
    strokeWeight(3);
    rect(x,y,width/cols,height/rows);
    
    if(state==1)
    {
      ellipseMode(CORNER);
      stroke(0);
      ellipse(x,y,width/cols,height/rows);
      
    }
    
    else if(state==2)
    {
      stroke(0);
      line(x,y,x+width/cols,y+height/rows);
      line(x+width/cols,y,x,y+height/rows);
    }
    
  }
}