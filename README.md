# Entrega 1 del proyecto WP01
- Stewart Andres Antolinez Zapata `santolinez@unal.edu.co` 
- Natalia Andrea Dueñas Salamanca `nduenass@unal.edu.co`
- Juan Diego Saenz Ardila `jsaenza@unal.edu.co`
## Especificación detallada del sistema 

## Botones y Sensores

La parte que permite realizar acciones que alternen el estado del **`Tamagotchi`** es debido en gran medida esta _**Caja Negra**_ denominada como _**Sistema de Botones**_ desde las cuales se encuentran 5 modos de interaccion gracias a sus entradas (_`Testeo`_, _`rst`_, _`alimentacion`_, _`salud`_, y _`cerca`_) y sus salidas seran _`cont_t`_ y _`t_sin_cariño`_, al interior de _**Sistema de Botones**_ se encuentra un _**Divisor de frecuencia**_ que permite regular y definir los tiempos de las señales digitales que se generan con las acciones de las entradas y asi mismo gestionar las de salida, por otro lado el _**Gestor_Modo**_ distingue si el **`Tamagotchi`** vuelve a su modo inicial o entra en modo testeo, mientras que el gestor tiempo, tomas las acciones a realizar directamente con el **`Tamagotchi`** lo cual provoca que sus estados se alteren y de esa manera mejoren o empeoren dependiendo si se realizo la accion o no. 

![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/112878997/13d82daa-3f7b-4d26-a51d-5599f71428ee)
![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/112878997/4996ebc7-635b-4790-ae42-2b5e49de6a17)




### Componentes
***Botones***
* `Reset`: Para restablecer el Tamagotchi a un estado inicial conocido, simplemente mantén pulsado el botón durante al menos 5 segundos. Este estado inicial simula el despertar de la mascota con salud óptima. El botón necesario para realizar esta acción se encuentra en la tarjeta de desarrollo de la FPGA.

* `Test`: Activa el modo de prueba al mantener pulsado por al menos 5 segundos, permitiendo al usuario navegar entre los diferentes estados del Tamagotchi con cada pulsación. Este sera un boton de la tarjeta de desarrollo de la FPGA.

![Botones tarjeta de desarrollo FPGA](<Imagenes/Botones FPGA.png>)

* `Boton_Comida`: al presionar el botón destinado para cuidar la alimentación del tamagotchi. Cada vez que lo hagas, el nivel de comida aumentará en 1 (si no está en el nivel máximo). Además, durante los siguientes 5 segundos, verás una visualización especial: si tu Tamagotchi está hambriento o desnutrido, aparecerá una imagen que representa que está comiendo.

* `Boton_Medicina`: al presionar el botón destinado para cuidar la salud del tamagotchi. Cada vez que lo hagas, el nivel de salud aumentará en 1 (si no está en el nivel máximo). Además, durante los siguientes 5 segundos, verás una visualización especial: si tu Tamagotchi está en los estados de tos o fiebre, aparecerá una imagen que representa que está recibiendo una píldora para mejorar su salud. 

![Pulsadores](Imagenes/Pulsadores.png)



***Sensores***
* `Sensor Ultra sonido`: Utiliza el sensor de ultrasonido HC-SR04. Cuando este sensor detecte algo a una distancia menor a un umbral determinado, aumentará el nivel de ánimo de tu mascota virtual. Además, durante el tiempo en que el sensor esté activo y detectando objetos cercanos, verás una visualización específica en la pantalla. Pero eso no es todo: si tu Tamagotchi se encuentra en los estados de tristeza o depresión, cuando la señal del sensor sea 1, verás una imagen que representa a tu Tamagotchi recibiendo cariño. Si esta señal persiste durante 15 segundos o más, el nivel de cariño subirá en 1 (a menos que ya esté en el nivel máximo).



