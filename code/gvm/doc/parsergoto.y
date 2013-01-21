expression: 
    ...
    |   IF VARIABLE '=' CONSTANT GOTO CONSTANT {
            $$.type = GVM_NODE_CONDITIONAL_GOTO;
            $$.u.g.condition_varno = $2;
            $$.u.g.condition_constant
                = mpz_get_ui($4);
            $$.u.g.target = mpz_get_ui($6) - 1;
        }
