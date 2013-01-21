typedef struct gvm_s {
        int             nnodes;
        gvm_node_t      *nodes;
        int             nvars;
        mpz_t           *vars;
        ...
} gvm_t;
