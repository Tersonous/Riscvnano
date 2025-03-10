module register_file (
    input wire clk,
    input wire [4:0] rs1, rs2, rd,
    input wire reg_write,
    input wire [31:0] write_data,                                                 output wire [31:0] reg_data1, reg_data2
);
    reg [31:0] registers [0:31];

    always @(posedge clk) begin
        if (reg_write && rd != 0)
            registers[rd] <= write_data;
    end

    assign reg_data1 = registers[rs1];
    assign reg_data2 = registers[rs2];
endmodule
