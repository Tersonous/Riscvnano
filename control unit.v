
module control_unit (
    input wire [6:0] opcode,
    output reg branch, mem_read, mem_write, reg_write, alu_src
);
    always @(*) begin                                                                 case (opcode)
            7'b0110011: begin  // R-Type
                reg_write = 1;
                alu_src = 0;
                branch = 0;
                mem_read = 0;
                mem_write = 0;
            end
            7'b0010011: begin  // I-Type (ADDI, ANDI, ORI)
                reg_write = 1;
                alu_src = 1;
                branch = 0;
                mem_read = 0;
                mem_write = 0;
            end
            default: begin
                reg_write = 0;
                alu_src = 0;
                branch = 0;
                mem_read = 0;
                mem_write = 0;
            end
        endcase
    end
endmodule
