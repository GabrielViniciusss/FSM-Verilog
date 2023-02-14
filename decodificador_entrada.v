
module decodificador_entrada (flag,a,b,out_uni_a, out_dez_a, out_uni_b, out_dez_b); 
 // yo voy
input[6:0] a, b;
input flag;
output[6:0] out_uni_a, out_dez_a, out_uni_b, out_dez_b;
 
reg [3:0] uni_a, dez_a, uni_b, dez_b;

always @ (a, b) begin
	
	uni_a <= a % 10;        // pega unidade de a
    dez_a <= a / 10;        // pega dezena de a
   
	uni_b <= b % 10;        // pega unidade de b
	dez_b <= b / 10;        // pega dezena de b
	
	if(a>99) begin
		dez_a<=9;
		uni_a<=9;
	end
	
	if(b>99) begin
		dez_b<=9;
		uni_b<=9;
	end
	
end

decodificador dec1(flag,uni_a, out_uni_a);
decodificador dec2(flag,dez_a, out_dez_a);
decodificador dec3(flag,uni_b, out_uni_b);
decodificador dec4(flag,dez_b, out_dez_b);

endmodule
