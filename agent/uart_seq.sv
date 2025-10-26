class uart_base_seq extends uvm_sequence#(uart_xtn);
	`uvm_object_utils(uart_base_seq)

	function new(string name = "uart_base_seq");
		super.new(name);
	endfunction

endclass




//------------------------------------------- Full duplex sequence---------------------------------------

class full_duplex_seq1 extends uart_base_seq;
	`uvm_object_utils(full_duplex_seq1)

	function new(string name = "full_duplex_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 54;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 5;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("FULL_D_SEQ1",$sformatf("data from full duplex seq1 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass

class full_duplex_seq2 extends uart_base_seq;
	`uvm_object_utils(full_duplex_seq2)

	function new(string name = "full_duplex_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 27;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);


		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);


		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 10;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
				
			end
		

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
			
			end
		`uvm_info("FULL_D_SEQ2",$sformatf("data from full duplex seq2 \n %s", req.sprint),UVM_MEDIUM)
	


	endtask
endclass








//-----------------------------------------------------Half duplex sequence------------------------------------------

class half_duplex_seq1 extends uart_base_seq;
	`uvm_object_utils(half_duplex_seq1)

	function new(string name = "half_duplex_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 54;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);


		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);


		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 15;});
		finish_item(req);

		`uvm_info("HALF_D_SEQ1",$sformatf("data from half duplex seq1 \n %s", req.sprint),UVM_MEDIUM)
	


	endtask
endclass


class half_duplex_seq2 extends uart_base_seq;
	`uvm_object_utils(half_duplex_seq2)

	function new(string name = "half_duplex_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 27;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);


		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
				
			end
		

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
			
			end


		`uvm_info("HALF_D_SEQ2",$sformatf("data from half duplex seq2 \n %s", req.sprint),UVM_MEDIUM)
	


	endtask
endclass









//------------------------------------------------------- Loopback sequence------------------------------------------
class loopback_seq1 extends uart_base_seq;
	`uvm_object_utils(loopback_seq1)

	function new(string name = "loopback_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 54;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);

		//MCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h10; Pwrite == 1; Pwdata == 8'b00010000;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 20;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("LOOPBACK_SEQ1",$sformatf("data from loopback seq1 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass


class loopback_seq2 extends uart_base_seq;
	`uvm_object_utils(loopback_seq2)

	function new(string name = "loopback_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 27;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);

		//MCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h10; Pwrite == 1; Pwdata == 8'b00010000;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 40;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("LOOPBACK_SEQ2",$sformatf("data from loopback seq2 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass


	


//------------------------------------------- Parity sequence---------------------------------------

class parity_seq1 extends uart_base_seq;
	`uvm_object_utils(parity_seq1)

	function new(string name = "parity_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 54;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00001011;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 5;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("PARITY_SEQ1",$sformatf("data from parity seq1 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass


class parity_seq2 extends uart_base_seq;
	`uvm_object_utils(parity_seq2)

	function new(string name = "parity_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 27;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00011011;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 10;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("PARITY_SEQ2",$sformatf("data from parity seq2 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass





//------------------------------------------- Break error sequence---------------------------------------

class bk_seq1 extends uart_base_seq;
	`uvm_object_utils(bk_seq1)

	function new(string name = "bk_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h1;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 32'h46;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b01000011;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 5;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("BREAK_ERR_SEQ1",$sformatf("data from break error seq1 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass


class bk_seq2 extends uart_base_seq;
	`uvm_object_utils(bk_seq2)

	function new(string name = "bk_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h2;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 32'h8c;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000101;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b01000011;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 10;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("BREAK_ERR_SEQ2",$sformatf("data from break error seq2 \n %s", req.sprint),UVM_MEDIUM)
		
	
	endtask
endclass




//------------------------------------------- Overrun error sequence---------------------------------------

class overrun_error_seq1 extends uart_base_seq;
	`uvm_object_utils(overrun_error_seq1)

	function new(string name = "overrun_error_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 54;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000100;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b01000011;});
		finish_item(req);

		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1;});
		finish_item(req);
		end

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("OVERRUN_ERR_SEQ1",$sformatf("data from overrun error seq1 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass

class overrun_error_seq2 extends uart_base_seq;
	`uvm_object_utils(overrun_error_seq2)

	function new(string name = "overrun_error_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 27;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000100;});
		finish_item(req);


		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);


		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1;});
		finish_item(req);
		end

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
				
			end
		

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
			
			end
		`uvm_info("OVERRUN_ERR_SEQ2",$sformatf("data from overrun error seq2 \n %s", req.sprint),UVM_MEDIUM)
	


	endtask
endclass




//------------------------------------------- Framing error sequence---------------------------------------

class framing_error_seq1 extends uart_base_seq;
	`uvm_object_utils(framing_error_seq1)

	function new(string name = "framing_error_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h1;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 32'h46;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000100;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b01000011;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 5;});
		finish_item(req);

		//IIR
	    start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("FRAMING_ERR_SEQ1",$sformatf("data from framing error seq1 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass


class framing_error_seq2 extends uart_base_seq;
	`uvm_object_utils(framing_error_seq2)

	function new(string name = "framing_error_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h2;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 32'h8c;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b00000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000100;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000000;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 10;});
		finish_item(req);

		//IIR
	   start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("FRAMING_ERR_SEQ2",$sformatf("data from framing error seq2 \n %s", req.sprint),UVM_MEDIUM)
		
	
	endtask
endclass






//------------------------------------------- The empty sequence---------------------------------------

class thr_empty_seq1 extends uart_base_seq;
	`uvm_object_utils(thr_empty_seq1)

	function new(string name = "thr_empty_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 54;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b11000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000010;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);

		//IIR
	    start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("THR_EMPTY_SEQ1",$sformatf("data from thr empty seq1 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass

class thr_empty_seq2 extends uart_base_seq;
	`uvm_object_utils(thr_empty_seq2)

	function new(string name = "thr_empty_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 27;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b11000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000010;});
		finish_item(req);


		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);

		//IIR
	    start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
				
			end
		

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
			
			end
		`uvm_info("THR_EMPTY_SEQ2",$sformatf("data from thr empty seq2 \n %s", req.sprint),UVM_MEDIUM)
	


	endtask
endclass







//------------------------------------------- Time Out Error sequence---------------------------------------

class time_out_error_seq1 extends uart_base_seq;
	`uvm_object_utils(time_out_error_seq1)

	function new(string name = "time_out_error_seq1");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 54;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b10000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000000;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);

		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1;});
		finish_item(req);
		end
		
		//IIR
	    start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("TIME_OUT_ERROR_SEQ1",$sformatf("data from time out error seq1 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass


class time_out_error_seq2 extends uart_base_seq;
	`uvm_object_utils(time_out_error_seq2)

	function new(string name = "time_out_error_seq2");
		super.new(name);
	endfunction

	task body;
		req = uart_xtn::type_id::create("req");

		//DIV1 MSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h20; Pwrite == 1; Pwdata == 32'h0;});
		finish_item(req);

		//DIV2 LSB
		start_item(req);
		assert(req.randomize with {Paddr == 32'h1c; Pwrite == 1; Pwdata == 27;});
		finish_item(req);


		//FCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h08; Pwrite == 1; Pwdata == 8'b11000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize with {Paddr == 32'h04; Pwrite == 1; Pwdata == 8'b00000000;});
		finish_item(req);

		//LCR
		start_item(req);
		assert(req.randomize with {Paddr == 32'h0c; Pwrite == 1; Pwdata == 8'b00000011;});
		finish_item(req);

		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize with {Paddr == 32'h00; Pwrite == 1; Pwdata == 10;});
		finish_item(req);
		end
		
		//IIR
	    start_item(req);
		assert(req.randomize with {Pwrite == 0; Paddr == 32'h08;});
		finish_item(req);
		get_response(req);
		
		
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr == 32'h00;});
				finish_item(req);
			
			end

		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize with {Pwrite==0; Paddr==32'h14;});
				finish_item(req);
		
			end
		`uvm_info("TIME_OUT_ERROR_SEQ2",$sformatf("data from time out error seq2 \n %s", req.sprint),UVM_MEDIUM)
		

	
	endtask
endclass
