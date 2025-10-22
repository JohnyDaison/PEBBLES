event_inherited();

// TERRAIN LIST
if (self.terrain_col_done) {
    exit;
}

self.terrain_col_done = true;

if (self.holographic || !instance_exists(self.my_guy)) {
    exit;
}

var dashwave = id;

for (var i = 0; i < self.my_guy.ter_list_length; i++) {
    var terrainBlock = self.my_guy.ter_list[| i];

    if (!instance_exists(terrainBlock)) {
        continue;
    }
    
    with (terrainBlock) {
        if (terrainBlock.object_index != wall_obj || !place_meeting(terrainBlock.x, terrainBlock.y, dashwave)) {
            continue;
        }
        
        var shield = instance_place(terrainBlock.x, terrainBlock.y, shield_obj);

        if (shield != noone && shield.my_player != dashwave.my_player) {
            continue;
        }
        
        var matchingColor = terrainBlock.my_color == dashwave.my_color && terrainBlock.my_color != g_octarine;
        var blockHasMoved = terrainBlock.xstart != terrainBlock.x || terrainBlock.ystart != terrainBlock.y;
        
        if (matchingColor && blockHasMoved) {
            continue;
        }

        if (!dashwave.wallhit_played) {
            my_sound_play(shot_wallhit_sound);
            //my_sound_play_colored(shot_wallhit_sound, dashwave.my_color);
            dashwave.wallhit_played = true;
        }

        var power_ratio = get_power_ratio(terrainBlock.my_color, dashwave.my_color);
        
        if (power_ratio == 0) {
            continue;
        }

        var body_dmg = dashwave.force * power_ratio;

        terrainBlock.my_next_color = dashwave.my_color;
        terrainBlock.damage += body_dmg;
        terrainBlock.scale_buffer += body_dmg;
        terrainBlock.energy += abs(body_dmg);

        terrainBlock.last_dmg = body_dmg;

        if ((body_dmg > 1.5 || (terrainBlock.unstable && body_dmg > 0.5)) && terrainBlock.cover != cover_indestr) {
            terrainBlock.falling = true;
        }

        if (body_dmg != 0) {
            last_attacker_update(dashwave, "body", "damage");
            create_damage_popup(body_dmg, dashwave.my_color, terrainBlock.id);
        }
    }
}
