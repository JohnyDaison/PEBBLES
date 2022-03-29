function test_command(test_id) {
    switch(test_id) {
        case "methods":
            return test_methods();
            break;
        case "struct_methods":
            test_methods_structs();
            break;
    }
}