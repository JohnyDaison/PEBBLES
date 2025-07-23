/// @param {String} str_id
/// @param {String} name
function RulePreset(str_id, name) constructor {
    self.str_id = str_id;
    self.name = name;
    self.forced_modifiers = ds_map_create();
    self.default_modifiers = ds_map_create();
    
    static destroy = function() {
        ds_map_destroy(forced_modifiers);
        ds_map_destroy(default_modifiers);
    }
}
