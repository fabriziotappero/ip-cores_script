/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Author: Eyal Hochberg                                      ////
////          eyal@provartec.com                                 ////
////                                                             ////
////  Downloaded from: http://www.opencores.org                  ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2010 Provartec LTD                            ////
//// www.provartec.com                                           ////
//// info@provartec.com                                          ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
//// This source file is free software; you can redistribute it  ////
//// and/or modify it under the terms of the GNU Lesser General  ////
//// Public License as published by the Free Software Foundation.////
////                                                             ////
//// This source is distributed in the hope that it will be      ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied  ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR     ////
//// PURPOSE.  See the GNU Lesser General Public License for more////
//// details. http://www.gnu.org/licenses/lgpl.html              ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:34:50 2011
//--
//-- Source file: dma_reg.v
//---------------------------------------------------------



module dma_axi32_reg(clk,reset,pclken,psel,penable,paddr,pwrite,pwdata,prdata,pslverr,core0_idle,ch_int_all_proc0,int_all_proc,core0_clkdiv,core0_ch_start,joint_mode0,rd_prio_top0,rd_prio_high0,rd_prio_top_num0,rd_prio_high_num0,wr_prio_top0,wr_prio_high0,wr_prio_top_num0,wr_prio_high_num0,periph_rx_req_reg,periph_tx_req_reg,periph_rx_clr,periph_tx_clr);

   input                       clk;
   input                   reset;
   
   input                   pclken;
   input                   psel;
   input                   penable;
   input [7:0]                   paddr;
   input                   pwrite;
   input [31:0]               pwdata;
   output [31:0]               prdata;
   output                   pslverr;

   input                   core0_idle;
   input [8*1-1:0]             ch_int_all_proc0;
   output [1-1:0]              int_all_proc;
   output [3:0]               core0_clkdiv;
   output [7:0]               core0_ch_start;
   output                   joint_mode0;
   output                   rd_prio_top0;
   output                   rd_prio_high0;
   output [2:0]               rd_prio_top_num0;
   output [2:0]               rd_prio_high_num0;
   output                   wr_prio_top0;
   output                   wr_prio_high0;
   output [2:0]               wr_prio_top_num0;
   output [2:0]               wr_prio_high_num0;
   output [31:1]               periph_rx_req_reg;
   output [31:1]               periph_tx_req_reg;
   input [31:1]               periph_rx_clr;
   input [31:1]               periph_tx_clr;

