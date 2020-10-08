action_inherited();
self.width = 0;
self.height = 0;
self.orig_alpha = 1;
self.bg_alpha = 0.66;
self.bg_color = merge_color(c_yellow,c_dkgray,0.25);
self.orig_bg_color = self.bg_color;
self.color = c_black;
self.border_color = c_red;
self.font = tutorial_font;
/*
x = view_wview[0]/2-width/2;
y = view_hview[0]/2-height/2;
*/
self.title = "";
self.message = "";
self.cur_message_step = 0;
old_message = message;
self.adjusted = false;
my_guy = noone;

max_width = 0;
line_height = 32;
max_lines = 2;

message_delay = 60;
blink_time = 30;
blink_peak = 10;
blink_color = c_white;
fadeout_time = 90;
blink_step = 0;
fadeout_step = 0;

messages = ds_map_create();
var i=1;
ds_map_add(messages, i++ , message_movement);
ds_map_add(messages, i++ , message_attack);
ds_map_add(messages, i++ , message_change_color);
ds_map_add(messages, i++ , message_create_shield);
ds_map_add(messages, i++ , message_crystals);
ds_map_add(messages, i++ , message_sprinkler);
ds_map_add(messages, i++ , message_load_cannon);
ds_map_add(messages, i++ , message_fire_cannon);

ds_map_add(messages, i++ , message_flashback);
ds_map_add(messages, i++ , message_berserk);
ds_map_add(messages, i++ , message_heal);
ds_map_add(messages, i++ , message_teleport);
ds_map_add(messages, i++ , message_haste);
ds_map_add(messages, i++ , message_invis);
ds_map_add(messages, i++ , message_ubershield);
ds_map_add(messages, i++ , message_base_teleport);
message_count = ds_map_size(messages);

// 0 - NOT SHOWN, 1 - ACTIVE, 2 - WAS SHOWN
message_state = ds_map_create();
for(var i = 1; i <= message_count; i++)
{
    ds_map_add(message_state, i, 0);
}

alarm[2] = message_delay;

/* */
/*  */
