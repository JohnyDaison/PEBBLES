event_inherited();

my_player = noone;
my_guy = noone;
my_camera = noone;
self.width = 600;
self.height = 64;
self.color = c_black;
self.bg_color = c_ltgray;
self.border_color = c_dkgray;
image_speed = 0.2;
self.font = score_font;

// detail stages of the score overlay
stage_alpha = 0.4;
stage_alpha_step = 0.2;
self.stage = 0;
self.stageheight[0] = 0;
self.stageheight[1] = 64;
self.stageheight[2] = 320;

have_changed = false;



