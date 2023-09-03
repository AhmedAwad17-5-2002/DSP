module MUX (in0,in1,in2,in3,sel,out);
parameter INPUT_SIZE=4,
          SEL_SIZE=2,
          IO_WIDTH=48;

input      [IO_WIDTH-1:0] in0,in1,in2,in3;
input      [SEL_SIZE-1:0] sel;
output reg [IO_WIDTH-1:0] out;   

generate 
if(INPUT_SIZE==4 && SEL_SIZE==2 && IO_WIDTH==48)
always@(*)begin
case (sel)
    2'b00 :  out = in0;
    2'b01 :  out = in1;
    2'b10 :  out = in2;
    2'b11 :  out = in3;
endcase
end 

else if (INPUT_SIZE==2 && SEL_SIZE==1 && IO_WIDTH==18)
always@(*)begin
case (sel)
    1'b0 :  out = in0;
    1'b1 :  out = in1;
    default : out=in0;
endcase
end

else if (INPUT_SIZE==2 && SEL_SIZE==1 && IO_WIDTH==1)
always@(*)begin
case (sel)
    1'b0 :  out = in0;
    1'b1 :  out = in1;
    default : out=in0;
endcase
end
endgenerate    
endmodule