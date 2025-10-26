class uart_test extends uvm_test;
	`uvm_component_utils(uart_test)

	uart_agent_config agt_cfg[];
	uart_env_config m_cfg; 

	uart_env envh;

	bit has_scoreboard = 1;
	bit has_uart_agent = 1;
	int no_of_agent = 2;

	function new(string name = "uart_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_cfg = uart_env_config::type_id::create("m_cfg");

		agt_cfg = new[no_of_agent];
		m_cfg.agt_cfg = new[no_of_agent];		

		foreach(agt_cfg[i])
			begin
				if(has_uart_agent)
					begin
						agt_cfg[i] = uart_agent_config::type_id::create($sformatf("agt_cfg[%0d]",i));
						if(!uvm_config_db #(virtual uart_if)::get(this,"",$sformatf("if%0d",i),agt_cfg[i].vif))
						`uvm_fatal("Test","Config failed")
	$display("test interface %p",agt_cfg[i].vif);
						
						m_cfg.agt_cfg[i] = agt_cfg[i];
					end
			end
		m_cfg.has_uart_agent = has_uart_agent;
		m_cfg.has_scoreboard = has_scoreboard;
		m_cfg.no_of_agent = no_of_agent;

		uvm_config_db #(uart_env_config)::set(this,"*","m_cfg",m_cfg);

		envh = uart_env::type_id::create("envh",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology;
	endfunction


endclass





//--------------------------------------Full duplex test------------------------------

class full_duplex_test extends uart_test;
	`uvm_component_utils(full_duplex_test)

	full_duplex_seq1 full_seq1;
	full_duplex_seq2 full_seq2;

	function new(string name  = "full_duplex_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	full_seq1 = full_duplex_seq1::type_id::create("full_seq1");
	full_seq2 = full_duplex_seq2::type_id::create("full_seq2");

	phase.raise_objection(this);
	fork
		full_seq1.start(envh.agt_toph.agth[0].seqrh);
		full_seq2.start(envh.agt_toph.agth[1].seqrh);
	join
	#20;
	phase.drop_objection(this);
//	end
	endtask
endclass






//---------------------------------------------Half duplex test---------------------------

class half_duplex_test extends uart_test;
	`uvm_component_utils(half_duplex_test)

	half_duplex_seq1 half_seq1;
	half_duplex_seq2 half_seq2;

	function new(string name  = "half_duplex_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	half_seq1 = half_duplex_seq1::type_id::create("half_seq1");
	half_seq2 = half_duplex_seq2::type_id::create("half_seq2");

	phase.raise_objection(this);
	fork
		half_seq1.start(envh.agt_toph.agth[0].seqrh);
		half_seq2.start(envh.agt_toph.agth[1].seqrh);
	join
	#60;
	phase.drop_objection(this);
//	end
	endtask
endclass





//-------------------------------------------Loopback test------------------------------------

class loopback_test extends uart_test;
	`uvm_component_utils(loopback_test)

	loopback_seq1 loopback_seq1h;
	loopback_seq2 loopback_seq2h;

	function new(string name  = "loopback_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	loopback_seq1h = loopback_seq1::type_id::create("loopback_seq1h");
	loopback_seq2h = loopback_seq2::type_id::create("loopback_seq2h");

	phase.raise_objection(this);
	fork
		loopback_seq1h.start(envh.agt_toph.agth[0].seqrh);
		loopback_seq2h.start(envh.agt_toph.agth[1].seqrh);
	join
	#40;
	phase.drop_objection(this);
//	end
	endtask
endclass







//-------------------------------------------Parity test------------------------------------

class parity_test extends uart_test;
	`uvm_component_utils(parity_test)

	parity_seq1 parity_seq1h;
	parity_seq2 parity_seq2h;

	function new(string name  = "parity_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	parity_seq1h = parity_seq1::type_id::create("parity_seq1h");
	parity_seq2h = parity_seq2::type_id::create("parity_seq2h");

	phase.raise_objection(this);
	fork
		parity_seq1h.start(envh.agt_toph.agth[0].seqrh);
		parity_seq2h.start(envh.agt_toph.agth[1].seqrh);
	join
	#40;
	phase.drop_objection(this);
//	end
	endtask
endclass








//-------------------------------------------Break Error test------------------------------------

class break_error_test extends uart_test;
	`uvm_component_utils(break_error_test)

	bk_seq1 bk_seq1h;
	bk_seq2 bk_seq2h;

	function new(string name  = "break_error_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	bk_seq1h = bk_seq1::type_id::create("bk_seq1h");
	bk_seq2h = bk_seq2::type_id::create("bk_seq2h");

	phase.raise_objection(this);
	fork
		bk_seq1h.start(envh.agt_toph.agth[0].seqrh);
		bk_seq2h.start(envh.agt_toph.agth[1].seqrh);
	join
	#40;
	phase.drop_objection(this);
//	end
	endtask
endclass





//-------------------------------------------Overrun error test------------------------------------

class overrun_error_test extends uart_test;
	`uvm_component_utils(overrun_error_test)

	overrun_error_seq1 oe_seq1h;
	overrun_error_seq2 oe_seq2h;

	function new(string name  = "overrun_error_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	oe_seq1h = overrun_error_seq1::type_id::create("oe_seq1h");
	oe_seq2h = overrun_error_seq2::type_id::create("oe_seq2h");

	phase.raise_objection(this);
	fork
		oe_seq1h.start(envh.agt_toph.agth[0].seqrh);
		oe_seq2h.start(envh.agt_toph.agth[1].seqrh);
	join
	#40;
	phase.drop_objection(this);
//	end
	endtask
endclass




//-------------------------------------------Framing error test------------------------------------

class framing_error_test extends uart_test;
	`uvm_component_utils(framing_error_test)

	framing_error_seq1 fe_seq1h;
	framing_error_seq2 fe_seq2h;

	function new(string name  = "framing_error_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	fe_seq1h = framing_error_seq1::type_id::create("fe_seq1h");
	fe_seq2h = framing_error_seq2::type_id::create("fe_seq2h");

	phase.raise_objection(this);
	fork
		fe_seq1h.start(envh.agt_toph.agth[0].seqrh);
		fe_seq2h.start(envh.agt_toph.agth[1].seqrh);
	join
	#40;
	phase.drop_objection(this);
//	end
	endtask
endclass
	
		



//-------------------------------------------The empty test------------------------------------

class thr_empty_test extends uart_test;
	`uvm_component_utils(thr_empty_test)

	thr_empty_seq1 te_seq1h;
	thr_empty_seq2 te_seq2h;

	function new(string name  = "thr_empty_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	te_seq1h = thr_empty_seq1::type_id::create("te_seq1h");
	te_seq2h = thr_empty_seq2::type_id::create("te_seq2h");

	phase.raise_objection(this);
	fork
		te_seq1h.start(envh.agt_toph.agth[0].seqrh);
		te_seq2h.start(envh.agt_toph.agth[1].seqrh);
	join
	#80;
	phase.drop_objection(this);
//	end
	endtask
endclass





//-------------------------------------------Time out error test------------------------------------

class time_out_error_sequence_test extends uart_test;
	`uvm_component_utils(time_out_error_sequence_test)

	time_out_error_seq1 toe_seq1h;
	time_out_error_seq2 toe_seq2h;

	function new(string name  = "time_out_error_sequence_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
//	repeat(10)
//	begin

	toe_seq1h = time_out_error_seq1::type_id::create("toe_seq1h");
	toe_seq2h = time_out_error_seq2::type_id::create("toe_seq2h");

	phase.raise_objection(this);
	fork
		toe_seq1h.start(envh.agt_toph.agth[0].seqrh);
		toe_seq2h.start(envh.agt_toph.agth[1].seqrh);
	join
	#40;
	phase.drop_objection(this);
//	end
	endtask
endclass