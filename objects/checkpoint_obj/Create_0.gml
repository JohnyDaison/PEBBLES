event_inherited();

self.activated = false;
self.enabled = true;
self.destroyed = false;
self.image_speed = 0.1;
self.for_player = -1;
self.invisible = !gamemode_obj.visible_checkpoints;
self.is_duplicate = false;
self.duplicate_me = false;

self.label_distance = 32;
self.label_scale = 1.5;

self.trigger_script = checkpoint_trigger_script;
self.triggerable = true;

self.holographic = false;
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

self.name = "Checkpoint";

self.spawn_points = ds_map_create();

if (gamemode_obj.is_campaign) {
    self.alarm[3] = 3;
}
