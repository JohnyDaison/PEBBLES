event_inherited();

var RuleID = global.RuleID;

my_team_number = 0;
flag_icon = noone;
flag_score = rule_get_state(RuleID.FlagCaptureScore);
flag_alpha = 0.9;

has_flag = true;

captured_flag_icon = noone;
captured_flag_player = noone;
captured_anim_duration = 180;
captured_anim_fade_duration = 30;
captured_anim_blink_time = 15;
captured_anim_phase = 0;

static_anim_length = 4;
static_anim_speed = 0.25;
static_anim_phase = 0;

// LIGHT
my_color = g_white;
radius = 32;
gives_light = true;
shape = shape_circle;
ambient_light = 0.3;
direct_light = 0.025;

lights = ds_list_create();
var light;

light = instance_create_layer(x, y - 72, "Lights", point_light_emitter_obj);
light.sprite_index = empty_mask;
light.my_color = g_green;
light.my_holder = id;

ds_list_add(lights, light);

light = instance_create_layer(x - 32, y - 16, "Lights", point_light_emitter_obj);
light.sprite_index = empty_mask;
light.my_color = g_green;
light.my_holder = id;

ds_list_add(lights, light);

light = instance_create_layer(x + 32, y - 16, "Lights", point_light_emitter_obj);
light.sprite_index = empty_mask;
light.my_color = g_green;
light.my_holder = id;

ds_list_add(lights, light);

light_count = ds_list_size(lights);

alarm[1] = 2;

reset_flag = function() {
    has_flag = true;
}

set_lights_state = function(state) {
    for (var light_index = 0; light_index < light_count; light_index++) {
        lights[| light_index].gives_light = state;
    }
}

set_lights_state(false);

name = "Flag Holder";