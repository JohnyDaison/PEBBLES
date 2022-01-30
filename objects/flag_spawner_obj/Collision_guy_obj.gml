/// @description Colision with guy
var guy = other;
var spawner = id;

var lose_flag = false;
var collect_flags = false;
var done = false;

if (has_flag && guy.my_player.team_number != my_team_number) {
    lose_flag = true;
} else if (guy.my_player.team_number == my_team_number) {
    collect_flags = true;
}

if (lose_flag || collect_flags) {
    for(var i=1; i <= guy.inventory_size && !done; i++)
    {
        var item = guy.inventory[? i];
            
        if (lose_flag && item == noone) {
            var flag = instance_create_layer(x,y, "Items", flag_obj);
            flag.my_team_number = my_team_number;
            flag.my_flag_spawner = spawner;
            flag.flag_icon = flag_icon;
            
            with(guy) {
                add_to_inventory(flag);
            }
            
            has_flag = false;
            my_sound_play(flag_spawner_lose_flag_sound);
            alarm[2] = 120;
            
            done = true;
        }
            
        if (collect_flags && instance_exists(item) && item.object_index == flag_obj) {
            if (item.my_flag_spawner == spawner) {
                with(guy) {
                    take_from_inventory(item);
                }
                instance_destroy(item);
                
            } else if (has_flag) {
                increase_stat(my_player, "score", flag_score, false);
                increase_stat(my_player, "flags_captured", 1, false);
                
                var score_str = stat_label("score", flag_score, "+");
                battlefeed_post_flag_capture(item, guy, score_str);
                
                my_sound_play(flag_captured_sound);
                
                with(guy) {
                    take_from_inventory(item);
                }
                instance_destroy(item);
            }
        }
    }
}