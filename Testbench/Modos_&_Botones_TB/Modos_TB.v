`timescale 1ns / 1ps
`include "Modos.v"

module Modos_TB;

    reg clk;
    reg B_Test;
    reg B_Reset;

    reg B_Energia;
    reg B_Medicina;
    reg Entrada_Descanso;
    reg Entrada_Animo;
    
    //Salidas
    wire [0:1]LED_Animo;
    wire [0:1]LED_Energia;
    wire [0:1]LED_Descanso;
    wire [0:1]LED_Medicina;
	wire senal_5segMedicina;
	wire senal_5segEnergia;

 Modos uut(
    .clk(clk),
    .Bot_Test(B_Test),
    .Bot_Reset(B_Reset),

    .Bot_Energia(B_Energia),
    .Bot_Medicina(B_Medicina),
    .Entrada_Descanso(Entrada_Descanso),
    .Entrada_Animo(Entrada_Animo),
    
    //Salidas
    .LED_Animo(LED_Animo),
    .LED_Energia(LED_Energia),
    .LED_Descanso(LED_Descanso),
    .LED_Medicina(LED_Medicina),
	 .senal_5segMedicina(senal_5segMedicina),
	 .senal_5segEnergia(senal_5segEnergia)
);

    initial begin
        clk = 0;
        B_Energia=0;
        B_Medicina=0; 
        B_Reset=0;
        #15
        B_Medicina=1;
        B_Energia=1;
		  #45
        B_Medicina=0;
        B_Energia=0;
          #15
        B_Medicina=1;
        B_Energia=1;
		  
    end

    always #1 clk = ~clk; // Cambia cada nanosegundo (1ns)

    //always #300 B_Energia = ~B_Energia; // Cada 10 flancos de subida la señal cambia [#20 es cada 20ns]

    initial begin: TEST_CASE
        $dumpfile("Modos.vcd");
        $dumpvars(-1, uut);
        #(20000) $finish;
    end

endmodule