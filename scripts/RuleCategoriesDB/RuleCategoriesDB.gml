function RuleCategoriesDB() constructor {
    self.categories = [];
    
    static add = function(name) {
        var category = new RuleCategory(name);
        
        array_push(categories, category);
        
        return category;
    }
}