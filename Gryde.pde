class Gryde {
  int totalstyrken;
  int totalpladsen;
  ArrayList<PVector> gryde = new ArrayList<PVector>();

  Gryde (ArrayList<PVector> ingredienser, int randomvalue) { //en konstruktør som giver gryden nogle ingredienser fra den liste den får (samt regner total plads og styrke)
    for (int i = 0; i < ingredienser.size(); i++) {
      int random = (int)random(1, randomvalue+1);
      assert(random <= randomvalue);
      if (random == 1) {
        gryde.add(ingredienser.get(i));
        totalstyrken += ingredienser.get(i).x;
        totalpladsen += ingredienser.get(i).y;
      } else {
        gryde.add(new PVector(0, 0));
      }
    }
    if (totalpladsen > 305) { //sætter styrken til 0 hvis gryden fylder over. Dette gør at den ikke kan blive valgt til den næste generation.
      totalstyrken = 0;
    }
  }

  void mutate() {
    if ((int)random(0, 100) < mutationpct) {
      int random = (int)random(0, gryde.size());  
      if (gryde.get(random).x == 0) {
        gryde.get(random).set(muligeingredienser.get(random).copy());
      } else {
        gryde.get(random).set(0,0);
      }
    }
  }
}
