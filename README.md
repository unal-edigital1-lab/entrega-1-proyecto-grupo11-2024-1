# Entrega 1 del proyecto WP01
* Stewart Andres Antolinez Zapata
* Natalia Andrea Dueñas Salamanca
* Juan Diego Sáenz Ardila
##Especificación detallada del sistema 
###Componentes
Botones
\begin{itemize}
\item Reset:  Un estado inicial conocido al mantener pulsado el botón durante al menos 5 segundos. Botón tarjeta Altera cyclone
\item	Test: Activa el modo de prueba al mantener pulsado por al menos 5 segundos, permitiendo al usuario navegar entre los diferentes estados del Tamagotchi con cada pulsación. Botón tarjeta Altera cyclone
\item	Darcomer: Puntaje de comer aumenta 1 al pulsarse. Botón tarjeta tarjeta Altera cyclone
\item	Medicina: Puntaje de salud aumenta 1 al pulsarse. Botón tarjeta tarjeta Altera cyclone
\end{itemize}
Sensores
\begin{itemize}
\item Ultrasonido: Si se detecta un objeto a menos de 10 cm, si esta dormido se despierta y si esta despierta cuenta como caricia que aumenta su puntaje de ánimo. HC-SR04
\end{itemize}
Visualización
\begin{itemize}
\item Pantalla LED: Muestra el Tamagotchi según el estado actual. Pantalla Led 16x2 con driver ILI9341.
\end{itemize}
