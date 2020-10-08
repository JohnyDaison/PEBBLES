function test_methods() {
    test_list = ds_list_create();
    
    with(guy_obj) {
        ds_list_add(other.test_list, die);
    }
    
    var count = ds_list_size(test_list);
    
    for(var index = 0; index < count; index++) {
        var method_ref = test_list[| index];
        
        method_ref();
    }
    
    ds_list_destroy(test_list);
    
    delete test_list;
    
    return count;
}