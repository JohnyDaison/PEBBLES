event_inherited();

var RuleID = global.RuleID;

self.my_team_number = 0;
self.flag_icon = noone;
self.flag_score = rule_get_state(RuleID.FlagCaptureScore);
self.flag_alpha = 0.9;

self.has_flag = true;

self.captured_flag_icon = noone;
self.captured_flag_player = noone;
self.captured_anim_duration = 180;
self.captured_anim_fade_duration = 30;
self.captured_anim_blink_time = 15;
self.captured_anim_phase = 0;

self.static_anim_length = 4;
self.static_anim_speed = 0.25;
self.static_anim_phase = 0;

// LIGHT
self.my_color = g_white;
self.radius = 32;
self.gives_light = true;
self.shape = shape_circle;
self.ambient_light = 0.3;
self.direct_light = 0.025;

self.lights = ds_list_create();
var light;

light = instance_create_layer(self.x, self.y - 72, "Lights", point_light_emitter_obj);
light.sprite_index = empty_mask;
light.my_color = g_green;
light.my_holder = self.id;

ds_list_add(lights, light);

light = instance_create_layer(self.x - 32, self.y - 16, "Lights", point_light_emitter_obj);
light.sprite_index = empty_mask;
light.my_color = g_green;
light.my_holder = self.id;

ds_list_add(lights, light);

light = instance_create_layer(self.x + 32, self.y - 16, "Lights", point_light_emitter_obj);
light.sprite_index = empty_mask;
light.my_color = g_green;
light.my_holder = self.id;

ds_list_add(self.lights, light);

self.light_count = ds_list_size(self.lights);

self.alarm[1] = 2;

function reset_flag() {
    has_flag = true;
}

/// @param {Bool} state
function set_lights_state(state) {
    for (var light_index = 0; light_index < self.light_count; light_index++) {
        self.lights[| light_index].gives_light = state;
    }
}

self.set_lights_state(false);

self.name = "Flag Holder";