`include "dma_axi32_reg_params.v"

   
   wire [31:0]                   user_def_stat;
   wire [31:0]                   user_def0_stat0;
   wire [31:0]                   user_def0_stat1;

   wire                   user_def_proj;
   wire [3:0]                   user_def_proc_num;
   wire                   user_def_dual_core;
   wire                   user_def_ic;
   wire                   user_def_ic_dual_port;
   wire                   user_def_clkgate;
   wire                   user_def_port0_mux;
   wire                   user_def_port1_mux;

   wire                               wr_joint0;
   wire                               wr_clkdiv0;
   wire                               wr_start0;
   wire                               wr_prio0;
   
   wire [7:0]                         proc0_int_stat0;
   wire [15:0]                        proc0_int_stat;
   wire                               proc0_int;
   wire [1-1:0]                int_all_proc_pre;
   reg [1-1:0]                 int_all_proc;
   
   
   wire                   wr_periph_rx;
   wire                   wr_periph_tx;
   reg [31:1]                   periph_rx_req_reg;
   reg [31:1]                   periph_tx_req_reg;
   
   wire [7:0]                   gpaddr;
   wire                   gpwrite;
   wire                   gpread;
   
   reg [31:0]                   prdata_pre;
   reg                       pslverr_pre;
   reg [31:0]                   prdata;
   reg                       pslverr;
   

   assign                              wr_joint0  = gpwrite & gpaddr == CORE0_JOINT;
   assign                              wr_clkdiv0 = gpwrite & gpaddr == CORE0_CLKDIV;
   assign                              wr_start0  = gpwrite & gpaddr == CORE0_START;
   assign                              wr_prio0   = gpwrite & gpaddr == CORE0_PRIO;
   
dma_axi32_reg_core0 dma_axi32_reg_core0(
                               .clk(clk),
                           .reset(reset),
                                   .wr_joint(wr_joint0),
                                   .wr_clkdiv(wr_clkdiv0),
                                   .wr_start(wr_start0),
                                   .wr_prio(wr_prio0),
                                   .pwdata(pwdata),
                                   .clkdiv(core0_clkdiv),
                                .ch_start(core0_ch_start),
                           .joint_mode(joint_mode0),
                           .rd_prio_top(rd_prio_top0),
                           .rd_prio_high(rd_prio_high0),
                                .rd_prio_top_num(rd_prio_top_num0),
                                .rd_prio_high_num(rd_prio_high_num0),
                           .wr_prio_top(wr_prio_top0),
                           .wr_prio_high(wr_prio_high0),
                                .wr_prio_top_num(wr_prio_top_num0),
                                .wr_prio_high_num(wr_prio_high_num0),
                                   .user_def_stat0(user_def0_stat0),
                                   .user_def_stat1(user_def0_stat1),
                                   .ch_int_all_proc(ch_int_all_proc0),
                                   .proc0_int_stat(proc0_int_stat0)
                                   );

     
   assign                   user_def_proj             = 0;
   assign                   user_def_proc_num         = 1;
   assign                   user_def_dual_core        = 0;
   assign                   user_def_ic               = 0;
   assign                   user_def_ic_dual_port     = 0;
   assign                   user_def_clkgate          = 0;
   assign                   user_def_port0_mux        = 0;
   assign                   user_def_port1_mux        = 0;
   
   assign                   user_def_stat =
                             {user_def_proj,              //[31]
                              {20{1'b0}},                 //[30:11]
                              user_def_port1_mux,         //[10]
                              user_def_port0_mux,         //[9]
                              user_def_clkgate,           //[8]
                               user_def_ic_dual_port,      //[7]
                               user_def_ic,                //[6]
                               user_def_dual_core,         //[5]
                               1'b0,                       //[4]
                               user_def_proc_num           //[3:0]
                              };
   

   

   
   assign                   gpaddr      = {8{psel}} & paddr;
   assign                   gpwrite     = psel & (~penable) & pwrite;
   assign                   gpread      = psel & (~penable) & (~pwrite);
   

   
   assign              wr_periph_rx = gpwrite & gpaddr == PERIPH_RX_CTRL;
   assign              wr_periph_tx = gpwrite & gpaddr == PERIPH_TX_CTRL;
   
   always @(posedge clk or posedge reset)
     if (reset)
       periph_rx_req_reg <= #1 {31{1'b0}};
     else if (wr_periph_rx | (|periph_rx_clr))
       periph_rx_req_reg <= #1 ({31{wr_periph_rx}} & pwdata[31:1]) & (~periph_rx_clr);
   
   always @(posedge clk or posedge reset)
     if (reset)
       periph_tx_req_reg <= #1 {31{1'b0}};
     else if (wr_periph_tx | (|periph_tx_clr))
       periph_tx_req_reg <= #1 ({31{wr_periph_tx}} & pwdata[31:1]) & (~periph_tx_clr);

   assign                   proc0_int_stat = {proc0_int_stat0};

   assign                             proc0_int = |proc0_int_stat;
      
   assign                             int_all_proc_pre = {proc0_int};
   
   always @(posedge clk or posedge reset)
     if (reset)
       int_all_proc <= #1 {1{1'b0}};
     else
       int_all_proc <= #1 int_all_proc_pre;

   
   always @(*)
     begin
    prdata_pre  = {32{1'b0}};
    
    case (gpaddr)
      PROC0_STATUS             : prdata_pre  = {{16{1'b0}}, proc0_int_stat0};
      
      CORE0_JOINT              : prdata_pre  = {{31{1'b0}}, joint_mode0};
      
      CORE0_PRIO               : prdata_pre  = {{16{1'b0}}, wr_prio_high0, wr_prio_high_num0, wr_prio_top0, wr_prio_top_num0, rd_prio_high0, rd_prio_high_num0, rd_prio_top0, rd_prio_top_num0};
      
      CORE0_CLKDIV             : prdata_pre  = {{28{1'b0}}, core0_clkdiv};
      
      CORE0_START              : prdata_pre  = {32{1'b0}};
            
      PERIPH_RX_CTRL            : prdata_pre  = {periph_rx_req_reg, 1'b0};
      PERIPH_TX_CTRL            : prdata_pre  = {periph_tx_req_reg, 1'b0};

      IDLE                      : prdata_pre  = {{30{1'b0}}, core0_idle};
      
      USER_DEF_STAT             : prdata_pre  = user_def_stat;
      USER_DEF0_STAT0          : prdata_pre  = user_def0_stat0;
      USER_DEF0_STAT1          : prdata_pre  = user_def0_stat1;
      
      default                   : prdata_pre  = {32{1'b0}};
    endcase
     end

   
   always @(/*AUTOSENSE*/gpaddr or gpread or gpwrite or psel)
     begin
    pslverr_pre = 1'b0;
    
    case (gpaddr)
      PROC0_STATUS             : pslverr_pre = gpwrite; //read only
      
      CORE0_JOINT              : pslverr_pre = 1'b0;    //read and write
      
      CORE0_PRIO               : pslverr_pre = 1'b0;    //read and write  
      
      CORE0_CLKDIV             : pslverr_pre = 1'b0;    //read and write
      
      CORE0_START              : pslverr_pre = gpread;  //write only
            
      PERIPH_RX_CTRL            : pslverr_pre = 1'b0;    //read and write  
      PERIPH_TX_CTRL            : pslverr_pre = 1'b0;    //read and write  
      
      IDLE                      : pslverr_pre = gpwrite; //read only
      
      USER_DEF_STAT             : pslverr_pre = gpwrite; //read only
      USER_DEF0_STAT0          : pslverr_pre = gpwrite; //read only
      USER_DEF0_STAT1          : pslverr_pre = gpwrite; //read only
      
      default                   : pslverr_pre = psel;    //decode error
    endcase
     end

   
   always @(posedge clk or posedge reset)
     if (reset)
       prdata <= #1 {32{1'b0}};
     else if (gpread & pclken)
       prdata <= #1 prdata_pre; 
     else if (pclken) //zero to allow or in apb_mux
       prdata <= #1 {32{1'b0}};

   always @(posedge clk or posedge reset)
     if (reset)
       pslverr <= #1 1'b0;
     else if ((gpread | gpwrite) & pclken)
       pslverr <= #1 pslverr_pre;
     else if (pclken)
       pslverr <= #1 1'b0;
   
   
endmodule

   



