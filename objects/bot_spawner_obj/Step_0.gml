event_inherited();

ds_list_clear(guys);
instance_place_list(x, y, guy_obj, guys, false);
var guy_count = ds_list_size(guys);
var sound_played = false;

for(var index = 0; index < guy_count; index++) {
    var guy = guys[| index];
    if (guy.speed > 0 || guy.lost_control || guy.protected) {
        continue;
    }
    
    for(var color = g_red; color <= g_blue; color++)
    {
        if(color == g_yellow) continue;
            
        if(guy.orb_reserve[? color] >= 1 && add_orb(color)) {
            guy.orb_reserve[? color] -= 1;
                
            if(!sound_played)
            {
                my_sound_play(slot_absorbed_sound);
                sound_played = true;
            }
        }
    }
}
