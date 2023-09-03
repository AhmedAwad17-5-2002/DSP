module TOP_MODULE(A,B,C,D,clk,CARRYIN,OPMODE,BCIN,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,
                  CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE, PCIN, BCOUT,PCOUT,P,M,CARRYOUT,CARRYOUTF);

parameter A0REG=0,
          A1REG=1,
          B0REG=0,
          B1REG=1,
          CREG=1,
          DREG=1,
          MREG=1,
          PREG=1,
          CARRYINREG=1,
          CARRYOUTREG=1,
          OPMODEREG=1,
          CARRYINSEL="OPMODE5",
          B_INPUT="DIRECT",
          RSTTYPE="SYNC";
//***********************************************************************************************************
input [17:0] A,B,D,BCIN;
input [47:0] C,PCIN;
input [7:0] OPMODE;
input clk,CARRYIN,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,
      RSTOPMODE,CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE;
//***********************************************************************************************************
output [17:0]BCOUT; 
output [47:0] PCOUT,P;
output [35:0] M;
output CARRYOUT,CARRYOUTF;
//************************************************************************************************************
wire [17:0] IN1,A1,A2,A3,B1,C1,D1,D2;
wire [47:0] G1,G2,H1,O2,CONC,EXTIN,A4;
wire [7:0]OpBUF;
wire [35:0] E1,F1;
wire IN2,A5,H2,O1,CIN;
assign CIN=A5;
//************************************************************************************************************
MUX_B #(.B_INPUT(B_INPUT))
       M0 (B,BCIN,IN1);

LOGIC_INPUT #(.WIDTH('d18),.DREG(DREG),.RSTTYPE(RSTTYPE)) 
            M1 (D,clk,CED,A1,RSTD);

LOGIC_INPUT #(.WIDTH('d18),.DREG(B0REG),.RSTTYPE(RSTTYPE)) 
            M2 (IN1,clk,CEB,A2,RSTB);

LOGIC_INPUT #(.WIDTH('d18),.DREG(A0REG),.RSTTYPE(RSTTYPE)) 
            M3 (A,clk,CEA,A3,RSTA);  

LOGIC_INPUT #(.WIDTH('d48),.DREG(CREG),.RSTTYPE(RSTTYPE)) 
            M4 (C,clk,CEC,A4,RSTC);     

LOGIC_INPUT #(.WIDTH('d8),.DREG(OPMODEREG),.RSTTYPE(RSTTYPE))
            M5 (OPMODE,clk,CEOPMODE,OpBUF,RSTOPMODE);

ADD_SUB_pre M12 (A1,A2,OpBUF[6],B1);

MUX #(.INPUT_SIZE('d2),.SEL_SIZE('d1),.IO_WIDTH('d18))
            M13 (A2,B1,18'b0,18'b0,OpBUF[4],C1); 

LOGIC_INPUT #(.WIDTH('d18),.DREG(B1REG),.RSTTYPE(RSTTYPE)) 
            M6 (C1,clk,CEB,D1,RSTB);

LOGIC_INPUT #(.WIDTH('d18),.DREG(A1REG),.RSTTYPE(RSTTYPE)) 
            M7 (A3,clk,CEA,D2,RSTA);

assign E1= D1*D2;     

LOGIC_INPUT #(.WIDTH('d36),.DREG(MREG),.RSTTYPE(RSTTYPE)) 
            M8 (E1,clk,CEM,F1,RSTM);

assign EXTIN={12'b0,F1};

LOGIC_INPUT #(.WIDTH('d1),.DREG(CARRYINREG),.RSTTYPE(RSTTYPE)) 
            M11 (IN2,clk,CECARRYIN,A5,RSTCARRYIN);           

MUX_C #(.CARRYINSEL(CARRYINSEL)) 
            M10 (OpBUF[5],CARRYIN,IN2);
             


MUX #(.INPUT_SIZE('d4),.SEL_SIZE('d2),.IO_WIDTH('d48))
            M16 (48'b0,EXTIN,O2,CONC,OpBUF[1:0],G1);                      

assign CONC={D[11:0],D2,D1};

MUX #(.INPUT_SIZE('d4),.SEL_SIZE('d2),.IO_WIDTH('d48))
            M17 (48'b0,PCIN,O2,A4,OpBUF[3:2],G2);

/*MULTI M14 (
  .A(D1),      // input wire [17 : 0] A
  .B(D2),      // input wire [17 : 0] B
  .P(E1)      // output wire [47 : 0] P
);
*/
ADD_SUB_post M15 (G2,G1,CIN,OpBUF[7],H1,H2);      

LOGIC_INPUT #(.WIDTH('d1),.DREG(CARRYOUTREG),.RSTTYPE(RSTTYPE))
            M18 (H2,clk,CECARRYIN,O1,RSTCARRYIN);

LOGIC_INPUT #(.WIDTH('d48),.DREG(PREG),.RSTTYPE(RSTTYPE))
            M19 (H1,clk,CEP,O2,RSTP);        

//**************************************************************************************

assign BCOUT=D1;
assign M=F1;
assign CARRYOUT=O1;
assign CARRYOUTF=O1;
assign PCOUT=O2;
assign P=O2; 

endmodule