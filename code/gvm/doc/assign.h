case GVM_NODE_ASSIGN_OPERATOR:
  op1 = &gvmp->vars[gvmp->nodes[pc].u.a.source_varno];
  op2 = &gvmp->vars[gvmp->nodes[pc].u.a.source2_varno];
  switch (gvmp->nodes[pc].u.a.operator) {
  case '+':       mpz_add(result, *op1, *op2);
                  break;
  case '-':       mpz_sub(result, *op1, *op2);
                  break;
  ...
  }
  mpz_set(gvmp->vars[gvmp->nodes[pc].u.a.target_varno],
          result);
  pc += 1;
  break;
