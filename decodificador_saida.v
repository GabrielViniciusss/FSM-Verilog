module decodificador_saida(flag,Result,out_uniR,out_dezR,out_cenR,out_milR);

input [13:0] Result;
output[6:0] out_uniR,out_dezR,out_cenR,out_milR;
reg[3:0] uni_R,dez_R,cen_R,mil_R;
input flag;

always@(Result)begin

	uni_R <= Result % 10;       
    dez_R <= Result / 10;
    cen_R <= Result/100;
    mil_R <= Result/1000;
    
end

decodificador kk(flag,uni_R, out_uniR);
decodificador kk2(flag,dez_R, out_dezR);
decodificador kk3(flag,cen_R, out_cenR);
decodificador kk4(flag,mil_R, out_milR);

endmodule
