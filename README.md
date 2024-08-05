# Entrega 1 del proyecto WP01
- Stewart Andres Antolinez Zapata `santolinez@unal.edu.co` 
- Natalia Andrea Dueñas Salamanca `nduenass@unal.edu.co`
- Juan Diego Saenz Ardila `jsaenza@unal.edu.co`
## Especificación detallada del sistema 

### Componentes
**Botones**
* `Reset`: Para restablecer el Tamagotchi a un estado inicial conocido, simplemente mantén pulsado el botón durante al menos 5 segundos. Este estado inicial simula el despertar de la mascota con salud óptima. El botón necesario para realizar esta acción se encuentra en la tarjeta de desarrollo de la FPGA.

* `Test`: Activa el modo de prueba al mantener pulsado por al menos 5 segundos, permitiendo al usuario navegar entre los diferentes estados del Tamagotchi con cada pulsación. Este sera un boton de la tarjeta de desarrollo de la FPGA.

![Botones tarjeta de desarrollo FPGA](<Imagenes/Botones FPGA.png>)

* `Boton_Comida`: al presionar el botón destinado para cuidar la alimentación del tamagotchi. Cada vez que lo hagas, el nivel de comida aumentará en 1 (si no está en el nivel máximo). Además, durante los siguientes 5 segundos, verás una visualización especial: si tu Tamagotchi está hambriento o desnutrido, aparecerá una imagen que representa que está comiendo.

* `Boton_Medicina`: al presionar el botón destinado para cuidar la salud del tamagotchi. Cada vez que lo hagas, el nivel de salud aumentará en 1 (si no está en el nivel máximo). Además, durante los siguientes 5 segundos, verás una visualización especial: si tu Tamagotchi está en los estados de tos o fiebre, aparecerá una imagen que representa que está recibiendo una píldora para mejorar su salud. 

![Pulsadores](Imagenes/Pulsadores.png)



**Sensores**
* `Sensor Ultra sonido`: Utiliza el sensor de ultrasonido HC-SR04. Cuando este sensor detecte algo a una distancia menor a un umbral determinado, aumentará el nivel de ánimo de tu mascota virtual. Además, durante el tiempo en que el sensor esté activo y detectando objetos cercanos, verás una visualización específica en la pantalla. Pero eso no es todo: si tu Tamagotchi se encuentra en los estados de tristeza o depresión, cuando la señal del sensor sea 1, verás una imagen que representa a tu Tamagotchi recibiendo cariño. Si esta señal persiste durante 15 segundos o más, el nivel de cariño subirá en 1 (a menos que ya esté en el nivel máximo).



![[Link](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.puntoflotante.net%2FSENSOR-DISTANCIA-PROXIMIDAD-ULTRASONICO-HC-SR04.htm&psig=AOvVaw3XawL_13PjA-c5dnOsjxe6&ust=1713975300415000&source=images&cd=vfe&opi=89978449&ved=0CBUQ3YkBahcKEwi447_b3diFAxUAAAAAHQAAAAAQEQ)](Imagenes/Working-of-HC-SR04-Ultrasonic-Sensor-1024x394.jpg)

![[link](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.qbprofe.com%2Fautomatizacion-instrumentacion-industrial%2Ftutorial-de-arduino-con-sensor-ultrasonico-hc-sr04%2F&psig=AOvVaw3XawL_13PjA-c5dnOsjxe6&ust=1713975300415000&source=images&cd=vfe&opi=89978449&ved=0CBUQ3YkBahcKEwi447_b3diFAxUAAAAAHQAAAAAQIQ)](Imagenes/ww-PINES.jpg)

* `Sensor de Luz`: cuando este sensor detecte sombra o una determinada ausencia de luz aumenta el nivel de decanso, y durante el tiempo que que el sensor este registrando esa ausencia de luz este mostrara una visualización determinada para ese caso. Modulo Sensor De Luz Con Ldr Fotoresistor.

![Modulo Sensor De Luz Con Ldr Fotoresistor](<Imagenes/Modulo Sensor De Luz Con Ldr Fotoresistor.jpg>)

### Visualización

* `Pantalla ILI9341`: .................

![ILI9341](Imagenes/ILI9341.jpg)

# tamagotchi

## Caja Negra

![caja negra](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/blob/main/Imagenes/caja_negra_funcionamiento.png)


## Maquina de Estados

![caja negra](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/blob/main/Imagenes/MEF_resumida.png)

La maquina de estados finitos parte desde un estado IDLE donde recibe información de todos los sensores. Si uno de los Niveles baja a 2 va al estado de este nivel, es necesario aclarar que estos estados tienen 3 estados internos que seran explicados en la maquina de estados finitos visto de una forma más especifica (según el estado el parametró de visualización que sera entregado) , la única forma de salir es volviendo al Nivel 3 por medio de los sensores o utilizando el boton reset ( o el boton test como se vera a continuación) . Si el nivel en uno de los 4 estados internos permanece en 0 durante más de 59 segundos, este morira siendo el boton reset la única forma de volver. 

