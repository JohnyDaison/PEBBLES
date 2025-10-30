/// @self guy_spawner_obj | level_start_obj
/// @param {Id.Instance} player Description
function create_player_things(player) {
    var new_guy = noone;
    var RuleID = global.RuleID;

    // CREATE SPAWN POINT
    guy_spawn_point_create(self.id, player, true);

    var last_human = gamemode_obj.last_human_player;
    var has_view = !player.is_cpu; // human

    // less than 2 humans, first 2 players
    if (!has_view) {
        has_view = gamemode_obj.human_player_count < 2 && player.number <= 2
                    && (last_human == 0 || player.team_number != gamemode_obj.players[? last_human].team_number);
    }

    // more than 2 humans
    if (!has_view) {
        has_view = gamemode_obj.human_player_count > 2;
    }

    var player_camera = noone;

    if (has_view) {
        // CREATE CAMERA
        var inst = instance_create(self.x, self.y, player_camera_obj);

        inst.on = true;
        player_camera = inst;
        player_camera.view = ds_list_size(main_camera_obj.player_view_list) + 1; // first unused view
        if (gamemode_obj.human_player_count > 2) {
            player_camera.view = player.number;
        }

        player_camera.depth -= player_camera.view; // is this needed?

        main_camera_obj.add_player_camera(player_camera);

        if (gamemode_obj.player_count == 1) {
            player_camera.only_cam = true;
        }

        player_camera.my_spawner = self.id;
        player_camera.follow_spawner = true;
        player_camera.player = player.number;
        player_camera.my_player = player;
        player_camera.zoom_level = player_camera.min_zoom;

        player.my_camera = player_camera;
    }

    player.my_spawner = id;
    player.my_base = id;

    // GUY
    if (player.is_cpu) {
        new_guy = create_npc_guy(self.x, self.y, player);

        with (new_guy) {
            self.difficulty = player.cpu_difficulty;
            self.bot_speed = self.difficulty;
            self.bot_complexity = self.difficulty;
            self.bot_aggressiveness = self.difficulty;

            if (self.object_index == guy_spawner_obj) // it's about match vs campaign, not the object
            {
                self.bot_activation_distance *= 10;
                self.bot_deactivation_distance *= 20;
            }
            else {
                self.bot_activation_distance *= 5;
                self.bot_deactivation_distance *= 10;
            }

            self.draw_label = false;
        }
        player.title = "CPU" + string(player.number);
    }
    else {
        new_guy = instance_create(self.x, self.y, player_guy);
        player.title = "P" + string(player.number);
    }

    self.my_guy = new_guy;

    new_guy.my_player = player;
    new_guy.my_spawner = self.id;
    new_guy.my_base = self.id;

    // select skin based on flag for now
    if (new_guy.my_player.flag == "racing_flag") {
        new_guy.my_skin = DB.guy_skins[? "biker"];
    }

    new_guy.name = player.name;
    new_guy.control_set = player.control_set;
    new_guy.control_index = player.control_index;
    player.my_guy = new_guy;

    if (!rule_get_state(RuleID.DarkColor)) {
        new_guy.my_color = g_red;
        new_guy.potential_color = new_guy.my_color;
        new_guy.tint_updated = false;
        new_guy.slots_absorbed = 1;
    }

    new_guy.min_damage = player.handicaps[? "min_damage"];
    new_guy.damage = new_guy.min_damage;

    // CHARGEBALL
    guy_provide_chargeball(new_guy);

    instance_create(self.x, self.y, spawn_effect_obj);

    if (has_view) {
        // SET UP CAMERA

        player_camera.my_guy = new_guy.id;
        player_camera.follow_guy = true;
        player_camera.follow_spawner = false;

        // OVERLAYS
        if (gamemode_obj.mode != "volleyball" || player.number <= 2) {
            add_player_overlay(healthbar_overlay, player);
        }

        if (!gamemode_obj.no_inventory)
            add_player_overlay(inventory_overlay, player);
        add_player_overlay(overhead_overlay, player);
        if (rule_get_state(RuleID.TutorialOverlay) && !player.is_cpu)
            add_player_overlay(tutorial_overlay, player);
        add_player_overlay(status_effect_overlay, player);
        add_player_overlay(radial_overlay, player);
        player.battlefeed = add_player_overlay(battlefeed_overlay, player);
    }

    var inst = instance_create(self.x, self.y, name_plate_window);
    inst.my_guy = new_guy.id;
}
