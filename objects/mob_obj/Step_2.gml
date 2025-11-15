///@description ROTATION AND DEATH

self.image_angle += self.rotation_speed;
self.image_angle = self.image_angle mod 360;

if (self.done_for) {
    var la_player = self.last_attacker_map[? "player"];
    var what = self.last_attacker_map[? "source"];
    var who = self.last_attacker_map[? "source_id"];

    if (instance_exists(la_player)) {
        var full_score = false;
        var score_value = self.my_score_value;
        var score_str = "";
        var is_la_player_guy = false;

        if (instance_exists(who)) {
            is_la_player_guy = who == who.my_player.my_guy;
        }

        if (is_la_player_guy) {
            full_score = true;
            increase_stat(la_player, "mobs_killed_by_guy", 1, false);

            if (self.object_index == sprinkler_body_obj) {
                increase_stat(la_player, "sprinklers_killed_by_guy", 1, false);
            }
            else if (self.object_index == spitter_body_obj) {
                increase_stat(la_player, "spitters_killed_by_guy", 1, false);
            }
            else if (self.object_index == slime_mob_obj) {
                increase_stat(la_player, "slimes_killed_by_guy", 1, false);
            }
        }

        if (!full_score) {
            score_value = floor(score_value * 0.5);
        }

        if (la_player != self.my_player) {
            score_str = stat_label("score", score_value, "+");

            increase_stat(la_player, "score", score_value, false);
        }

        battlefeed_post_destruction(self.id, self.last_attacker_map, score_str);

        increase_stat(la_player, "mobs_killed_total", 1, false);

        if (self.object_index == sprinkler_body_obj) {
            increase_stat(la_player, "sprinklers_killed_total", 1, false);
        }
        else if (self.object_index == spitter_body_obj) {
            increase_stat(la_player, "spitters_killed_total", 1, false);
        }
        else if (self.object_index == slime_mob_obj) {
            increase_stat(la_player, "slimes_killed_total", 1, false);
        }

        var params = create_params_map();
        params[? "who"] = self.last_attacker_map[? "source_id"];
        params[? "who_player"] = la_player;

        broadcast_event("object_destroy", self.id, params);
    }

    var dir = 90;
    repeat(self.ammo_drop_count)
    {
        var xx = lengthdir_x(self.radius + 32, dir);
        var yy = lengthdir_y(self.radius + 32, dir);
        var inst = instance_create(self.x + xx, self.y + yy, color_orb_obj);

        inst.direction = dir;
        inst.speed = 2;
        inst.my_color = choose(g_red, g_green, g_blue);
        inst.my_guy = inst.id;
        inst.airborne = true;
        inst.color_added = true;

        dir += 360 / self.ammo_drop_count;
    }

    repeat(crystal_drop_count) {
        var xx = lengthdir_x(self.radius + 32, dir);
        var yy = lengthdir_y(self.radius + 32, dir);
        var inst = instance_create(self.x + xx, self.y + yy, crystal_obj);

        inst.direction = dir;
        inst.speed = 2;
        inst.my_color = choose(g_red, g_green, g_blue);
        inst.my_guy = inst.id;

        dir += 360 / self.crystal_drop_count;
    }

    if (instance_exists(self.drop_item)) {
        var item = self.drop_item;

        item.collected = false;
        item.my_guy = item.id;
        item.airborne = true;
        item.invisible = false;

        // A BIT OF MOVEMENT
        var xx = random(6) - 3;
        var yy = random(6) - 3;

        if (abs(xx) < 1) {
            xx = sign(xx);
        }

        if (abs(yy) < 1) {
            yy = sign(yy);
        }

        item.xprevious = self.x;
        item.yprevious = self.y;
        item.x = self.x + xx * 5;
        item.y = self.y + yy * 5;
        item.hspeed = xx / 2;
        item.vspeed = yy / 2;
    }

    instance_destroy();
    exit;
}

// RESET ATTACKER AFTER TIME
if (self.last_attacker_map[? "player"] != noone && (singleton_obj.step_count - self.last_attacker_map[? "step"]) > self.att_forget_delay) {
    last_attacker_reset();
}

event_inherited();
