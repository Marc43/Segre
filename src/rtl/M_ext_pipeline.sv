import segre_pkg::*;

module M_ext_pipeline (

    // Clock and reset
    input logic clk_i,
    input logic rsn_i,

    input logic valid_m1_i,

    input m_ext_opcode_e opcode_i,

    input logic rf_we_i,

    input logic [WORD_SIZE-1:0] src_a_i,
    input logic [WORD_SIZE-1:0] src_b_i,

    input logic [REG_SIZE-1:0] rf_waddr_i,

    /*
     * Outputs from stage M3 (to detect structural hazards)
     */

    output logic valid_m3_o,

    /*
     * Outputs from stage M5
     */

    output logic [REG_SIZE-1:0] rf_waddr_o,
    output logic [WORD_SIZE-1:0] rf_wdata_o,
    output logic valid_m5_o,
    output logic rf_we_o

    // TODO Add DIV/0 exceptions, and... exceptions at all
);

/*
 * M1 Stage
 */

logic m1_valid_d;
logic [WORD_SIZE-1:0] m1_src_a_d;
logic [WORD_SIZE-1:0] m1_src_b_d;
logic [REG_SIZE-1:0]  m1_rf_waddr_d;
m_ext_opcode_e m1_opcode_d;
logic m1_we_d;

logic m1_valid_q;
logic [WORD_SIZE-1:0] m1_src_a_q;
logic [WORD_SIZE-1:0] m1_src_b_q;
logic [REG_SIZE-1:0]  m1_rf_waddr_q;
m_ext_opcode_e m1_opcode_q;
logic m1_we_q;

always_comb begin
    if (!rsn_i) begin
        m1_valid_d = 0;
        m1_we_d = 0;
    end
    else begin
        m1_valid_d = valid_m1_i;
        m1_src_a_d = src_a_i;
        m1_src_b_d = src_b_i;
        m1_rf_waddr_d = rf_waddr_i;
        m1_opcode_d = opcode_i;
        m1_we_d = rf_we_i;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        m1_valid_q <= 0;
        m1_we_q <= 0;
    end
    else begin
        m1_valid_q <= m1_valid_d;
        m1_src_a_q <= m1_src_a_d;
        m1_src_b_q <= m1_src_b_d;
        m1_rf_waddr_q <= m1_rf_waddr_d;
        m1_opcode_q <= m1_opcode_d;
        m1_we_q <= m1_we_d;
    end
end

/*
 * M2 Stage
 */

logic m2_valid_d;
logic [WORD_SIZE-1:0] m2_src_a_d;
logic [WORD_SIZE-1:0] m2_src_b_d;
logic [REG_SIZE-1:0]  m2_rf_waddr_d;
m_ext_opcode_e m2_opcode_d;
logic m2_we_d;

logic m2_valid_q;
logic [WORD_SIZE-1:0] m2_src_a_q;
logic [WORD_SIZE-1:0] m2_src_b_q;
logic [REG_SIZE-1:0]  m2_rf_waddr_q;
m_ext_opcode_e m2_opcode_q;
logic m2_we_q;

always_comb begin
    if (!rsn_i) begin
        m2_valid_d = 0;
        m2_we_d = 0;
    end
    else begin
        m2_valid_d = m1_valid_q;
        m2_src_a_d = m1_src_a_q;
        m2_src_b_d = m1_src_b_q;
        m2_rf_waddr_d = m1_rf_waddr_q;
        m2_opcode_d = m1_opcode_q;
        m2_we_d = m1_we_q;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        m2_valid_q <= 0;
        m2_we_q <= 0;
    end
    else begin
        m2_valid_q <= m2_valid_d;
        m2_src_a_q <= m2_src_a_d;
        m2_src_b_q <= m2_src_b_d;
        m2_rf_waddr_q <= m2_rf_waddr_d;
        m2_opcode_q <= m2_opcode_d;
        m2_we_q <= m2_we_d;
    end
end

/*
 * M3 Stage
 */

logic m3_valid_d;
logic [WORD_SIZE-1:0] m3_src_a_d;
logic [WORD_SIZE-1:0] m3_src_b_d;
logic [REG_SIZE-1:0]  m3_rf_waddr_d;
m_ext_opcode_e m3_opcode_d;
logic m3_we_d;

logic m3_valid_q;
logic [WORD_SIZE-1:0] m3_src_a_q;
logic [WORD_SIZE-1:0] m3_src_b_q;
logic [REG_SIZE-1:0]  m3_rf_waddr_q;
m_ext_opcode_e m3_opcode_q;
logic m3_we_q;

always_comb begin
    if (!rsn_i) begin
        m3_valid_d = 0;
        m3_we_d = 0;
    end
    else begin
        m3_valid_d = m2_valid_q;
        m3_src_a_d = m2_src_a_q;
        m3_src_b_d = m2_src_b_q;
        m3_rf_waddr_d = m2_rf_waddr_q;
        m3_opcode_d = m2_opcode_q;
        m3_we_d = m2_we_q;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        m3_valid_q <= 0;
        m3_we_q <= 0;
    end
    else begin
        m3_valid_q <= m3_valid_d;
        m3_src_a_q <= m3_src_a_d;
        m3_src_b_q <= m3_src_b_d;
        m3_rf_waddr_q <= m3_rf_waddr_d;
        m3_opcode_q <= m3_opcode_d;
        m3_we_q <= m3_we_d;
    end
