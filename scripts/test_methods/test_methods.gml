function test_methods() {
    test_list = ds_list_create();
    test_list2 = ds_list_create();
    
    with(guy_obj) {
        ds_list_add(other.test_list, drop_reserve_orbs);
        ds_list_add(other.test_list2, die_from_falling);
    }
    
    var count = ds_list_size(test_list);
    
    for(var index = 0; index < count; index++) {
        var method_ref = test_list[| index];
        
        method_ref();
        
        method_ref = test_list2[| index];
        
        method_ref();
        
    }
    
    ds_list_destroy(test_list);
    ds_list_destroy(test_list2);
    
    delete test_list;
    delete test_list2;
    
    return count;
}