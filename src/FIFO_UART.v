module FIFO_UART
#(parameter REF_CLK=200, parameter BAUD_RATE=115200)
(
input sys_clk,
input                           rst_n,             //reset ,low active
input                           uart_rx,           //fpga receive data
output                          uart_tx,            //fpga send data
//Microblaze Signals
output is_tx_fifo_full,
input tx_new_data,
input [7:0] new_data_in,
//RX
output is_rx_fifo_empty,
input rx_new_data,
output [7:0] new_data_out
);
    //TX
   wire [7:0] tx_data, rx_data;
   wire tx_start, tx_rdy, rx_has_data, rx_tx;
    uart_tx#(REF_CLK, BAUD_RATE)tx_inst(sys_clk,rst_n, tx_data, tx_start, tx_rdy, uart_tx);
    uart_rx#(REF_CLK, BAUD_RATE)rx_inst(sys_clk,rst_n, rx_data,rx_has_data,rx_tx,uart_rx);
    
    //TX FIFO
    wire [7:0]tx_fifo_din, tx_fifo_dout;
    wire tx_fifo_wr, tx_fifo_rd, tx_fifo_full, tx_fifo_empty;
    FIFO tx_fifo (
      .sys_clk(sys_clk),      // input wire clk
      .rst_n(rst_n),    // input wire srst
      .data_in(tx_fifo_din),      // input wire [7 : 0] din
      .wr_en(tx_fifo_wr),  // input wire wr_en
      .rd_en(tx_fifo_rd),  // input wire rd_en
      .data_out(tx_fifo_dout),    // output wire [7 : 0] dout
      .full(tx_fifo_full),    // output wire full
      .empty(tx_fifo_empty)  // output wire empty
    );
    //RX FIFO
    wire [7:0]rx_fifo_din, rx_fifo_dout;
    wire rx_fifo_wr, rx_fifo_rd, rx_fifo_full, rx_fifo_empty;
    FIFO rx_fifo (
      .sys_clk(sys_clk),      // input wire clk
      .rst_n(rst_n),    // input wire srst
      .data_in(rx_fifo_din),      // input wire [7 : 0] din
      .wr_en(rx_fifo_wr),  // input wire wr_en
      .rd_en(rx_fifo_rd),  // input wire rd_en
      .data_out(rx_fifo_dout),    // output wire [7 : 0] dout
      .full(rx_fifo_full),    // output wire full
      .empty(rx_fifo_empty)  // output wire empty
    );

    //TX Assigns
    assign tx_fifo_din =new_data_in ;
    assign tx_fifo_wr = ~tx_fifo_full & tx_new_data;
    assign tx_fifo_rd = (~tx_fifo_empty) & tx_rdy;
    assign tx_data =  tx_fifo_dout;
    assign tx_start =   (~tx_fifo_empty) & tx_rdy;
    assign is_tx_fifo_full = tx_fifo_full;
    //RX Assigns
    assign rx_fifo_din = rx_data;
    assign rx_fifo_wr = rx_has_data & ~rx_fifo_full;
    assign rx_fifo_rd = ~rx_fifo_empty & rx_new_data;
    assign rx_tx = rx_has_data & ~rx_fifo_full;
    assign is_rx_fifo_empty = rx_fifo_empty;
    assign new_data_out= rx_fifo_dout;
endmodule