end

assign valid_m3_o = m3_valid_q;

/*
 * M4 Stage
 */

logic m4_valid_d;
logic [WORD_SIZE-1:0] m4_src_a_d;
logic [WORD_SIZE-1:0] m4_src_b_d;
logic [REG_SIZE-1:0]  m4_rf_waddr_d;
m_ext_opcode_e m4_opcode_d;
logic m4_we_d;

logic m4_valid_q;
logic [WORD_SIZE-1:0] m4_src_a_q;
logic [WORD_SIZE-1:0] m4_src_b_q;
logic [REG_SIZE-1:0]  m4_rf_waddr_q;
m_ext_opcode_e m4_opcode_q;
logic m4_we_q;

always_comb begin
    if (!rsn_i) begin
        m4_valid_d = 0;
        m4_we_d = 0;
    end
    else begin
        m4_valid_d = m3_valid_q;
        m4_src_a_d = m3_src_a_q;
        m4_src_b_d = m3_src_b_q;
        m4_rf_waddr_d = m3_rf_waddr_q;
        m4_opcode_d = m3_opcode_q;
        m4_we_d = m3_we_q;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        m4_valid_q <= 0;
        m4_we_q <= 0;
    end
    else begin
        m4_valid_q <= m4_valid_d;
        m4_src_a_q <= m4_src_a_d;
        m4_src_b_q <= m4_src_b_d;
        m4_rf_waddr_q <= m4_rf_waddr_d;
        m4_opcode_q <= m4_opcode_d;
        m4_we_q <= m4_we_d;
    end
end

/*
 * M5 Stage
 */

logic m5_valid_d;
logic [WORD_SIZE-1:0] m5_src_a_d;
logic [WORD_SIZE-1:0] m5_src_b_d;
logic [REG_SIZE-1:0]  m5_rf_waddr_d;
m_ext_opcode_e m5_opcode_d;
logic m5_we_d;

logic m5_valid_q;
logic [WORD_SIZE-1:0] m5_src_a_q;
logic [WORD_SIZE-1:0] m5_src_b_q;
logic [REG_SIZE-1:0]  m5_rf_waddr_q;
m_ext_opcode_e m5_opcode_q;
logic m5_we_q;

always_comb begin
    if (!rsn_i) begin
        m5_valid_d = 0;
        m5_we_d = 0;
    end
    else begin
        m5_valid_d = m4_valid_q;
        m5_src_a_d = m4_src_a_q;
        m5_src_b_d = m4_src_b_q;
        m5_rf_waddr_d = m4_rf_waddr_q;
        m5_opcode_d = m4_opcode_q;
        m5_we_d = m4_we_q;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        m5_valid_q <= 0;
        m5_we_q <= 0;
    end
    else begin
        m5_valid_q <= m5_valid_d;
        m5_src_a_q <= m5_src_a_d;
        m5_src_b_q <= m5_src_b_d;
        m5_rf_waddr_q <= m5_rf_waddr_d;
        m5_opcode_q <= m5_opcode_d;
        m5_we_q <= m5_we_d;
    end
end

logic rf_we;
logic [WORD_SIZE-1:0] rf_wdata;

always_comb begin
    if (!rsn_i) begin
        rf_we = 0;
    end
    else begin
        case (m5_opcode_q)
            MUL: begin
                rf_wdata = $signed(m5_src_a_q) * $signed(m5_src_b_q);
            end
            MULH: begin
                rf_wdata = (($signed(m5_src_a_q) * $signed(m5_src_b_q)) && 32'b0) >> 32; // TODO Lmao, no se si va aixo
            end
            MULHU: begin
                rf_wdata = ((m5_src_a_q * m5_src_b_q) && 32'b0) >> 32; // TODO Lmao, no se si va aixo
            end
            MULHSU: begin
                rf_wdata = (($signed(m5_src_a_q) * $unsigned(m5_src_b_q)) && 32'b0) >> 32; // TODO Lmao, no se si va aixo
            end
            DIV: begin
                rf_wdata = (m5_src_b_q != 0) ? ($signed(m5_src_a_q)/$signed(m5_src_b_q)) : {32{1}}; // If div by 0, infinity, but I think it's useless tho
            end
            DIVU: begin
                rf_wdata = (m5_src_b_q != 0) ? (m5_src_a_q/m5_src_b_q) : {32{1}};
            end
            REM: begin
                rf_wdata = $signed(m5_src_a_q)%$signed(m5_src_b_q);
            end
            REMU: begin
                rf_wdata = m5_src_a_q%m5_src_b_q;
            end
        endcase
    end
end

assign rf_waddr_o = m5_rf_waddr_q;
assign rf_wdata_o = rf_wdata;
assign rf_we_o = rf_we;
assign valid_m5_o = m5_valid_q;

endmodule : M_ext_pipeline
