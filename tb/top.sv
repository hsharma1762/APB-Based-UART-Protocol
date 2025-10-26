module uart_top;

	import uvm_pkg::*;
	import uart_pkg::*;

	bit clk1;
	always
	#5 clk1 = ~clk1;

	bit clk2;
	always 
	#10 clk2 =~clk2;

	wire rx, tx;

	uart_if if0 (clk1);
	uart_if if1 (clk2);


	uart_16550 DUV1(
  			 clk1,
  			if0. Presetn,
  			if0. Paddr,
  			if0. Pwdata,
  			if0. Prdata,
  			if0. Pwrite,
  			if0. Penable,
  			if0. Psel,
  			if0. Pready,
  			if0. Pslverr,
  			if0. IRQ,
  			tx,
  			rx,
  			if0. baud_o);

	uart_16550 DUV2(
  			clk2,
  			if1. Presetn,
  			if1. Paddr,
  			if1. Pwdata,
  			if1. Prdata,
  			if1. Pwrite,
  			if1. Penable,
  			if1. Psel,
  			if1. Pready,
  			if1. Pslverr,
  			if1. IRQ,
  			rx,
  			tx,
  			if1. baud_o);


	initial
		begin
			uvm_config_db#(virtual uart_if)::set(null,"*","if0",if0);
			uvm_config_db#(virtual uart_if)::set(null,"*","if1",if1);
			run_test();
		end

endmodule
