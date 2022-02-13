function RuleCategory(name) constructor {
    self.name = name;
    rule_list = ds_list_create();
    
    static destroy = function() {
        ds_list_destroy(rule_list);
    }
}