![[Link](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.puntoflotante.net%2FSENSOR-DISTANCIA-PROXIMIDAD-ULTRASONICO-HC-SR04.htm&psig=AOvVaw3XawL_13PjA-c5dnOsjxe6&ust=1713975300415000&source=images&cd=vfe&opi=89978449&ved=0CBUQ3YkBahcKEwi447_b3diFAxUAAAAAHQAAAAAQEQ)](Imagenes/Working-of-HC-SR04-Ultrasonic-Sensor-1024x394.jpg)

![[link](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.qbprofe.com%2Fautomatizacion-instrumentacion-industrial%2Ftutorial-de-arduino-con-sensor-ultrasonico-hc-sr04%2F&psig=AOvVaw3XawL_13PjA-c5dnOsjxe6&ust=1713975300415000&source=images&cd=vfe&opi=89978449&ved=0CBUQ3YkBahcKEwi447_b3diFAxUAAAAAHQAAAAAQIQ)](Imagenes/ww-PINES.jpg)

* `Sensor de Luz`: cuando este sensor detecte sombra o una determinada ausencia de luz aumenta el nivel de decanso, y durante el tiempo que que el sensor este registrando esa ausencia de luz este mostrara una visualización determinada para ese caso. Modulo Sensor De Luz Con Ldr Fotoresistor.

![Modulo Sensor De Luz Con Ldr Fotoresistor](<Imagenes/Modulo Sensor De Luz Con Ldr Fotoresistor.jpg>)




### Diagrama de caja negra

#### Ultra Sonido
![Ultra_Sonido Caja Negra](<Imagenes/Ultra_Sonido Caja Negra.png>)

Como se puede observar en el diagrama de la caja negra, el módulo del sensor tiene como entradas Enable, clk, Echo, y como salidas Trigger, Done y Led. Dentro de la caja, se encuentran bloques internos que desempeñan funciones específicas, tales como Trigger, Echo y Tiempo.

En la caja de Trigger, se utiliza la señal de reloj (clk) y la señal de habilitación (Enable) para realizar un conteo en cada flanco de subida del pulso. Mientras el contador alcanza un valor de 10, el Trigger está activado. Luego, cuando el contador supera el valor de 10, el Trigger se desactiva y permanece así hasta que el contador alcanza el valor de 23333, que representa el mayor tiempo posible de medición. Este valor se calcula en base a la distancia máxima posible, que es de 400 cm.

La ecuación utilizada para calcular este tiempo máximo es: T=cm×0.01715. Una vez que el contador alcanza este valor, vuelve a cero para iniciar un nuevo ciclo de medición.

En la caja de Echo, se utiliza la señal de reloj (clk) y la señal de retorno del eco (Echo). En cada flanco de subida del pulso de reloj, si Echo está activo, se suma 1 al contador de Tiempo. Mientras Echo esté activo, la señal de Done permanece en 0, indicando que la medición está en curso. Cuando la señal de Echo finaliza, Done cambia a 1 y el contador de Tiempo se reinicia a 0.

En la caja de Tiempo, la salida del contador Tiempo del bloque Echo se compara con el valor de 583. Esta comparación se realiza porque ese es el tiempo en el que se determina que la medición es válida si se reemplaza la ecuación T = cm * 0.01715 por 10. Si el valor de Tiempo está en el rango de 0 a 583, el LED se enciende, indicando que la distancia medida está dentro del rango aceptable.

#### Botones

![Boton_AR Caja Negra](<Imagenes/Boton_AR Caja Negra.png>)


![Botones_antirrebote Caja Negra](<Imagenes/Botones_antirrebote Caja Negra.jpg>)
#### Modos

![Modo_Primitivo Caja Negra](<Imagenes/Modo_Primitivo Caja Negra.png>)

![Modos Caja Negra](<Imagenes/Modos Caja Negra.png>)


## Visualización 

### Caras del tamagotchi

https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/104275525/9c62217a-6f50-416d-ab35-48fc5d4133bf



