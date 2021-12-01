event_inherited();

activated = false;
enabled = true;
destroyed = false;
image_speed = 0.1;
for_player = -1;
invisible = !gamemode_obj.visible_checkpoints;
is_duplicate = false;
duplicate_me = false;

label_distance = 32;
label_scale = 1.5;

trigger_script = checkpoint_trigger_script;
triggerable = true;

self.holographic = false;
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

name = "Checkpoint";

spawn_points = ds_map_create();

if(gamemode_obj.is_campaign)
{
    alarm[3] = 3;
}