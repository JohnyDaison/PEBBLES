function RuleCategoriesDB() constructor {
    list = ds_list_create();
    count = 0;
    
    static add = function(name) {
        var category = new RuleCategory(name);
        ds_list_add(list, category);
        count = ds_list_size(list);
        
        return category;
    }
    
    static destroy = function() {
        for (var index = count-1; index >= 0; index--) {
            var category = list[| index];
            category.destroy();
        }
        
        ds_list_destroy(list);
    }
}