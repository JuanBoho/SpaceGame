/* -------------
 #TODO
 ....
 */



void atraer() {
  //Atrae los enemigos a la posición del personaje
  ArrayList <FBody> cuerpos = world.getBodies();
  for (FBody c : cuerpos ) {
    if (c.getName() == "obstaculo") {
      float dx = personaje.getX() - c.getX();
      float dy = personaje.getY() - c.getY();
      c.addForce(dx * 0.4, dy * 0.4);
    }
    if (c.getName() == "obstaculo_dos") {
      float dx = personaje.getX() - c.getX();
      float dy = personaje.getY() - c.getY();
      c.addForce(dx * 0.6, dy * 0.6);
    }
    if (c.getName() == "enemigoA" ||c.getName() == "enemigoB") {
      float dx = personaje.getX() - c.getX();
      float dy = personaje.getY() - c.getY();
      c.addForce(dx * 0.6, dy * 0.6);
    }
    if (c.getName() == "enemigoA_final" ||c.getName() == "enemigoB_final") {
      float dx = personaje.getX() - c.getX();
      float dy = personaje.getY() - c.getY();
      c.addForce(dx * 0.8, dy * 0.8);
    }
  }
}


void actualiza_obs() {
  //Actualiza obs
  ArrayList <FBody> obstaculos = world.getBodies();
  for (FBody obs : obstaculos ) {
    if ( obs.getName().equals( "obstaculo") ) {
      obs.setVelocity(obs.getVelocityX(), 80);
    } else if ( obs.getName().equals( "obstaculo_dos") ) {
      obs.setVelocity(obs.getVelocityX(), 40);
    }
  }
}


void borrarElementos() {
  //TODO: Borrar todo lo que salga de pantalla***
  ArrayList <FBody> cuerpos = world.getBodies();
  for ( FBody este : cuerpos ) {
    String nombre = este.getName();
    if ( nombre != null ) {
      //balas
      if ( nombre.equals("bala") ) {
        if ( este.getX() > width + 10 || este.getX() < -10 || este.getY() > height + 10 || este.getY() < -10) {
          world.remove( este );
        }
      }
      if ( nombre.equals("balita") ) {
        float d = dist( mouseX, mouseY, este.getX(), este.getY() );
        if ( d > 50) {
          world.remove( este );
        }
      }
      //obstaculos
      if ( nombre.equals("obstaculo") || nombre.equals("obstaculo_dos") ) {
        if ( este.getX() > width + 120 || este.getX() < -120 || este.getY() > height + 120 || este.getY() < -120) {
          world.remove( este );
        }
      }
    }
  }
}


void laserCol(FBody laser_, FBody cuerpo_) {
  //Anima y controla consecuencias de colisiones con las balas (elimina enemigos y escudos)
  float lsrX = laser_.getX();
  float lsrY = laser_.getY();
  
  switch(cuerpo_.getName()) {
    //---------------- Enem A----------------------------//
    case "enemigoA_final":
      lsr_anim(lsrX, lsrY, color(255, 0, 0));
      world.remove(cuerpo_);
      break;
      
    case "enemigoA":
      lsr_anim(lsrX, lsrY, color(255, 0, 0));
      cuerpo_.setName("enemigoA_final");
      cuerpo_.attachImage(loadImage("enemA_dam.png"));
      break;
    //---------------- Enem B----------------------------//
    case "enemigoB_final":
      lsr_anim(lsrX, lsrY, color(255, 0, 0));
      world.remove(cuerpo_);
      break;
      
    case "enemigoB":
      lsr_anim(lsrX, lsrY, color(255, 0, 0));
      cuerpo_.setName("enemigoB_final");
      cuerpo_.attachImage(loadImage("enemB_dam.png"));
      break;
    //---------------- Escudos----------------------------//
    case "enemigo_arma_final":
      lsr_anim(lsrX, lsrY, color(255, 0, 0));
      world.remove(cuerpo_);
      println("last hit");
      break;
    
    case "enemigo_arma":
      lsr_anim(lsrX, lsrY, color(255, 0, 0));
      cuerpo_.attachImage(escudo1_dam);
      cuerpo_.setName("enemigo_arma_final");
      println("tercer hit");
      break;
      
    case "enemigo_arma_dos_dam":
      lsr_anim(lsrX, lsrY, color(255, 0, 0));
      cuerpo_.attachImage(escudo1);
      cuerpo_.setName("enemigo_arma");
      println("segundo hit");
      break;
 
    case "enemigo_arma_dos":
      lsr_anim(lsrX, lsrY, color(255, 0, 0));
      cuerpo_.attachImage(escudo2_dam);
      cuerpo_.setName("enemigo_arma_dos_dam");
      println("primer hit");
      break; 
  }

  world.remove(laser_);
}


void lsr_anim( float x_, float y_, color col_) {

  for (int i = 0; i < 3; i++){
    FCircle bal = new FCircle(5);
    bal.setPosition(x_ + (i * 5), y_ + (i*5) );
    bal.addForce(random(100,150),random(100,150));
    bal.setAngularVelocity(15);
    bal.setName("balita");
    bal.attachImage(arma_reb);
    world.add(bal);
  }
}


//------------------------------- COLISIONES -------------------------------------------


boolean hayColisionEntre( FContact contact, String nombreUno, String nombreDos ) {
  boolean resultado = false;
  FBody uno = contact.getBody1();
  FBody dos = contact.getBody2();
  String etiquetaUno = uno.getName();
  String etiquetaDos = dos.getName();

  if ( etiquetaUno != null && etiquetaDos != null ) {

    if ( 
      ( nombreUno.equals( etiquetaUno ) && nombreDos.equals( etiquetaDos ) ) ||
      ( nombreDos.equals( etiquetaUno ) && nombreUno.equals( etiquetaDos ) )  
      ) {
      resultado = true;
    }
  }
  return resultado;
}


