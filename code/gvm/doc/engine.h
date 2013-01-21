int     pc = 0;
while (pc < gvmp->nnodes) {
        switch (gvmp->nodes[pc].type) {
        case GVM_NODE_ASSIGN_CONSTANT:
                ...
                pc += 1;
                break;
        case GVM_NODE_ASSIGN_VARIABLE:
                ...
                pc += 1;
                break;
        case GVM_NODE_ASSIGN_OPERATOR_CONST:
                ...
                pc += 1;
                break;
        ...
}
