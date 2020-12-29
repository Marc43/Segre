package segre_pkg;

/*****************
*    OPCODES     *
*****************/
typedef enum logic [6:0] {
  OPCODE_LOAD     = 7'h03,
  OPCODE_MISC_MEM = 7'h0f,
  OPCODE_OP_IMM   = 7'h13,
  OPCODE_AUIPC    = 7'h17,
  OPCODE_STORE    = 7'h23,
  OPCODE_OP       = 7'h33,
  OPCODE_LUI      = 7'h37,
  OPCODE_BRANCH   = 7'h63,
  OPCODE_JALR     = 7'h67,
  OPCODE_JAL      = 7'h6f,
  OPCODE_SYSTEM   = 7'h73
} opcode_e;

localparam NOP_INSTR = {{25{0}}, OPCODE_OP_IMM};

typedef enum logic [5:0] {
    // Arithmetic
    ALU_ADD,
    ALU_SUB,
    ALU_SLL,
    ALU_SLT,
    ALU_SLTU,
    ALU_XOR,
    ALU_SRL,
    ALU_SRA,
    ALU_OR,
    ALU_AND,
    ALU_JAL,
    ALU_JALR,
    ALU_BEQ,
    ALU_BNE,
    ALU_BLT,
    ALU_BGE,
    ALU_BLTU,
    ALU_BGEU,
    ALU_AUIPC
} alu_opcode_e;

/*****************
* ALU PARAMETERS *
*****************/
typedef enum logic[1:0] {
    ALU_A_REG,
    ALU_A_IMM,
    ALU_A_PC
} alu_src_a_e;

typedef enum logic[1:0] {
    ALU_B_REG,
    ALU_B_IMM
} alu_src_b_e;

typedef enum logic {
    BR_A_REG,
    BR_A_PC
} br_src_a_e;

typedef enum logic {
    BR_B_REG
} br_src_b_e;

typedef enum logic[2:0] {
    IMM_B_I,
    IMM_B_U,
    IMM_B_J,
    IMM_B_B,
    IMM_B_S
} alu_imm_b_e;

typedef enum logic {
    IMM_A_ZERO
} alu_imm_a_e;

typedef enum logic [2:0] {
    IF_STATE = 0,
    ID_STATE,
    EX_STATE,
    MEM_STATE,
    WB_STATE
} fsm_state_e;

typedef enum logic [1:0] {
    BYTE,
    HALF,
    WORD
} memop_data_type_e;

//GENERAL SIZES
parameter WORD_SIZE = 32;
parameter ADDR_SIZE = 32;
parameter REG_SIZE  = 5;

//CACHE PARAMETERS
parameter CACHE_LINE_SIZE_BITS = 128;
parameter CACHE_LINE_SIZE_BYTES = CACHE_LINE_SIZE_BITS/8;
parameter NUMBER_OF_LINES = 4;
parameter M = $clog2(CACHE_LINE_SIZE_BITS/8);
parameter N = $clog2(NUMBER_OF_LINES) + M;
parameter TAG_SIZE = WORD_SIZE - N + 1;

//STORE BUFFER
parameter NUM_SB_ENTRIES = 4;
parameter SB_ENTRY_BITS = $clog2(NUM_SB_ENTRIES);//Number of bits needed to represent NUM_SB_ENTRIES

typedef enum logic [0:0] {
    ICACHE = 0,
    DCACHE = 1
} cache_id_e;

typedef struct packed {
    cache_id_e cache_id;
    logic rd;
    logic wr;
    logic [WORD_SIZE-1:0] addr;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_line;
} cache_mem_req_t;

// + 2 bits, one to know if the request is from icache/dcache
parameter ARB_BUF_SIZE = 16;
parameter ARB_PTR_SIZE = $clog2(ARB_BUF_SIZE);

// Virtual memory (simplified TLB entry example, excluding internal index) 
// |                    VPage bits            |||||||  internal page index  |
// |31--------------------------------------12|||||||11--------------------0|
// |                                          |||||||                       |

parameter PHYSICAL_ADDR_SIZE = 20;
parameter VIRT_PAGE_BITS = 20;
parameter PHYS_PAGE_BITS = 8;

parameter TLB_ENTRIES = 32;
parameter TLB_ENTRY_BITS = $clog2(TLB_ENTRIES); //Should be 5 (to have 32 TLB entries)
parameter TLB_TAG_BITS = VIRT_PAGE_BITS - TLB_ENTRY_BITS; //Should be 15

endpackage : segre_pkg
