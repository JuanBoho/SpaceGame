class Personaje extends FBox{
  
  Personaje(float w_, float h_){
    super(w_, h_);
  }
  
  Boolean izquierda, derecha, arriba, abajo, disparo;
  int vel;
  float velocidad = 1000;
  float angulo = radians(90);
  PImage nave;
  
  
  void init(float _x, float _y){
    
    izquierda = false;
    derecha = false;
    arriba = false;
    abajo = false;
    disparo = false;
    nave = loadImage("personaje.png");
    
    vel = 100;
    setPosition(_x, _y);
    setRotatable(true);
    setDamping(0.8);
    setRestitution(0);
    setFriction(0);
   
    
    //cuerpo de personaje
    setName("personaje");
    attachImage(nave);
    
    
  }

  void dibujar() {
    //TODO   
    setRotation(angulo);

  }
  
  void control() {
    
    float dx = mouseX - getX();
    float dy = mouseY - getY();
    angulo = atan2(dy, dx);  
  }
  
  void disparar() {
    float factor = 0.02;
    float vx = velocidad * cos( angulo );
    float vy = velocidad * sin( angulo );
     
    FCircle bala = new FCircle( 5 );
    bala.setPosition( getX() + vx * factor, getY() + vy * factor);
    bala.setSensor(true);
    bala.attachImage(arma_personaje);
    bala.setName( "bala" );
    bala.adjustRotation(angulo);
    //contador
    
    bala.setVelocity( vx , vy );
    world.add( bala );
  }
  
  
  void actualizar(float tiempo_){
    
    if (izquierda){
        setVelocity(-vel, getVelocityY());
    }
    if (derecha){
      setVelocity(vel, getVelocityY());
      
    }
    if (!izquierda && !derecha){
      setVelocity(0, getVelocityY());
    }
    if (arriba){
      setVelocity(getVelocityX(), -vel);
    }
    if (abajo){
      setVelocity(getVelocityX(), +vel);
    }
    if(disparo && tiempo_ % 10 == 0){
      disparar();
    }
    
    dibujar();
    control();
    
}

  
}
