class Enemigo {
  
  String tipoEnemigo;
  
  Enemigo() {
  }
  
  void init(String tipo_) {
    tipoEnemigo = tipo_; //TODO


    if (tipoEnemigo == "A") {
      EnemigoA enemA = new EnemigoA();
      enemA.init();
      enemA.dibuja();
    }

    if (tipoEnemigo == "B") {
      EnemigoB enemB = new EnemigoB();
      enemB.init();
      enemB.dibuja();
    }
  }
}

class EnemigoA extends Enemigo {

  EnemigoA() {
  }

  PImage forma, escudo;
  String tipoEnem;
  void init() {
    tipoEnem = "A";
    forma = enemigoA;
    escudo = escudo1;
  }

  void dibuja() {
    //Cuerpo Enemigo
    FBox cuerpoA = new FBox(40, 40);
    cuerpoA.attachImage(forma);
    cuerpoA.setPosition( random(25, width-25), random(-25, 100));
    cuerpoA.setGrabbable(false);
    //cuerpoA.setVelocity(0,100);
    cuerpoA.setDamping(0);
    cuerpoA.setName("enemigoA");
    cuerpoA.setFill(0, 150, 0);
    world.add(cuerpoA);

    // Arma enemigo
    float lnx = cuerpoA.getX();// + 25;
    float lny = cuerpoA.getY();// + 25;
    FCircle arma_A = new FCircle(120);
    arma_A.setPosition(lnx, lny);
    arma_A.setGrabbable(false);
    arma_A.setVelocity(0, 10);
    arma_A.setAngularVelocity(10);
    arma_A.setDamping(0);
    arma_A.setSensor(true);
    arma_A.setName("enemigo_arma");
    arma_A.attachImage(escudo);
    //arma_A.setFill(255,10);
    world.add(arma_A);



    FJoint anchor_A = new FDistanceJoint(cuerpoA, arma_A);
    anchor_A.setStroke(0, 0);

    world.add(anchor_A);
  }
}

class EnemigoB extends Enemigo {

  EnemigoB() {
  }
  
  PImage forma, escudo;
  String tipoEnem;
  
  void init() {
    tipoEnem = "B";
    forma = enemigoB;
    escudo = escudo2;
  }

  void dibuja() {
    //Cuerpo Enemigo
    FBox cuerpoB = new FBox(50, 50);
    cuerpoB.attachImage(forma);
    cuerpoB.setPosition( random(25, width-25), random(-25, 100));
    cuerpoB.setGrabbable(false);
    //cuerpoB.setVelocity(random(-150,150),100);
    cuerpoB.setDamping(0.1);
    cuerpoB.setName("enemigoB");
    //cuerpoB.setFill(0, 190, 20);
    world.add(cuerpoB);

    // Arma enemigo
    float lnx = cuerpoB.getX();
    float lny = cuerpoB.getY();

    FCircle arma_Ba = new FCircle(150);
    arma_Ba.setPosition(lnx, lny);
    arma_Ba.setVelocity(0, 10);
    arma_Ba.setAngularVelocity(15);
    arma_Ba.setDamping(0.1);
    arma_Ba.setGrabbable(false);
    arma_Ba.setSensor(true);
    arma_Ba.setName("enemigo_arma_dos");
    arma_Ba.attachImage(escudo);
    world.add(arma_Ba);

    FJoint anchor_A = new FDistanceJoint(cuerpoB, arma_Ba);
    world.add(anchor_A);
  }
  
  String tipoEnem(){
    return tipoEnemigo;
  }
}
