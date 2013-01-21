typedef struct gvm_node_s {
        int     type;
        union gvm_node_payload_u {
                gvm_assign_t    a;
                gvm_goto_t      g;
                gvm_print_t     p;
        } u;
} gvm_node_t;
