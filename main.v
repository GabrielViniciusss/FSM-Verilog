
module main(signal, result, A,B,clk,botaoMult,botaoAdd,botaoSub,botaoPower,display1,display2,display3,display4,display5,display6,display7,display8);
input botaoMult,botaoAdd,botaoSub,botaoPower,clk;
input[6:0] A, B;
output reg signal=0;
output [6:0] display1,display2,display3,display4,display5,display6,display7,display8;
output reg [13:0] result;

reg[6:0] n1,n2;
reg pressed1=0,pressed2=0,pressed3=0,pressed4=0;

parameter add = 0,sub = 1,mult = 2,off = 3,on = 4, maior = 99;
reg[2:0] state = 0;
reg offFlag = 1;

always@(posedge clk) begin

	if(!botaoPower) pressed4 = 1;
	if(!botaoAdd)  pressed1 = 1;
	if(!botaoSub)  pressed2 = 1;
	if(!botaoMult) pressed3 = 1;
	
    case(state)
        off: begin
			if(botaoPower && pressed4) begin
			pressed4 = 0;
			state<=on;
			end
		end
        on: begin
			if(botaoPower && pressed4)begin
				pressed4 = 0;
				state<=off;
			end
			if(botaoAdd && pressed1)begin
				pressed1 = 0;
				state<=add;
			end
			if(botaoSub && pressed2)begin
				state<=sub;
				pressed2 = 0;
			 end
				
			if(botaoMult && pressed3)begin
				state<=mult;
				pressed3 = 0;
			end
        end
        add: begin
			if(botaoPower && pressed4)begin
				pressed4 = 0;
				state<=off;
			end
			
			if(botaoAdd && pressed1)begin
				pressed1 = 0;
				state<=add;
			end
			
			if(botaoSub && pressed2)begin
				state<=sub;
				pressed2 = 0;
			 end
				
			if(botaoMult && pressed3)begin
				state<=mult;
				pressed3 = 0;
			end
		end
		sub: begin
			if(botaoPower && pressed4)begin
				pressed4 = 0;
				state<=off;
			end
			
			if(botaoAdd && pressed1)begin
				pressed1 = 0;
				state<=add;
			end
			
			if(botaoSub && pressed2)begin
				state<=sub;
				pressed2 = 0;
			 end
				
			if(botaoMult && pressed3)begin
				state<=mult;
				pressed3 = 0;
			end
		end
		mult: begin
			if(botaoPower && pressed4)begin
				pressed4 = 0;
				state<=off;
			end
			
			if(botaoAdd && pressed1)begin
				pressed1 = 0;
				state<=add;
			end
			
			if(botaoSub && pressed2)begin
				state<=sub;
				pressed2 = 0;
			 end
				
			if(botaoMult && pressed3)begin
				state<=mult;
				pressed3 = 0;
			end
		end
		
    endcase
end

always@(state or A or B) begin

    n1 <= A;
    n2 <= B;

    begin
    if(A>maior) n1 <= maior;
    if(B>maior) n2 <= maior;
    end

    case(state)

        add: begin
            signal = 0;
            result <= n1+n2;
            offFlag <= 0;
        end

        sub: begin
            if(n1<n2)begin
            result <= n2-n1;
            signal = 1;
            end
            else begin
            result <= n1-n2;
            signal = 0;
            end
            offFlag <= 0;
        end

        mult: begin
            signal = 0;
            result <= n1*n2;
            offFlag <= 0;
        end
		
		off: offFlag <= 1;
		
        default: begin
			result <= 0;
			offFlag <= 0;
		end

    endcase
end

decodificador_entrada decod1(offFlag,A,B,display2,display1,display4,display3);
decodificador_saida decod2(offFlag,result,display8,display7,display6,display5);

endmodule
