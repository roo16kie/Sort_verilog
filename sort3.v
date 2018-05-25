module pplsort(no1, no2, no3, a, b, c, clk, rst);
parameter width=3;
output [width-1:0] no1, no2, no3;
input clk,rst;
input[width-1:0] a,b,c;

reg [width-1:0] no1= 3'b000, no2= 3'b000, no3 = 3'b000;
reg [width-1:0] a1= 3'b000,a2= 3'b000,a3= 3'b000,a4= 3'b000,b1= 3'b000,b2= 3'b000,b3= 3'b000,b4= 3'b000,c1= 3'b000,c2= 3'b000,c3= 3'b000,c4= 3'b000;

always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		no1<=3'b000;
		no2<=3'b000;
		no3<=3'b000;
	end
	else
	begin
		no1<=a4;
		no2<=b4;
		no3<=c4;
	end
end

always@(a or b or c)
begin
	a1=a;
	b1=b;
	c1=c;
end

always@(posedge clk)
begin
	c2<=c1;
	if(a1>=b1)
	begin
		a2 <= a1 ;
		b2 <= b1 ;
	end
	else
	begin
		a2 <= b1 ;
		b2 <= a1 ;
	end
end

always@(posedge clk)
begin
	a3<=a2;
	if(b2>=c2)
	begin
		b3 <= b2 ;
		c3 <= c2 ;
	end
	else
	begin
		b3 <= c2 ;
		c3 <= b2 ;
	end
end
always@(posedge clk)
begin
	c4<=c3;
	if(a3>=b3)
	begin
		a4 <= a3 ;
		b4 <= b3 ;
	end
	else
	begin
		a4 <= b3 ;
		b4 <= a3 ;
	end


end

endmodule