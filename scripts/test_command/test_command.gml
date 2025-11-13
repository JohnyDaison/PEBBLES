function test_command(test_id) {
    switch (test_id) {
        case "methods":
            return test_methods();
        case "struct_methods":
            return test_methods_structs();
    }
}