Al interior del _**Diagrama de cajas negras general**_ se encuentran 2 diagramas claves para visualizar lo que esta ocurriendo con el **`Tamagotchi`**  son 2, una esta destinada para dar a conocer el **estado** en el que se encuentra el **`Tamagotchi`** y adicionalmente como se encuentra al interior de ese estado, para esto se emplean los _**Displays 7 Segmentos**_ que se encuentran en la _tarjeta de desarrollo_ en la que esta la `FPGA`.

En el _**Diagrama de cajas negras de los Displays 7 Segmentos**_ se observa como tienen 3 entradas: _`Es_animo`_, _`cont_t`_ y _`t_sin_cariño`_, y 2 salidas: _`SSeg`_ y _`an`_, las entradas pasan por una primera caja interna que es _**Gestor Display**_ la cual va a reconocer el estado en el que se encuentra el **`Tamagotchi`**, y los tiempos que poseen cada uno de esos estados para conocer y asi conocer el nivel de satisfaccion del **`Tamagotchi`** todo eso va a llegar a una salida que sera entrada de _*Display*_ la cual ya se encarga de convertir esa entrada en visualizacion para el usuario por medio de los LEDs de los _**Displays 7 Segmentos**_ empleados, en los displays se apreciara un indicativo del estado y en una escala de 1 a 5 siendo 1 la peor valoracion del estado y 5 la mejor valoracion para que asi el usuario conozca de forma mas detallada el comportamiento de su **`Tamagotchi`** y llevarlo a tomar la decision si realizar acciones o no.

![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/112878997/f1e543de-60a4-4a4b-a355-22469b32c3ed)
![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/112878997/73f25857-8fce-477b-b364-71b840822b5b)



[SUBIR IMAGEN SEUDO CODIGO]

La otra mitad de la visualizacion que es muy importante es la _**Caja negra**_ denominada como _**Visualizacion**_ que sera la parte encargada de mostrar el **`Tamagotchi`**, permitiendo asi que el usuario aprecie las expresiones dependiendo del estado en el que se encuentre el **`Tamagotchi`**. Esta _**Caja negra**_ posee de entradas: _`clk`_, _`rst`_, _`State`_ Y _`init`_, y como salidas: _`sclk`_, _`mosi`_, _`cs`_ y _`done`_.

![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/112878997/545de233-3314-4d66-b55d-e9d48cb791bd)


Al interior de _**Visualización**_ se encuntran _**FSM CARAS**_ y _**SPI MASTER**_. En _**FSM CARAS**_ llegan todas la entradas mencionadas, y al interior de esta se encuentra: _**Memoria Cajas**_ y _**Maneja Estados**_, lo que ocurre al interior de la _**Memoria Cajas**_ depues de asignar las entradas y salidas de su respectiva **Caja negra** es que gracias al _**Coordinador**_ hace que todos los estados sean optimos para visualizar, y gracias al banco de registro hara que la visualizacion de las operaciones que se realicen se logren visualizar nuevamente sin llegar a realizar nuevamente las operaciones. Finalizando la _sub caja negra_ de _**FSM CARAS**_ se encuentra _**Maneja Estados**_ el cual se encargara de conectar con el `protocolo SPI` designado para el uso de la matriz 8x8 seleccionada.

![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/112878997/ad75c09d-8bda-4495-af07-c16fba0fae1f)
![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/112878997/f1dd35fb-ccf6-45be-9240-d5b67ea899e8)
![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/assets/112878997/e4d6c746-8421-43bc-82db-36252f699843)


El _**SPI MASTER**_ va a cumplir con la funcion de trasmitir los datos que le lleguen (_`Reg/Val`_, _`spiStart`_, _`spiAvail`_ y _`spiBusy`_) de una manera tal que sea sencilla de comprender y apreciar en la Matriz de LEDs 8x8 seleccionada gracias a las salidas: _`sclk`_, _`mosi`_ y _`cs`_.

