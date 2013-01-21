typedef struct gvm_assign_s {
        int     target_varno;
        int     source_varno;
        char    operator;
        int     source2_varno;
        mpz_t   constant;
} gvm_assign_t;

typedef struct gvm_goto_s {
        int     condition_varno;
        int     condition_constant;
        int     target;
} gvm_goto_t;
