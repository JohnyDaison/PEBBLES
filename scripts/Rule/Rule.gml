/// @param {String} name
/// @param {String} type values: "bool" or "number"
/// @param {Bool} public is it exposed in the UI
/// @param {Asset.GMSprite} icon
/// @param {String} description
function Rule (name, type, public, icon = undefined, description = "") constructor {
    self.name = name;
    self.type = type;
    self.public = public;
    self.icon = icon;
    self.description = description;
    
    if (type == "number") {
        self.default_value = 0;
        self.min_value = 0;
        self.max_value = 0;
        self.value_step = 0;
    }
}