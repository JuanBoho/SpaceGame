class Juego {

  Juego() {
  }

  int pantalla_actual = 0;
  int tiempo = 0; 
  float puntos = 0;
  IntList maximos [];
  boolean ui_click = false;
  PImage ui_cursorA = loadImage("cursor.png");
  PImage ui_cursorB = loadImage("star1.png");
  PImage ui_cursorC = loadImage("star2.png");
  


  void init() {
    puntos = 0;
    tiempo = 2;
    pantalla_actual = 1;
    world.add(personaje);
  }

  void display() {
    // Dibuja estados según var pantalla_actual
    switch( pantalla_actual) {
    case 0:
      pantallaInicio();
      break;

    case 1:
      pantallaJuego();
      break;

    case 2:
      pantallaFin();
      break;

    default:
      texto("¡ERROR!", width * 0.5, height * 0.5, 70, false);
      println("Error en asignación de pantalla. pantalla_actual = ", pantalla_actual);
      juego.ui_click = false;
      break;
    }
  }


//--------------------------------PANTALLAS DE JUEGO------------------------------------------
  
  void pantallaInicio() {
    //Pantalla de Inicio: Muestra instrucciones, créditos y opción iniciar Juego.
    
    push();
    background(0, 115, 128);
    cursor(ui_cursorA);
    //Instrucciones
    texto("Movimiento: WASD.", width/2, height * 0.40, 20, false);
    texto("Disparo: CLick (izq).", width/2, height * 0.50, 20, false);

    //Créditos
    texto("Juan Bohórquez", width * 0.85, height * 0.95, 10, false);
    texto("Informática Aplicada II - ATAM", width * 0.85, height * 0.90, 10, false);

    //Botón de inicio
    texto("Iniciar", width/2, height * 0.60, 20, true);

    pop();
    juego.ui_click = false;
  }


  void pantallaJuego() {
    // Pantalla del juego
    
    background(15);
    if (mousePressed){
      cursor(ui_cursorC);
    }
    else{
      cursor(ui_cursorB);
    }
    
    world.step();
    world.draw();
    atraer();
    personaje.actualizar(tiempo);

    //Creo enemigos
    if ( tiempo % 280 == 0 ) { //60
      Enemigo enemigo = new Enemigo();
      enemigo.init("A");
    }


    if ( tiempo % 460 == 0 ) {
      Enemigo enemigo = new Enemigo();
      enemigo.init("B");
    }

    if ( tiempo % 860 == 0 ) {
      Obstaculo obs_A = new Obstaculo(80,80, "A");
      obs_A.init(random(25, width-25), random(-25, 100));
      world.add(obs_A);
    }

    if ( tiempo % 1260 == 0 ) {
      Obstaculo obs_B = new Obstaculo(160,160, "B");
      obs_B.init(random(25, width-25), random(-25, 100));
      world.add(obs_B);
    }
    
    
    actualiza_obs();
    borrarElementos();
    tiempo += 1;
    puntaje();

    juego.ui_click = false;
  }


  void pantallaFin() {
    //Muestra pantalla de fin con el puntaje alcanzado y el máximo de la partida

    push();
    background(0, 115, 128);
    cursor(ui_cursorA);

    texto("Puntaje", width * 0.25, height * 0.35, 15, false); //imprime texto

    if (puntos > 20000) {
      texto("¡Nuevo Récord!", width * 0.25, height * 0.30, 30, false);
    }

    texto(str(round(puntos)), width * 0.25, height * 0.50, 100, false);

    //Puntajes máximos
    texto("Récord:", width * 0.75, height * 0.35, 15, false);
    texto(str(round(puntos)), width * 0.75, height * 0.50, 70, false);

    texto("Reiniciar", width / 2, height * 0.80, 20, true);//imprime texto
    pop();
    juego.ui_click = false;
  }

//-------------------------------- FUNCIONES JUEGO ------------------------------------------

  void reinicio() {
    //Reinicia juego
    
    ArrayList <FBody> cuerpos_juego = world.getBodies();
    juego.ui_click = false;
    //Borro los objetos del juego excepto el personaje
    if (cuerpos_juego.size() > 0) {
      for (FBody cuerpo : cuerpos_juego) {
        world.remove(cuerpo);
      }
    }

    juego.init();
  }

  void puntaje() {
    //Control de puntos
    
    puntos += tiempo * 0.0002;
    fill(10, 10);
    rect(0, 0, 150, 50);
    fill(255, 0, 0);
    texto("Puntaje: "+round(puntos), width * 0.10, height * 0.05, 15, false);
  }
}
