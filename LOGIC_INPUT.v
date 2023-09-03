module LOGIC_INPUT(D,clk,CE,Q,rst);
parameter WIDTH=1;
parameter DREG=1;
parameter RSTTYPE="SYNC";
input [WIDTH-1:0] D; 
input clk,rst,CE;
output reg [WIDTH-1:0] Q;
generate
	if(DREG) begin
			if(RSTTYPE == "SYNC") begin
				always @(posedge clk) begin
					if(CE) begin
						if (rst) begin
							Q <= 0;
						end
						else begin
							Q <= D;
						end
					end
				end
			end
			else if (RSTTYPE == "ASYNC") begin
				always @(posedge clk or posedge rst) begin
					if (rst) begin
						Q <= 0;
					end
					else if(CE) begin
						Q <= D;
					end
				end
			end
	end
	else begin
		always @(*) begin
			Q = D;
		end
	end
	
endgenerate
endmodule

