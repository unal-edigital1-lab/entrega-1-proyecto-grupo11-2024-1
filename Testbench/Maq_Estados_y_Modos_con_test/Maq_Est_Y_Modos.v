`include "Maquina_Estados_1.v"
`include "Modos.v"
`include "display.v"
`include "ili9341_top.v"
module Maq_Est_Y_Modos (

    input clk,
    input reset,
    input Boton_Test,
    input Boton_Comida,
    input Boton_Medicina,

    output [0:6]sseg,
    output [4:0]an,
    output wire spi_mosi,
    output wire spi_cs,
    output wire spi_sck,
    output wire spi_dc  


);


// Salidas Modos -- Entradas Estados

wire Senal_Reset;

wire Senal_5Seg_Comida;
wire Senal_5Seg_Medicina;
wire Senal_Test;
wire Senal_MTest;

wire [1:0] Cable_Niveles_Medicina;
wire [1:0] Cable_Niveles_Comida;


// Salidas Estados -- Entradas Modos/ili
wire [2:0] Visualizacion;


wire Senal_Activo_Comida;
wire Senal_Activo_Medicina;

wire [0:15]Siete_Segmentos;


ili9341_top ili9341(
.clk(clk),
.rst(Senal_Reset),
.visua(Visualizacion),
.spi_mosi(spi_mosi),
.spi_cs(spi_cs),
.spi_sck(spi_sck),
.spi_dc(spi_dc)
);

Maquina_Estados_1 maq_est(
    .clk(clk), 
    .reset(Senal_Reset),
    .Senal_Test(Senal_Test),
    .Senal_MTest(Senal_MTest),
    .Boton_Comida(Senal_5Seg_Comida),
    .Boton_Medicina(Senal_5Seg_Medicina),
    .Nivel_Comida(Cable_Niveles_Comida),
    .Activo_Comida(Senal_Activo_Comida),
    .Activo_Medicina(Senal_Activo_Medicina),
    .Salida_7seg(Siete_Segmentos),
	 .Visualizacion(Visualizacion)
);

Modos mods(
    .clk(clk),
    .Bot_Reset(reset),
    .Bot_Test(Boton_Test),
    .Bot_Energia(Boton_Comida),
    .Bot_Medicina(Boton_Medicina),
    .Reset_General(Senal_Reset),
    .senal_5segEnergia(Senal_5Seg_Comida),
    .senal_5segMedicina(Senal_5Seg_Medicina),
    .Activo_Comida(Senal_Activo_Comida),
    .Activo_Medicina(Senal_Activo_Medicina),
    .LED_Energia(Cable_Niveles_Comida),
    .LED_Medicina(Cable_Niveles_Medicina),
    .Senal_Test(Senal_Test),
    .Senal_MTest(Senal_MTest)
);

display Display_MyM (
    .clk(clk),
    .rst(Senal_Reset),
    .num(Siete_Segmentos),
    .sseg(sseg),
    .an(an)
);

endmodule