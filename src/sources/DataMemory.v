module DataMemory(
	input  reset    , 
	input  clk      ,  
	input  MemRead  ,
	input  MemWrite ,
	input  [32 -1:0] Address    ,
	input  [32 -1:0] Write_data ,
	output [32 -1:0] Read_data  ,
    output [11:0] leds
);
	// RAM size is 256 words, each word is 32 bits, valid address is 8 bits
	parameter RAM_SIZE      = 256;
	parameter RAM_SIZE_BIT  = 8;
	
	// RAM_data is an array of 256 32-bit registers
	reg [31:0] RAM_data [RAM_SIZE - 1: 0];
    reg [31:0] LED;
	// read data from RAM_data as Read_data
	assign Read_data = (Address == 32'h00004000)?LED :MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	assign leds = LED[11:0];
	// write Write_data to RAM_data at clock posedge
	integer i;
	always @(posedge reset or posedge clk)begin
		if (reset) begin
			RAM_data[0]  <= 32'h00000014; 
			RAM_data[1]  <= 32'h000041a8; 
			RAM_data[2]  <= 32'h00003af2; 
			RAM_data[3]  <= 32'h0000acda;
			RAM_data[4]  <= 32'h00000c2b;
			RAM_data[5]  <= 32'h0000b783;
			RAM_data[6]  <= 32'h0000dac9;
			RAM_data[7]  <= 32'h00008ed9;
            RAM_data[8]  <= 32'h000009ff;
			RAM_data[9]  <= 32'h00002f44;
			RAM_data[10] <= 32'h0000044e;
			RAM_data[11] <= 32'h00009899;
			RAM_data[12] <= 32'h00003c56;
			RAM_data[13] <= 32'h0000128d;
			RAM_data[14] <= 32'h0000dbe3;
			RAM_data[15] <= 32'h0000d4b4;
            RAM_data[16] <= 32'h00003748;
			RAM_data[17] <= 32'h00003918;
			RAM_data[18] <= 32'h00004112;
			RAM_data[19] <= 32'h0000c399;
			RAM_data[20] <= 32'h00004955;

            LED <= 32'b0000_0000_0000_0000_0000_1111_0011_1111;
			for (i = 21; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;
		end
		else if (MemWrite) begin
            if(Address < 32'h00000100)
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
            else if(Address == 32'h00004000)
            LED <= Write_data;
		end
	end
			
endmodule
