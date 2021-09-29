import oscP5.*;
import fisica.*;

Juego juego;
FWorld world;
Personaje personaje;
PGraphics pgraphics;

int tiempo;
float puntos;
PImage escudo1, escudo1_dam, escudo2, escudo2_dam;
PImage enemigoA, enemigoA_dam;
PImage enemigoB, enemigoB_dam;
PImage arma_personaje, arma_reb;

OscP5 oscP5;

void setup() {
  size(800, 600);
  
  oscP5 = new OscP5(this, 12000);
  
  // imgs
  arma_personaje = loadImage("arma_personaje.png");
  arma_reb = loadImage("arma_reb.png");
  
  enemigoA = loadImage("enemA.png");
  enemigoA_dam = loadImage("enemA_dam.png");
  
  enemigoB= loadImage("enemB.png");
  enemigoB_dam = loadImage("enemB_dam.png");
  
  escudo1 = loadImage("enem_escudo1.png");
  escudo1_dam = loadImage("enem_escudo1_dam.png");
  escudo2 = loadImage("enem_escudo2.png");
  escudo2_dam = loadImage("enem_escudo2_dam.png");
  
  //Juego
  Fisica.init(this);
  pgraphics = createGraphics(width, height);
  world = new FWorld();
  world.setEdges(- 50, -50, width + 50, height + 50);
  world.setGravity(0, 0);
  
  juego = new Juego();
  personaje = new Personaje(40,40);
  personaje.init(width/2, height/2);
}


void draw() {
  juego.display();
}


void keyPressed() {

  if (key == 'a') {
    personaje.izquierda = true;
  }
  if (key == 'd') {
    personaje.derecha = true;
  }
  if (key == 'w') {
    personaje.arriba = true;
  }
  if (key == 's') {
    personaje.abajo = true;
  }
}


void keyReleased() {
  if (key == 'a') {
    personaje.izquierda = false;
  }
  if (key == 'd') {
    personaje.derecha = false;
  }
  if (key == 'w') {
    personaje.arriba = false;
  }
  if (key == 's') {
    personaje.abajo = false;
  }
}

void mousePressed() {
    personaje.disparo = true;

}

void mouseReleased() {
  personaje.disparo = false;
  juego.ui_click = true;
}

void oscEvent(OscMessage m) {
  //println(m);

  if (m.addrPattern().equals("/wek/outputs")) {
    println(m.get(0).floatValue());
    if (m.get(0).floatValue() == 1) {
      personaje.disparo = false;
    }
    if (m.get(0).floatValue() == 2) {
      personaje.disparo = true;
    }
    else {
      println("entran otros mensajes");
    }
  }
}
