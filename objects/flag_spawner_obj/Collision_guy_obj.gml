/// @description Colision with guy
var guy = other;
var spawner = self.id;

var lose_flag = false;
var collect_flags = false;
var done = false;

if (spawner.has_flag && guy.my_player.team_number != spawner.my_team_number) {
    lose_flag = true;
} else if (guy.my_player.team_number == spawner.my_team_number) {
    collect_flags = true;
}

if (!lose_flag && !collect_flags) {
    exit;
}

for (var index = 1; index <= guy.inventory_size && !done; index++) {
    var item = guy.inventory[? index];

    if (lose_flag && item == noone) {
        var flag = instance_create_layer(spawner.x, spawner.y, "Items", flag_obj);

        flag.my_team_number = spawner.my_team_number;
        flag.my_flag_spawner = spawner;
        flag.flag_icon = spawner.flag_icon;

        with (guy) {
            add_to_inventory(flag);
        }

        spawner.has_flag = false;
        my_sound_play(flag_spawner_lose_flag_sound);
        spawner.alarm[2] = 120;

        done = true;
    }

    if (collect_flags && instance_exists(item) && item.object_index == flag_obj) {
        if (item.my_flag_spawner == spawner) {
            with (guy) {
                take_from_inventory(item);
            }
            instance_destroy(item);

        } else if (spawner.has_flag) {
            increase_stat(spawner.my_player, "score", spawner.flag_score, false);
            increase_stat(spawner.my_player, "flags_captured", 1, false);

            var score_str = stat_label("score", spawner.flag_score, "+");
            battlefeed_post_flag_capture(item, guy, score_str);

            spawner.captured_flag_icon = item.flag_icon;
            spawner.captured_flag_player = item.my_flag_spawner.my_player;
            spawner.captured_anim_phase = 0;

            my_sound_play(flag_captured_sound);

            with (guy) {
                take_from_inventory(item);
            }

            instance_destroy(item);
        }
    }
}
