function RulePresetsDB() constructor {
    list = ds_list_create();
    count = 0;
    
    static add = function(str_id, name) {
        var preset = new RulePreset(str_id, name);
        ds_list_add(list, preset);
        count = ds_list_size(list);
        
        return preset;
    }
    
    static find_preset_by_id = function(str_id) {
        for (var index = 0; index < count; index++) {
            var preset = list[| index];
            
            if (preset.str_id == str_id) {
                return preset;
            }
        }
    }
    
    static destroy = function() {
        for (var index = count-1; index >= 0; index--) {
            var preset = list[| index];
            preset.destroy();
        }
        
        ds_list_destroy(list);
    }
}