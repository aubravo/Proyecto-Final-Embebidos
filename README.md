# Proyecto Final Embebidos
by Alvaro Bravo

La libreria esta escrita en vala y diseñada para utilizar cualquiera de los Pololu Maestro Servo Controllers. Se incluye el programa ejemplo del uso de la libreria.



        int main(){
            int[] targets=  {1500,1500,1500,1500,1500,1500};
            int[] speeds=   {18,18,18,18,18,18};
            int[] accels=   {0,0,0,0,0,0}:
        
            var komm = new Komms();
            komm.startKomms("/dev/ttyACM0");
            
            komm.setAccels(accels);
            komm.setSpeeds(speeds);
            komm.setTargets(targets);
            
            komm.setAccels({0,0,0,0,0,0});
            komm.setSpeeds({0,0,0,0,0,0});
            komm.setTargets({0,0,0,0,0,0});
            
            komm.setAccel(0,0);
            komm.setSpeed(0,0);
            komm.setTarget(0,1500);
            
            return 0;
        }


Finalmente, para compilar el programa ejemplo incluido hay que ejecutar el siguiente comando.

    valac --pkg posix example.vala servo_control.vala