![caja negra](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo11-2024-1/blob/main/Imagenes/MEF_general.png)

Observando cada uno de los estados generales se compone de 3 estados, uno transitorio que se activa al utilizar el sensor de ese respectivo estado, y los otros 2 dependientes del nivel, en el estado donde el Nivel es 0, se activa el contador muerte. El contador retornara a 0, de presiona de estar en uno de los estados transitorios. Es importante aclarar que en el caso de animo y sueño si se puede devolver al peor estado, esto es porque funcionan con sensores y no con botones.

En esta forma especifica se muestra que el boton test también controla el comportamiento, este se mueve entre cada uno de los estados internos para después volver a IDLE, por medio del registro Val_prev cambiara a otros 3 estados distintos al ser presionado.
### Diagramas de caja negra de los componentes y maquinas de Estado

#### Ultra Sonido
![Ultra_Sonido Caja Negra](<Imagenes/Ultra_Sonido Caja Negra.png>)

Como se puede observar en el diagrama de la caja negra, el módulo del sensor tiene como entradas Enable, clk, Echo, y como salidas Trigger, Done y Led. Dentro de la caja, se encuentran bloques internos que desempeñan funciones específicas, tales como Trigger, Echo y Tiempo.

En la caja de Trigger, se utiliza la señal de reloj (clk) y la señal de habilitación (Enable) para realizar un conteo en cada flanco de subida del pulso. Mientras el contador alcanza un valor de 10, el Trigger está activado. Luego, cuando el contador supera el valor de 10, el Trigger se desactiva y permanece así hasta que el contador alcanza el valor de 23333, que representa el mayor tiempo posible de medición. Este valor se calcula en base a la distancia máxima posible, que es de 400 cm.

La ecuación utilizada para calcular este tiempo máximo es: T=cm×0.01715. Una vez que el contador alcanza este valor, vuelve a cero para iniciar un nuevo ciclo de medición.

En la caja de Echo, se utiliza la señal de reloj (clk) y la señal de retorno del eco (Echo). En cada flanco de subida del pulso de reloj, si Echo está activo, se suma 1 al contador de Tiempo. Mientras Echo esté activo, la señal de Done permanece en 0, indicando que la medición está en curso. Cuando la señal de Echo finaliza, Done cambia a 1 y el contador de Tiempo se reinicia a 0.

En la caja de Tiempo, la salida del contador Tiempo del bloque Echo se compara con el valor de 583. Esta comparación se realiza porque ese es el tiempo en el que se determina que la medición es válida si se reemplaza la ecuación T = cm * 0.01715 por 10. Si el valor de Tiempo está en el rango de 0 a 583, el LED se enciende, indicando que la distancia medida está dentro del rango aceptable.



#### Modos

![Modo_Primitivo Caja Negra](<Imagenes/Modo_Primitivo Caja Negra.png>)


Los modos poseen 2 cosas de manera esencial que va con un objetivo de definir el comportamiento de la salida *Nivel* la cual corresponde a la **Caja negra** de `Modo_Primitivo`, la cual posee un *activo* que permitira que ese modo suba o baje de *Nivel*, por otro lado junto al *clk* permitira que despues de un determinado tiempo el modo baje de *Nivel* de uno en uno mientras que gracias a *Entrada_Sube_Nivel* como su nombre lo indica aumenta el *Nivel* de uno en uno siempre y cuando no se encuentre en el *Nivel* maximo.

![Modos Caja Negra](<Imagenes/Modos Caja Negra.png>)


#### Botones

![Boton_AR Caja Negra](<Imagenes/Boton_AR Caja Negra.png>)

La **Caja negra** que lleva por nombre `Boton_AR` se debe a que es la encargada de filtrar el ruido que envia un boton al ser pulsado, esto se logra gracias a que una vez se pulse el boton este debe permanecer pulsado un determinado tiempo, el cual se logra gracias al *clk*, para asi despues de tener un determinado tiempo pulsado la entrada *Boton_In* cambie el estado de la salida *Boton_Out*.

![Botones_antirrebote Caja Negra](<Imagenes/Botones_antirrebote Caja Negra.jpg>)

Utilizando lo realizado en `Boton_AR` se logra filtrar todo el ruido que tienen todos los botones que se emplearan como lo son el *B_Reset*, *B_Test*, *B_Energia* y *B_Medicina*, con lo cual para los botones *B_Reset* y *B_Test* basta con cambiar un parametro para que se envie el registro de su respectiva señal (*Senal_Reset* y *Senal_Test*) asi como se indica en el funcionamiento del componente, por otro lado las señales de los botones que ya involucran los modos del **`tamagorchi`** pasan de señal de entrada a una de salida en un tiempo mas inmediato.

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
