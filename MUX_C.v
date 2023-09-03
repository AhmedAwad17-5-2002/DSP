module MUX_C (in0,in1,out);
parameter CARRYINSEL="OPMODE5";
input in0,in1;
output out;

case(CARRYINSEL)
"OPMODE5": assign out=in0;
"CARRYIN": assign out=in1;
default  : assign out=1'b0;
endcase
endmodule