module sort1(no1,no2,no3,a,b,c,clk,rst);
parameter width=3;
output[width-1:0] no1,no2,no3;
input clk,rst;
input[width-1:0] a,b,c;

reg [width-1:0] no1,no2,no3;
reg [width-1:0] a_r,b_r,c_r;
reg [width-1:0] temp [0:2];
reg [width-1:0] buffer;
integer i,j;

always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		no1 <= 3'h0;
		no2 <= 3'h0;
		no3 <= 3'h0;
	end
	else
	begin
		no1 <= temp[2];
		no2 <= temp[1];
		no3 <= temp[0];
	end
end

always@(a or b or c)
begin
	a_r = a;
	b_r = b;
	c_r = c;
end

always@(a_r or b_r or c_r)
begin
	temp[0] = a_r;
	temp[1] = b_r;
	temp[2] = c_r;
	for(i=1;i>=0;i=i-1)
		for(j=0;j<=i;j=j+1)
			if(temp[j] > temp[j+1])
			begin
				buffer = temp[j+1];
				temp[j+1] = temp[j];
				temp[j] = buffer;
			end
end

endmodule
