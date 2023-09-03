module ADD_SUB_pre (A,B,SEL,OUT);
input [17:0] A,B;
input SEL ;
output reg [17:0] OUT;

always@(*)begin
    if(SEL==0)
OUT=A+B;
    else 
OUT=A-B;
end
endmodule