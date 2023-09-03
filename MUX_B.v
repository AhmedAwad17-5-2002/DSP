module MUX_B (in0,in1,out);
parameter B_INPUT="DIRECT";
input [17:0]in0,in1;
output [17:0]out;

case(B_INPUT)
"DIRECT" : assign out=in0;
"CASCADE": assign out=in1;
default  : assign out=18'b0;
endcase
endmodule