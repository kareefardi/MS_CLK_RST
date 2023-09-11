/*
	Copyright 2023 Mohamed Shalan

	Author: Mohamed Shalan (mshalan@aucegypt.edu)

	This file is auto-generated by wrapper_gen.py

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/


`timescale			1ns/1ns
`default_nettype	none

`define		AHB_BLOCK(name, init)	always @(posedge HCLK or negedge HRESETn) if(~HRESETn) name <= init;
`define		AHB_REG(name, init)		`AHB_BLOCK(name, init) else if(ahbl_we & (last_HADDR==``name``_ADDR)) name <= HWDATA;
`define		AHB_ICR(sz)				`AHB_BLOCK(ICR_REG, sz'b0) else if(ahbl_we & (last_HADDR==ICR_REG_ADDR)) ICR_REG <= HWDATA; else ICR_REG <= sz'd0;

module MS_CLK_RST_ahbl (
	input	wire 		xclk0,
	input	wire 		xclk1,
	input	wire 		xrst_n,
	input	wire 		zero,
	input	wire 		one,
	input	wire 		por_fb_in,
	output	wire 		por_fb_out,
	output	wire 		clk,
	output	wire 		por_n,
	output	wire 		rst_n,
	input	wire 		HCLK,
	input	wire 		HRESETn,
	input	wire [31:0]	HADDR,
	input	wire 		HWRITE,
	input	wire [1:0]	HTRANS,
	input	wire 		HREADY,
	input	wire 		HSEL,
	input	wire [2:0]	HSIZE,
	input	wire [31:0]	HWDATA,
	output	wire [31:0]	HRDATA,
	output	wire 		HREADYOUT
);
	localparam[15:0] MUX_CTRL_REG_ADDR = 16'h0000;
	localparam[15:0] CLK_DIV_REG_ADDR = 16'h0004;
	localparam[15:0] ROSC_DIV_REG_ADDR = 16'h0008;

	reg             last_HSEL;
	reg [31:0]      last_HADDR;
	reg             last_HWRITE;
	reg [1:0]       last_HTRANS;

	always@ (posedge HCLK) begin
		if(HREADY) begin
			last_HSEL       <= HSEL;
			last_HADDR      <= HADDR;
			last_HWRITE     <= HWRITE;
			last_HTRANS     <= HTRANS;
		end
	end

	reg	[2:0]	MUX_CTRL_REG;
	reg	[1:0]	CLK_DIV_REG;
	reg	[1:0]	ROSC_DIV_REG;

	wire		sel_mux0	= MUX_CTRL_REG[0:0];
	wire		sel_mux1	= MUX_CTRL_REG[1:1];
	wire		sel_mux2	= MUX_CTRL_REG[2:2];
	wire[1:0]	clk_div	= CLK_DIV_REG[1:0];
	wire[1:0]	sel_rosc	= ROSC_DIV_REG[1:0];
	wire		ahbl_valid	= last_HSEL & last_HTRANS[1];
	wire		ahbl_we	= last_HWRITE & ahbl_valid;
	wire		ahbl_re	= ~last_HWRITE & ahbl_valid;
	wire		_clk_	= HCLK;
	wire		_rst_	= ~HRESETn;
	wire  		por_fb_in;
	wire  		por_fb_out;
	MS_CLK_RST inst_to_wrap (
		.xclk0(xclk0),
		.xclk1(xclk1),
		.xrst_n(xrst_n),
		.sel_mux0(sel_mux0),
		.sel_mux1(sel_mux1),
		.sel_mux2(sel_mux2),
		.sel_rosc(sel_rosc),
		.clk_div(clk_div),
		.zero(zero),
		.one(one),
		.por_fb_in(por_fb_in),
		.por_fb_out(por_fb_out),
		.clk(clk),
		.rst_n(rst_n),
		.por_n(por_n)
	);

	`AHB_REG(MUX_CTRL_REG, 0)
	`AHB_REG(CLK_DIV_REG, 0)
	`AHB_REG(ROSC_DIV_REG, 0)
	assign	HRDATA = 
			(last_HADDR == MUX_CTRL_REG_ADDR) ? MUX_CTRL_REG :
			(last_HADDR == CLK_DIV_REG_ADDR) ? CLK_DIV_REG :
			(last_HADDR == ROSC_DIV_REG_ADDR) ? ROSC_DIV_REG :
			32'hDEADBEEF;


	assign HREADYOUT = 1'b1;

endmodule
