module ADD_SUB_post (A,B,CIN,SEL,OUT,CARRY_OUT);
input [47:0] A,B;
input SEL ,CIN;
output reg [47:0] OUT;
output reg CARRY_OUT;

always@(*) begin
    if(SEL==0)
{CARRY_OUT,OUT}=A+B+CIN;
    else 
{CARRY_OUT,OUT}=A-(B+CIN);
end
endmodule