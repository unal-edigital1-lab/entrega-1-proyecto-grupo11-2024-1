# Entrega 1 del proyecto WP01
* Stewart Andres Antolinez Zapata
* Natalia Andrea Dueñas Salamanca
* Juan Diego Sáenz Ardila
## Especificación detallada del sistema 
### Componentes
Botones
* Reset: Reestablece el Tamagotchi a un estado inicial conocido al mantener pulsado el botón durante al menos 5 segundos. Este estado inicial simula el despertar de la mascota con salud óptima. Botón de la tarjeta de desarrollo de la FPGA.

* Test: Activa el modo de prueba al mantener pulsado por al menos 5 segundos, permitiendo al usuario navegar entre los diferentes estados del Tamagotchi con cada pulsación. Boton de la tarjeta de desarrollo de la FPGA.

* Dar_comer: Disminuye un porcentaje del tiempo a los estados al pulsarse. Botón de la tarjeta de desarrollo de la FPGA.

* Medicina: Disminuye un porcentaje del tiempo a los estados al pulsarse. Botón de la tarjeta de desarrollo de la FPGA.


![Botones tarjeta de desarrollo FPGA](<Imagenes/Botones FPGA.png>)

Sensores
* Sensor Ultra sonido: cuando este sensor detecte algo menor a una distancia determinada disminuye el tiempo sin cariño el cual afecta el estado Animo si el Tamagotchi se encuentra despierto y si esta dormido se despierta. Sensor Ultrasonido HC-SR04.



![[Link](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.puntoflotante.net%2FSENSOR-DISTANCIA-PROXIMIDAD-ULTRASONICO-HC-SR04.htm&psig=AOvVaw3XawL_13PjA-c5dnOsjxe6&ust=1713975300415000&source=images&cd=vfe&opi=89978449&ved=0CBUQ3YkBahcKEwi447_b3diFAxUAAAAAHQAAAAAQEQ)](Imagenes/Working-of-HC-SR04-Ultrasonic-Sensor-1024x394.jpg)

![[link](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.qbprofe.com%2Fautomatizacion-instrumentacion-industrial%2Ftutorial-de-arduino-con-sensor-ultrasonico-hc-sr04%2F&psig=AOvVaw3XawL_13PjA-c5dnOsjxe6&ust=1713975300415000&source=images&cd=vfe&opi=89978449&ved=0CBUQ3YkBahcKEwi447_b3diFAxUAAAAAHQAAAAAQIQ)](Imagenes/ww-PINES.jpg)

### Diagrama de caja negra

![Caja negra](<Imagenes/Caja negra.png>)


Como se puede observar en el diagrama de la caja negra, el módulo del sensor tiene como entradas Enable, clk, Echo, y como salidas Trigger, Done y Led. Dentro de la caja, se encuentran bloques internos que desempeñan funciones específicas, tales como Trigger, Echo y Tiempo.

En la caja de Trigger, se utiliza la señal de reloj (clk) y la señal de habilitación (Enable) para realizar un conteo en cada flanco de subida del pulso. Mientras el contador alcanza un valor de 10, el Trigger está activado. Luego, cuando el contador supera el valor de 10, el Trigger se desactiva y permanece así hasta que el contador alcanza el valor de 23333, que representa el mayor tiempo posible de medición. Este valor se calcula en base a la distancia máxima posible, que es de 400 cm.

La ecuación utilizada para calcular este tiempo máximo es: T=cm×0.01715. Una vez que el contador alcanza este valor, vuelve a cero para iniciar un nuevo ciclo de medición.

![Trigger](<Imagenes/Trigger.png>)


En la caja de Echo, se utiliza la señal de reloj (clk) y la señal de retorno del eco (Echo). En cada flanco de subida del pulso de reloj, si Echo está activo, se suma 1 al contador de Tiempo. Mientras Echo esté activo, la señal de Done permanece en 0, indicando que la medición está en curso. Cuando la señal de Echo finaliza, Done cambia a 1 y el contador de Tiempo se reinicia a 0.

![Echo](<Imagenes/Echo.png>)

En la caja de Tiempo, la salida del contador Tiempo del bloque Echo se compara con el valor de 583. Esta comparación se realiza porque ese es el tiempo en el que se determina que la medición es válida si se reemplaza la ecuación T = cm * 0.01715 por 10. Si el valor de Tiempo está en el rango de 0 a 583, el LED se enciende, indicando que la distancia medida está dentro del rango aceptable.

![Tiempo](<Imagenes/Tiempo.png>)

Visualización

 <!-- Pantalla LCD: Esencial para representar visualmente el estado actual del Tamagotchi, incluyendo emociones y necesidades básicas, ademas, es utilizado para mostrar niveles y puntuaciones específicas, como el nivel de Animo, Sueño, Salud y Energía, complementando la visualización principal, separando los espacios de la pantalla para destinarlo a la visualización del Tamagotchi y otra para los puntajes. Display Pantalla Lcd TFT 2.2 Pulgadas 240×320 SPI ILI9341 5V/3.3V. * -->

* Matriz LEDs 8x8: Permite la visualizacion adecuadad del Tamagotchi mostrando el estado actual y ademas segun el cuidado por medio de acciones que se le de al tamagotchi este podra pasar por todos sus estados y esta matriz sera lo que permita visualizarlo.

![Matriz 8x8](<Imagenes/Matriz 8x8.jpg>)

* Displays 7 segmentos: Permite conocer el nivel del estado en el cual se encuentra el Tamagotchi en una escala de 1 a 5, siendo 5 la maxima puntuacion indicando que se encuentra positivamente en ese estado, sin embargo por 
debajo de 3 indicaria que ese estado afecta negativamente como es el caso de salud que pasaria a enfermo o en animo pasaria a triste, etc. Displays 7 segmentos que se encuentran en la tarjeta de desarrollo de la FPGA.


![Dysplays de la tarjeta de desarrollo FPGA](<Imagenes/Displays FPGA.png>)

## Plan inicial de la arquitectura del sistema

