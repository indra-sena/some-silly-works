class Board{
  int rows;
  int columns;
  int[][] isBlock;
  int l ;
  int b;
  float[][] R;
  int[] start = {0,0};
  int[] end = {0,0};
  Board(int nr,int nc){
    rows = nr;
    columns = nc;
    l = width/nc;
    b = height/nr;
    end[0] = (nr-1);
    end[1] = (nc-1);
  }
  
  void initiate(){
    isBlock = new int[rows][columns];
    R = new float[rows*columns][rows*columns];
    for(int i=0; i<rows; i++){
      for(int j=0; j<columns; j++){
        if(random(10)<2 && (i!=end[0] || j!= end[1]) && (i!=start[0] || j!= start[1])){
          isBlock[i][j] = 1;
        }
        else{
          isBlock[i][j] = 0;
        }
      }
    }
    for(int i=0;i<rows*columns;i++){
      for(int j=0;j<rows*columns;j++){
        boolean check = (i+1==j && j%columns!=0)||(i+columns==j)||(i-columns==j) ||(i-1==j && i%columns!=0);
        if(isBlock[(int)i/columns][i%columns]==1){
          R[i][j]=-1;
        }
        else if(i==end[0]*columns+end[1]){
          if(j==end[0]*columns+end[1]){
            R[i][j] = 100;
          }
          else{
            R[i][j] = -1;
          }
        }
        else if(check){
          R[i][j] = 0;
        }
        else{
          R[i][j] = -1;
        }
        
      }
    }
  }
  void display(){
    for(int i=0; i<rows; i++){
      for(int j=0; j<columns; j++){
        if(isBlock[i][j]==1){
          fill(0);
          rect(j*l,i*b,l,b);
        }
        stroke(255);
        line(j*l,0,j*l,height);
      }
      stroke(255);
      line(0,i*b,width,i*b);
    }
    fill(0,255,0);
    rect(end[1]*l,end[0]*b,l,b);
    fill(0,0,255);
    rect(start[1]*l,start[0]*b,l,b);
  }
  void arra(){
    for(int i=0; i<isBlock.length; i++){
      for(int j=0; j<isBlock[i].length; j++){
        print(isBlock[i][j],' ');
      }
      print('\n');
    }
  }
}
