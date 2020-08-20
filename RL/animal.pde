class Animal {
  int x;
  int y;
  int rows;
  int columns;
  float[][] Q;
  float[][] R;
  int[] entered;
  int[] destination = new int[2];
  Animal(int tempx, int tempy, int nr, int nc) {
    x=tempx;
    y=tempy;
    rows = nr;
    columns = nc;
    Q = new float[rows*columns][rows*columns];
    R = new float[rows*columns][rows*columns];
    entered = new int[rows*columns];
    for (int i=0; i<rows*columns; i++) {
      for (int j=0; j<rows*columns; j++) {
        Q[i][j] = 0;
      }
    }
    for (int i=0; i<rows*columns; i++) {
      entered[i] = 0;
    }
  }
  void see(float[][] r,int[] desti) {
    for (int i=0; i<R.length; i++) {
      for (int j=0; j<r[i].length; j++) {
        R[i][j] = r[i][j];
      }
    }
    destination = desti;
  }

  IntList get_possibles(int state) {
    IntList possibles = new IntList();
    for (int i=0; i<R[state].length; i++) {
      if (R[state][i]>=0) {
        possibles.append(i);
      }
    }
    return possibles;
  }

  void train(int period) {
    int initial_state =destination[0]*columns+destination[1];
      float ghama = 0.8;
      IntList possibles = get_possibles(initial_state);
      possibles.shuffle();
      IntList next_possibles = get_possibles(possibles.get(0));
      float[] Qs = new float[next_possibles.size()];
      for (int i=0; i<Qs.length; i++) {
        Qs[i] = Q[possibles.get(0)][next_possibles.get(0)];
      }
      //print(max(Qs));
      Q[initial_state][possibles.get(0)] = R[initial_state][possibles.get(0)];
    for (int j=period; j>=0; j--) {
      initial_state =floor(random(rows*columns));
      if(initial_state==destination[0]*columns+destination[1]){
        continue;
      }
      possibles = get_possibles(initial_state);
      if(possibles.size()==0){
        continue;
      }
      possibles.shuffle();
      next_possibles = get_possibles(possibles.get(0));
      Qs = new float[next_possibles.size()];
      for (int i=0; i<Qs.length; i++) {
        Qs[i] = Q[possibles.get(0)][next_possibles.get(i)];
      }
      if(Qs.length ==0){
        Qs = new float[1];
        Qs[0] = 0;
      }
      Q[initial_state][possibles.get(0)] = R[initial_state][possibles.get(0)] + ghama*max(Qs);
    }
  }
  void arra(){
    for(int i=0; i<Q.length; i++){
      for(int j=0; j<Q[i].length; j++){
        print(Q[i][j],' ');
      }
      print('\n');
    }
  }
  void display(){
    fill(255,0,0);
    rect(x,y,width/columns,height/rows);
  }
  
  IntList get_possibles2(int state) {
    IntList possibles = new IntList();
    for (int i=0; i<R[state].length; i++) {
      if (R[state][i]>=0) {
        if(entered[i]==0){
          possibles.append(i);
        }
      }
    }
    return possibles;
  }
  
  void move(){
    int state = x*columns/width + y*rows*columns/height;
    entered[state] = 1;
    IntList actions = get_possibles2(state);
    if(actions.size()>0){
      int best_action = actions.get(0);
    for(int i=0;i<actions.size();i++){
      if(Q[state][best_action] < Q[state][actions.get(i)]){
        best_action = actions.get(i);
      }
    }
    x = (best_action%columns)*width/columns;
    y = ((int)best_action/columns)*height/rows;
    }
  }
}
