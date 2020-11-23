event_inherited();

my_guy = noone;
my_camera = noone;
ready = false;

width = 0;
height = 128;
status_width = 83;
status_height = 83;
status_margin = 5;
status_distance = status_width + status_margin;
bg_alpha = 0;
border_width = 0;
last_width = 0;

status_list = ds_list_create();
status_order = ds_list_create();
status_alpha = ds_map_create();
status_fade_rate = 0.012;

var effect_id;

for(var i = 0; i < DB.status_effect_count; i++)
{
    effect_id = DB.status_effects_list[| i];
    
    status_list[| i] = effect_id;
    status_alpha[? effect_id] = 0;
}    



