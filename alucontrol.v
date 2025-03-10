
module alu_control_unit (
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [6:0] alu_op,
    output reg [3:0] alu_control                                              );
    always @(*) begin
        case (alu_op)
            7'b0110011: begin  // R-Type
                case (funct3)
                    3'b000: alu_control = (funct7 == 7'b0000000) ? 4'b0010 : >
                    3'b111: alu_control = 4'b0000;  // AND
                    3'b110: alu_control = 4'b0001;  // OR
                    3'b100: alu_control = 4'b0011;  // XOR
                    default: alu_control = 4'b0000;
                endcase
            end
            default: alu_control = 4'b0000;
        endcase
    end
endmodule
