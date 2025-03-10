module riscv_microcontroller (
    input wire clk,
    input wire reset
);
    wire [31:0] instruction;
    wire [31:0] pc;
    wire [31:0] alu_result;
    wire [31:0] reg_data1, reg_data2;
    wire [31:0] imm;
    wire [4:0] rd, rs1, rs2;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire branch, mem_read, mem_write, reg_write, alu_src;
    wire [3:0] alu_control;

    // Program Counter
    program_counter PC (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    // Instruction Memory
    instruction_memory IM (
        .pc(pc),
        .instruction(instruction)
    );

    // Instruction Decode
    instruction_decode ID (
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .imm(imm)
    );

    // Register File
    register_file RF (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .reg_write(reg_write),
        .write_data(alu_result),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2)
    );

    // ALU Control
    alu_control_unit ALU_CTRL (
        .funct3(funct3),
        .funct7(funct7),
        .alu_op(opcode),
        .alu_control(alu_control)
    );

    // ALU
    alu ALU (
        .data1(reg_data1),
        .data2(alu_src ? imm : reg_data2),
        .alu_control(alu_control),
        .alu_result(alu_result)
    );

    // Control Unit
    control_unit CU (
        .opcode(opcode),
        .branch(branch),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .alu_src(alu_src)
    );

endmodule
