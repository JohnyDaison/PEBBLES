event_inherited();

self.sprite_index = no_sprite;
self.force_used = 0;

my_sound_play(shot1_sound);
//my_sound_play_colored(shot1_sound, g_dark, true);

self.stolen_slots = ds_list_create();
self.slot_count = 0;

self.radius = 136;

self.name = "Implosion";
