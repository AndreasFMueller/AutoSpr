case GVM_NODE_CONDITIONAL_GOTO:
  if (0 == mpz_cmp_ui(
    gvmp->vars[gvmp->nodes[pc].u.g.condition_varno],
    gvmp->nodes[pc].u.g.condition_constant)) {
    pc = gvmp->nodes[pc].u.g.target;
  } else {
    pc += 1;
  }
  break;
