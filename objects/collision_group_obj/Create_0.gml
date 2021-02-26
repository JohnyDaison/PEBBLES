members = ds_list_create();
self.annihilate = false;
self.resolved = false;
speed_threshold = 1;
sitting_on_terrain = false;

force = ds_map_create();
for(i=g_red; i<g_white; i++)
{
    force[? i] = 0;   
}
ratio_updated = false;
base_color = g_black;
ratio = 0;
balance_margin = 0.1;

// This is not general, it's made for energyballs