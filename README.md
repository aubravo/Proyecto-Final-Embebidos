# Proyecto Final Embebidos
by Alvaro Bravo

# Crontrol de Servos
La libreria esta escrite en vala y diseñada para utilizar cualquiera de los Pololu Maestro Servo Controllers. Se incluye un programa ejemplo del uso de la libreria.


#Compilación
Para compilar el programa de contro es necesario incluir la libreria en los argumentos del compilador. De tal manera que para compilar el programa ejemplo incluido hay que ejecutar el siguiente comando.

    valac --pkg posix example.vala servo_control.vala
