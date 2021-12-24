`timescale 1ns / 1ps
module FIFO(input sys_clk, input rst_n, input wr_en, input [7:0] data_in, output full, input rd_en, output [7:0]data_out, output empty);
reg [7:0] ram [255:0];
reg [7:0] p_read, p_write;
reg [31:0] cnt;
wire isFull, isEmpty;wire wr_rising, rd_rising;
assign data_out= ram[p_read];
assign full = isFull;
assign empty=isEmpty;

always@(posedge sys_clk, negedge rst_n)begin
    if(!rst_n)begin
        p_read <= 0;
        p_write <= 0;
        cnt<=0;
    end
    else begin
        if(wr_rising && ~isFull)begin
            ram[p_write] <= data_in;
            p_write<=p_write+1;
            cnt<=cnt+1;
        end
        else if (rd_rising && ~isEmpty)begin
           p_read <= p_read+1;
           cnt<=cnt-1;
        end
    end
end

assign isFull = (cnt==32'd256);
assign isEmpty = (cnt==32'd0);

rising_edge r0(sys_clk, rst_n, wr_en, wr_rising);
rising_edge r1(sys_clk, rst_n, rd_en, rd_rising);
endmodule

module rising_edge(input sys_clk, input rst_n, input signal, output is_rising);
    reg tmp0, tmp1;
    always@(posedge sys_clk, negedge rst_n)begin
        if(!rst_n)begin
            tmp0<=0;
            tmp1<=0;
        end
        else begin
            tmp0<=signal;
            tmp1<=tmp0;
        end
    end
    assign is_rising = ~tmp1 & tmp0;
endmodule