void contactStarted( FContact colision ) {
  
  //------Bala - Escudo1 enemigo (segundo disparo)-----
  if ( hayColisionEntre(colision, "bala", "enemigo_arma_final") ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();


    if ( uno.getName().equals("enemigo_arma_final") && dos.getName().equals("bala") ) laserCol(dos, uno);

    if ( uno.getName().equals("bala") && dos.getName().equals("enemigo_arma_final") ) laserCol(uno, dos);
  }
  
  //-------------------Bala - Escudo1 enemigo--------------
  if ( hayColisionEntre(colision, "bala", "enemigo_arma")  ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();


    if ( uno.getName().equals("enemigo_arma") && dos.getName().equals("bala") ) laserCol(dos, uno);

    if ( uno.getName().equals("bala") && dos.getName().equals("enemigo_arma") ) laserCol(uno, dos);
  }
  
  
  //------Bala - Escudo2 enemigo (segundo disparo)-----
  if ( hayColisionEntre(colision, "bala", "enemigo_arma_dos_dam") ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();


    if ( uno.getName().equals("enemigo_arma_dos_dam") && dos.getName().equals("bala") ) laserCol(dos, uno);

    if ( uno.getName().equals("bala") && dos.getName().equals("enemigo_arma_dos_dam") ) laserCol(uno, dos);
  }

  //-------------------Bala - Escudo2 enemigo--------------
  if ( hayColisionEntre(colision, "bala", "enemigo_arma_dos")  ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();


    if ( uno.getName().equals("enemigo_arma_dos") && dos.getName().equals("bala") ) laserCol(dos, uno);

    if ( uno.getName().equals("bala") && dos.getName().equals("enemigo_arma_dos") ) laserCol(uno, dos);
  }

  //-------------------Bala - EnemigoA--------------
  if ( hayColisionEntre(colision, "bala", "enemigoA_final") ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();


    if ( uno.getName().equals("enemigoA_final") && dos.getName().equals("bala") ) laserCol(dos, uno);

    if ( uno.getName().equals("bala") && dos.getName().equals("enemigoA_final") ) laserCol(uno, dos);
  }

  //-------------------Bala - EnemigoA--------------
  if ( hayColisionEntre(colision, "bala", "enemigoA") ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();


    if ( uno.getName().equals("enemigoA") && dos.getName().equals("bala") ) laserCol(dos, uno);

    if ( uno.getName().equals("bala") && dos.getName().equals("enemigoA") ) laserCol(uno, dos);
  }
  
  //-------------------Bala - EnemigoB--------------
  if ( hayColisionEntre(colision, "bala", "enemigoB_final") ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();


    if ( uno.getName().equals("enemigoB_final") && dos.getName().equals("bala") ) laserCol(dos, uno);

    if ( uno.getName().equals("bala") && dos.getName().equals("enemigoB_final") ) laserCol(uno, dos);
  }

  //-------------------Bala - EnemigoB--------------
  if ( hayColisionEntre(colision, "bala", "enemigoB") ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();


    if ( uno.getName().equals("enemigoB") && dos.getName().equals("bala") ) laserCol(dos, uno);

    if ( uno.getName().equals("bala") && dos.getName().equals("enemigoB") ) laserCol(uno, dos);
  }

  //-----------------Bala - obstáculo----------------------------
  if ( hayColisionEntre(colision, "bala", "obstaculo") ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();
    
    world.remove(uno);
    world.remove(dos);
    
  }

  //-----------------Bala - obstáculo_dos--------------------------
  if ( hayColisionEntre(colision, "bala", "obstaculo_dos") ) {
    FBody dos = colision.getBody2();
    world.remove(dos);
  }


  //------------------Obstaculo - Enemigo---------------------------
  if ( hayColisionEntre(colision, "obstaculo", "enemigo") ) {
    FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();

    if (uno.getName().equals("enemigo")) {
      world.remove( uno );
    }

    if (dos.getName().equals("enemigo")) {
      world.remove(dos);
    }
  }

  //---------------------Enemigo - Personaje -------------------------
  if ( hayColisionEntre( colision, "personaje", "enemigo_arma" ) ||
    hayColisionEntre( colision, "personaje", "enemigo_arma_final" ) ||
    hayColisionEntre( colision, "personaje", "enemigo" ) ||
    hayColisionEntre( colision, "personaje", "enemigo_final" )
    ) {
    println("Pierde");
    juego.pantalla_actual = 2;
  }

  //---------------------Obstaculo - Personaje-------------------------
  if ( hayColisionEntre(colision, "obstaculo_dos", "personaje") ) {
    //println("Pierde");
    juego.pantalla_actual = 2;
  }
}


//----------------INTERFAZ-------------------------

void texto(String texto_, float posx_, float posy_, int tamano_, boolean hover_) {
  // Función crea texto. Recibe texto, posición, medidas del contenedor, tamaño, y parametro hover_ 
  // hover_: en caso de ser true, cambia de color el texto si mouse está en la misma posición (como enlace web), evalúa si se hace click y si es el caso lleva a pantalla del juego (1). 
  textAlign(CENTER);
  fill(255);


  if (hover_) {
    if (dist(mouseX, mouseY, posx_, posy_) < 50) {
      fill(0);
      //cursor(HAND);
      if (juego.ui_click) {
        juego.reinicio();
      }
    } /*else {
     cursor(ARROW);
     }*/
  }

  textSize(tamano_);
  text(texto_, posx_, posy_);
}  
