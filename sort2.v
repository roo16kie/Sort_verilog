module sort2(no1,no2,no3,a,b,c,clk,rst);
parameter width=3;
output[width-1:0] no1,no2,no3;
input clk,rst;
input[width-1:0] a,b,c;

reg [width-1:0] no1,no2,no3;
reg [width-1:0] no_1,no_2,no_3;
reg [width-1:0] op1 = 3'b000;
reg [width-1:0] op2 = 3'b000;
reg [width-1:0] op3 = 3'b000;

parameter p1 = 3'b000;
parameter p2 = 3'b001;
parameter p3 = 3'b011;
parameter p4 = 3'b010;
parameter p5 = 3'b110;
parameter p6 = 3'b111;
reg [width-1:0] sequence ;

always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		no1<=3'b000;
		no2<=3'b000;
		no3<=3'b000;
	end
	else begin
		no1<=no_1;
		no2<=no_2;
		no3<=no_3;
	     end
end

always@(a or b or c)
begin
	op1 = a ;
	op2 = b ;
	op3 = c ;
end
always@(op1 or op2 or op3)
begin
	     if(op1>=op2&&op2>=op3)
		sequence = p1 ;
	else if (op1>=op3&&op3>op2)
		sequence = p2 ;
	else if (op2>op1&&op1>=op3)
		sequence = p3 ;
	else if (op2>=op3&&op3>op1)
		sequence = p4 ;
	else if (op3>op1&&op1>=op2)
		sequence = p5 ;
	else if (op3>op2&&op2>op1)
		sequence = p6 ;
end
always@(sequence)	
	case(sequence)

	p1:  begin no_1=op1;no_2=op2;no_3=op3; end
	p2:  begin no_1=op1;no_2=op3;no_3=op2; end
	p3:  begin no_1=op2;no_2=op1;no_3=op3; end
	p4:  begin no_1=op2;no_2=op3;no_3=op1; end
	p5:  begin no_1=op3;no_2=op1;no_3=op2; end
	p6:  begin no_1=op3;no_2=op2;no_3=op1; end

	default:  begin no_1=no_1;no_2=no_2;no_3=no_3; end

	endcase
end


endmodule
