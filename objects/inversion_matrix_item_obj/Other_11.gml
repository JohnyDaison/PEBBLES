x = (other.x div 32)*32 +16;
y = (other.y div 32)*32 +16;
visible = true;
speed = 0;
gravity = 0;
collected = false;
used = true;
placed = true;
attached = true;
armed = true;
active = true;
radius = 14;
field_radius = 2*32;
field_width = 2* (x mod 32 + field_radius);
field_height = 2* (y mod 32 + field_radius);

field_left = x - field_width/2;
field_right = x + field_width/2 - 1;
field_top = y - field_height/2;
field_bottom = y + field_height/2 - 1;

depth = -9001;

step = 0;