Visualización

 <!-- Pantalla LCD: Esencial para representar visualmente el estado actual del Tamagotchi, incluyendo emociones y necesidades básicas, ademas, es utilizado para mostrar niveles y puntuaciones específicas, como el nivel de Animo, Sueño, Salud y Energía, complementando la visualización principal, separando los espacios de la pantalla para destinarlo a la visualización del Tamagotchi y otra para los puntajes. Display Pantalla Lcd TFT 2.2 Pulgadas 240×320 SPI ILI9341 5V/3.3V. * -->

* Matriz LEDs 8x8: Permite la visualizacion adecuadad del Tamagotchi mostrando el estado actual y ademas segun el cuidado por medio de acciones que se le de al tamagotchi este podra pasar por todos sus estados y esta matriz sera lo que permita visualizarlo.

![Matriz 8x8](<Imagenes/Matriz 8x8.jpg>)

* Displays 7 segmentos: Permite conocer el nivel del estado en el cual se encuentra el Tamagotchi en una escala de 1 a 5, siendo 5 la maxima puntuacion indicando que se encuentra positivamente en ese estado, sin embargo por 
debajo de 3 indicaria que ese estado afecta negativamente como es el caso de salud que pasaria a enfermo o en animo pasaria a triste, etc. Displays 7 segmentos que se encuentran en la tarjeta de desarrollo de la FPGA.


![Dysplays de la tarjeta de desarrollo FPGA](<Imagenes/Displays FPGA.png>)

## Plan inicial de la arquitectura del sistema

La caja negra principal del sistema es la siguiente
![caja negra](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/blob/main/Imagenes/caja%20negra%20principal.jpeg)

A continuación se explicara la maquina de estados finitos de las emociones:

En este diagram se aprecia como el `Tamagotchi` va a pasar por todos los diferentes estados para los que esta diseñado, esto lo logra por medio de tiempo en donde se tiene que tiene un estado base apenas comienza su funcionamiento esl cual es animo, despues de trancurrido cierta cantidad de tiempo ocurre que va a ir alternando entre estados, entonces lo que sucede es que habra un contador de tiempo que sera el encargado de determinar el estado en que se encuentre y cuando cambiar de estado, se parte desde un estado base que es animo (Feliz o Triste), como se aprecia en la imagen se tiene que despues de un tiempo del estado animo se pasa al estado sueño y posteriormente al de salud, sin embargo se aprecia que para ir del estado de sueño al de animo el contador vuelve a iniciar, esto se debe a que se genera alguna de las acciones designadas anteriormente, como lo es el de Dar_Comida, probocando que vuelva a animo y de ahi pueda pasar al estado energia. Adicionalmente se tiene un segundo contador que es lo que permitira cambios dentro del estado animo, el cual es un tiempo que indica cuanto tiempo pasa el tamagotchi sin recibir afecto y por ende pasa a estar en un estad alterno a animo el cual es troste.

![maquina de estados finitos](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/blob/main/Imagenes/maquina%20de%20estados%20finitos.jpeg)

El estado inicial es el estado init, este se hace para mandar la señal para que la pantalla de inicie. Una vez hecho esto espera un tiempo para pasar a los estados de animo.

Estos estados de animo cambian segun 2 registros que son t_sin_cariño y cont_t, estas dos se encuentran representadas en segundos pero en el diagrama se escriben en minutos para facilidad de representación. Segun el estado el registro Es_animo cambiará , según este la visualización. 

El gestor display se basa en los tiempos para la información que le será enviada a los display. Los números mayores a 5 serán lo que se represente como los casos criticos donde deberia ser 0, esto para que el display los lea y segun este los leds que prendera en los distintos anodos. El número 6 será sad, 7 sleepy, 8 sick, 9 tired. 

![bloque de cajas para gestor display](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/blob/main/Imagenes/bloque%20de%20cajas%20para%20gestor%20display.jpeg)
