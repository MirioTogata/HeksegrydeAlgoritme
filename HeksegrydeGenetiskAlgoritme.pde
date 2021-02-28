//variabler
int antalgryder = 20;
int mutationpct = 4;
int probability = 2;

ArrayList<PVector> muligeingredienser = new ArrayList<PVector>();
ArrayList<Gryde> currentgen = new ArrayList<Gryde>();
IntList bedstestyrker = new IntList();
int currentbedst = 0;
int totalstyrke = 0;
int randomnum = 0;
int bedsti = 0;

void setup() {
  size(800, 867);
  //Starter med at tilføje alle ingredienserne
  muligeingredienser.add(new PVector(220, 30)); //Eye of newt
  muligeingredienser.add(new PVector(120, 20)); //Toe of frog
  muligeingredienser.add(new PVector(305, 35)); //Wool of bat
  muligeingredienser.add(new PVector(500, 15)); //Tongue of dog
  muligeingredienser.add(new PVector(15, 50)); //Adder's Fork
  muligeingredienser.add(new PVector(50, 10)); //Blind worm's sting
  muligeingredienser.add(new PVector(60, 12)); //Lizard's leg
  muligeingredienser.add(new PVector(100, 15)); //Howlet's wing
  muligeingredienser.add(new PVector(250, 25)); //Hell broth
  muligeingredienser.add(new PVector(250, 35)); //Cauldron bubble
  muligeingredienser.add(new PVector(75, 15)); //Tooth of dragon
  muligeingredienser.add(new PVector(40, 8)); //Tooth of wolf
  muligeingredienser.add(new PVector(180, 20)); //Gall of goat
  muligeingredienser.add(new PVector(130, 15)); //Hemlock root
  muligeingredienser.add(new PVector(180, 28)); //Tiger's chaudron
  muligeingredienser.add(new PVector(280, 40)); //Slips of yew
  muligeingredienser.add(new PVector(420, 69)); //Baboon's bllood
  muligeingredienser.add(new PVector(380, 51)); //Bubble tonic
  muligeingredienser.add(new PVector(230, 28)); //Unicorn horn
  muligeingredienser.add(new PVector(140, 15)); //Phoenix feather

  for (int i = 0; i < antalgryder; i++) {
    currentgen.add(new Gryde(muligeingredienser, 2)); //Addede et 2, så den ved der skal være 1/2 chance for at den vælger en ingrediens
  }
}

void draw() {
  background(255);
  noLoop();
  for (int i = 0; i < 50; i++) {
    currentgen = nextGen(currentgen);
  }
  fill(0);
  for (int i = 0; i < bedstestyrker.size(); i++) {
    circle(width/bedstestyrker.size()*i+30, height-bedstestyrker.get(i)/5+30, 10);
  }
  text("Styrke:", 8, 15);
  text("Generation:", width-70, height-30);
  strokeWeight(3);
  stroke(30, 200, 30);
  line(20, 20, 20, height-20);
  line(20, height-20, width-20, height-20);
}

ArrayList<Gryde> nextGen(ArrayList<Gryde> currGen) { //nextGen er en funktion der skal kunne tage en nuværende generation og lave den om til en ny
  //starter med at lave en lang intliste med alle styrkerne
  IntList styrkerne = new IntList();
  for (Gryde gryde : currGen) {
    styrkerne.append((int)pow(gryde.totalstyrken, probability));
  }

  //derefter finder vi styrken af den stærkeste gryde, og finde ud af hvad styrken af alle gryderne tilsammen er
  currentbedst = 0;
  totalstyrke = 0;
  for (int i = 0; i < styrkerne.size(); i++) {
    totalstyrke += styrkerne.get(i);
    if (styrkerne.get(i) > currentbedst) {
      currentbedst = styrkerne.get(i);
      bedsti = i;
    }
  }
  println(currGen.get(bedsti).totalpladsen);
  bedstestyrker.append((int)sqrt(currentbedst));
  
  //så vil jeg finde "forældre" til mine gryder
  //en gryde har bedre chance for at være forældre jo bedre styrke den har
  ArrayList<Gryde> nextGen = new ArrayList<Gryde>();
  ArrayList<Gryde> foraeldre = new ArrayList<Gryde>();

  for (int i = 0; i < 2*currGen.size(); i++) {
    int cumuStyrke = 0;
    randomnum = (int)random(0, totalstyrke);
    for (int j = 0; j < styrkerne.size(); j++) {
      cumuStyrke += styrkerne.get(j);
      if (cumuStyrke > randomnum) {
        foraeldre.add(currGen.get(j));
        break;
      }
    }
  }
  assert(foraeldre.size() == currGen.size()*2);
  //der burde nu være dobbelt så mange forældre som der er gryder i den gamle generation
  //nu vil vi lave 200 nye gryder ud fra forældrene
  for (int i = 0; i<2*currGen.size(); i += 2) {
    ArrayList<PVector> grydee = new ArrayList<PVector>();

    for (int j = 0; j < foraeldre.get(i).gryde.size(); j++) {
      randomnum = (int)random(1, 3);
      if (randomnum == 1) {
        grydee.add(foraeldre.get(i).gryde.get(j));
      } else if (randomnum == 2) {
        grydee.add(foraeldre.get(i+1).gryde.get(j));
      }
    }
     //nu har vi en gryde med tilfældige elementer fra forældrene. Den laver vi nu
    nextGen.add(new Gryde(grydee, 1)); //tilføj en gryde til nextGen som har en 1/1 chance for at have alle ingredienser sat ind
  }
  
  //mutation virker desværre ikke
  for (Gryde gryde : nextGen){
    //gryde.mutate();
  }
  
  return nextGen;
}
