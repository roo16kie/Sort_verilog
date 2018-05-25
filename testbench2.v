`timescale 1ns / 1ps
`define CYCLE 10
module testbench;

parameter width=3;
reg clk,rst ;
reg [width-1:0] a,b,c;
reg [width-1:0] ans_no1,ans_no2,ans_no3;
wire [width-1:0] no1,no2,no3;

integer i,j,k,l,error,num;

reg[width*3-1:0] ans[0:511];

sort2 sort(.no1(no1),
             .no2(no2),
			 .no3(no3),
			 .a(a),
			 .b(b),
			 .c(c),
			 .clk(clk),
			 .rst(rst));

always begin #(`CYCLE/2) clk=~clk ; end  //clock generation

initial begin
$readmemb("ans.txt",ans);
end

initial
begin
clk=1'b0;rst=1'b0;
l=0;
error=0;
num=1;
@(negedge clk) rst=1'b1 ;
#(`CYCLE*2) rst=1'b0 ;

@(negedge clk) ;
  for(i=0;i<8;i=i+1)begin
   for(j=0;j<8;j=j+1)begin
    for(k=0;k<8;k=k+1)begin
     a=i[width-1:0];
	 b=j[width-1:0];
	 c=k[width-1:0];
	 {ans_no1,ans_no2,ans_no3}=ans[l];
     @(negedge clk) ;
	 if (ans[l]!={no1,no2,no3})
	 begin
	    error=error+1; 
        $display($time,"## Error at a=%d, b=%d, c=%d ",a,b,c) ;
        $display($time,"Your result    : no1=%d, no2=%d, no3=%d ",no1,no2,no3) ;		
        $display($time,"Correct result : no1=%d, no2=%d, no3=%d",ans_no1,ans_no2,ans_no3) ;		 
	 end
	 else if (ans[l]=={no1,no2,no3}) num=num+1;
	 
	 l=l+1;
	 
    end
   end
  end



end
initial
begin
#(`CYCLE*600) 
if((error==0)&&(num==513)) begin
$display("-------------------   Bubble sort check successfully   -------------------");
$display("            $$              ");
$display("           $  $");
$display("           $  $");
$display("          $   $");
$display("         $    $");
$display("$$$$$$$$$     $$$$$$$$");
$display("$$$$$$$              $");
$display("$$$$$$$              $");
$display("$$$$$$$              $");
$display("$$$$$$$              $");
$display("$$$$$$$              $");
$display("$$$$$$$$$$$$         $$");
$display("$$$$$      $$$$$$$$$$");
end
else if(num!=513&&error==0)
begin
$display("-------------------------------------------------------------------------------");
$display("*                                                                             *");
$display("*                     Oops!Something wrong with your code                     *");
$display("*                                                                             *");
$display("-------------------------------------------------------------------------------");
end
else $display("-------------------   There are %d errors   -------------------", error);
$finish ;
end

endmodule
