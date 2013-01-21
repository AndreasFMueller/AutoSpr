expression: VARIABLE ASSIGN CONSTANT {
            $$.type = GVM_NODE_ASSIGN_CONSTANT;
            $$.u.a.target_varno = $1;
            mpz_init_set($$.u.a.constant, $3);
        }
    ...
    |   VARIABLE ASSIGN VARIABLE OPERATOR VARIABLE {
            $$.type = GVM_NODE_ASSIGN_OPERATOR;
            $$.u.a.target_varno = $1;
            $$.u.a.source_varno = $3;
            $$.u.a.operator = $4;
            $$.u.a.source2_varno = $5;
        }
