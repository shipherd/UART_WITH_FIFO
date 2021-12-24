
`timescale 1 ns / 1 ps

	module FIFO_UART_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4
	)
	(
		// Users to add ports here
		input rx,
		output tx,
output dbg_is_tx_fifo_full,
output dbg_is_rx_fifo_empty,
output [7:0] dbg_new_data_out, 
output [7:0] dbg_new_data_in,
output dbg_tx_new_data, 
output dbg_rx_new_data,
output [7:0] dbg_ram_tx,
output [7:0] dbg_ram_rx,
output [7:0] dbg_rx_data,
	output [2:0]dbg_rx_state,
	output dbg_rx_negedge,
	output [15:0]dbg_rx_cycle_cnt,
	output [7:0] dbg_rx_bits,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	FIFO_UART_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) FIFO_UART_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		.rx(rx),
		.tx(tx),
.dbg_is_tx_fifo_full(dbg_is_tx_fifo_full),
.dbg_is_rx_fifo_empty(dbg_is_rx_fifo_empty),
.dbg_new_data_out(dbg_new_data_out), 
.dbg_new_data_in(dbg_new_data_in),
.dbg_tx_new_data(dbg_tx_new_data), 
.dbg_rx_new_data(dbg_rx_new_data),
.dbg_ram_tx(dbg_ram_tx),
.dbg_ram_rx(dbg_ram_rx),
.dbg_rx_data(dbg_rx_data),
	.dbg_rx_state(dbg_rx_state),
	.dbg_rx_negedge(dbg_rx_negedge),
	.dbg_rx_cycle_cnt(dbg_rx_cycle_cnt),
	.dbg_rx_bits(dbg_rx_bits)
	);

	// Add user logic here

	// User logic ends

	endmodule
