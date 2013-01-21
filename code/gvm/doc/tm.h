typedef struct tm_node_s {
        int     from_state;
        int     from_tapechar;
        int     to_state;
        int     to_tapechar;
        int     movement;
} tm_node_t;

typedef struct tm_s {
        int     nnodes;
        tm_node_t       *nodes;
        int     initialstate;
        int     initialposition;
        char    *initialtape;
} tm_t;
