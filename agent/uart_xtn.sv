class uart_xtn extends uvm_sequence_item;
	`uvm_object_utils(uart_xtn)

	function new(string name = "uart_xtn");
		super.new(name);
	endfunction

	bit Presetn;
	rand logic [31:0] Paddr;
	bit Psel;
	bit Penable;
	rand bit Pwrite;
	rand logic [31:0] Pwdata;
	logic [31:0] Prdata;
	logic Pready;
	logic Pslverr;
	logic IRQ;
	logic baud_o;
	bit data_in_thr;
	bit data_in_rbr;
	
// registers

	logic [7:0] RBR[$];
	logic [7:0] THR[$];
	logic [7:0] IER;
	logic [7:0] IIR;
	logic [7:0] FCR;
	logic [7:0] LCR;
	logic [7:0] MCR;
	logic [7:0] LSR;
	logic [7:0] MSR;
	logic [7:0] DIV1;
	logic [7:0] DIV2;

	virtual function void do_print(uvm_printer printer);
		printer.print_field("Presetn",this.Presetn,1 ,	UVM_DEC);
		printer.print_field("Paddr"  ,this.Paddr  ,32,	UVM_DEC);
		printer.print_field("Psel",	this.Psel	,1,	UVM_DEC);
		printer.print_field("Penable",this.Penable,1,	UVM_DEC);
		printer.print_field("Pwrite",	this.Pwrite	,1,	UVM_DEC);
		printer.print_field("Pwdata",	this.Pwdata	,32,	UVM_DEC);
		printer.print_field("Prdata",	this.Prdata	,32,	UVM_DEC);
		printer.print_field("Pready",	this.Pready	,1,	UVM_DEC);
		printer.print_field("Pslverr",this.Pslverr,1,	UVM_DEC);
		printer.print_field("baud_o",this.baud_o,1,	UVM_DEC);

		
		printer.print_field("RBR",this.RBR[$],8,UVM_DEC);
		printer.print_field("THR",this.THR[$],8,UVM_DEC);
		printer.print_field("IER",this.IER,8,UVM_DEC);
		printer.print_field("IIR",this.IIR,8,UVM_DEC);
		printer.print_field("FCR",this.FCR,8,UVM_DEC);
		printer.print_field("LCR",this.LCR,8,UVM_DEC);
		printer.print_field("MCR",this.MCR,8,UVM_DEC);
		printer.print_field("LSR",this.LSR,8,UVM_DEC);
		printer.print_field("MSR",this.MSR,8,UVM_DEC);
		printer.print_field("DIV1",this.DIV1,8,UVM_DEC);
		printer.print_field("DIV2",this.DIV2,8,UVM_DEC);
	endfunction

endclass
