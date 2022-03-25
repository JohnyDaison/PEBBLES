event_inherited();

my_color = g_octarine;

orb_dist = 56;
orb_base_size = 1.25;
orb_angle_offset = 0;
orb_rot_speed = 1/720;
self.alarm[3] = 2;

guys = ds_list_create();

orb_count = 3;
orbs = ds_map_create();
orbs[? g_red] = noone;
orbs[? g_green] = noone;
orbs[? g_blue] = noone;

for(var color = g_red; color <= g_blue; color++)
{
    if(color == g_yellow) continue;
    
    var orb = instance_create_layer(x,y, "Orbs", color_orb_obj);
        
    orb.my_player = my_player;
    orb.my_guy = id;
    orb.orbit_anchor = id;
    orb.my_color = color;
    orb.collected = true;
    orb.tint_updated = false;
    orb.draw_label = false;
        
    orbs[? color] = orb;
}

add_orb = function(color) {
    if (is_undefined(orbs[? color])) {
        return false;   
    }
    
    var orb = orbs[? color];
    
    if (!(orb.color_added || orb.color_held || orb.color_consumed)) {
        orb.color_added = true;
        
        return true;
    }
    
    return false;
}

cost_paid = function() {
    var paid = true;
    for(var color = g_red; color <= g_blue; color++)
    {
        if(color == g_yellow) continue;
        
        var orb = orbs[? color];
        if (!(orb.color_added || orb.color_held) || orb.color_consumed) {
            paid = false;
        }
    }
    
    return paid;
}

reset_orbs = function() {
    for(var color = g_red; color <= g_blue; color++)
    {
        if(color == g_yellow) continue;
        
        var orb = orbs[? color];
        orb.color_added = false;
        orb.color_held = true;
        orb.color_consumed = true;
    }
}

trigger_spawn = function(guy) {
    if (cost_paid()) {
        spawn_bot(guy.my_player);
        reset_orbs();
    }
}

spawn_bot = function(player) {
    navgraph_command();
    var new_guy = create_npc_guy(x, y, player);
    with (new_guy) {
        event_perform(ev_step, ev_step_normal);
    }
    instance_create(x, y, spawn_effect_obj);
}