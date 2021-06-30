event_inherited();

name = "Infocursor Tool";

x_offset = 32;
y_offset = 32;
line_separation = 24;
max_width = 640;
margin = 6;
bg_alpha = 0.8;
font = label_font;
depth = cursor_obj.depth;

categories = ds_list_create();
category_count = 0;
results = ds_list_create();

function create_categories() {
    add_category("Game");
    add_category("Non-Game");
    add_category("GUI");
}

function add_category(name) {
    if(!is_undefined(get_category(name))) {
        return;
    }
    
    var category = {
        name: name,
        lines: ds_list_create()
    };
    
    ds_list_add(categories, category);
    category_count++;
}


function get_category(name) {
    for (var index = 0; index < category_count; index++) {
        var category = categories[| index];
        if (category.name == name) {
            return category;
        }
    }
    
    return undefined;
}

function clear_categories() {
    for (var index = 0; index < category_count; index++) {
        var category = categories[| index];
        ds_list_clear(category.lines);
    }
}

function categories_to_string() {
    var whole_str = "";
    
    for (var index = 0; index < category_count; index++) {
        var category = categories[| index];
        var line_count = ds_list_size(category.lines);
        
        if (line_count > 0) {
            if (whole_str != "") {
                whole_str += "\n";
            }
            whole_str += "-" + category.name + "-";
        }

        for (var line_index = 0; line_index < line_count; line_index++) {
            whole_str += "\n" + category.lines[| line_index];
        }
    }
    
    return whole_str;
}

function generate_result_line(result) {
    var new_line = string(result.id) + " (" + object_get_name(result.object_index) + ")";
    new_line += " [" + string(result.x) + "," + string(result.y) + "]";
    
    if (variable_instance_exists(result, "my_color")) {
        new_line += " " + DB.colornames[? result.my_color];
    }
    
    return new_line;
}

create_categories();
