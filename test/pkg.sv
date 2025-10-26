package uart_pkg;

	import uvm_pkg::*;

	`include "uvm_macros.svh"
	`include "agent_config.sv"
	`include "env_config.sv"
	`include "uart_xtn.sv"
	
	`include "uart_seq.sv"
	`include "uart_driver.sv"
	`include "uart_monitor.sv"
	`include "uart_sequencer.sv"
	`include "agent.sv"
	`include "uart_agent_top.sv"

	`include "scoreboard.sv"
	`include "env.sv"

	`include "test.sv"

endpackage





