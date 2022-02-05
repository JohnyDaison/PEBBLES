function npc_guy2_init() {
    is_general_npc = true;

    npc_destination_x = x;
    npc_destination_y = y;
    npc_destination = noone;
    npc_last_destination = noone;
    npc_destination_reached = true;
    npc_last_destination_x = npc_destination_x;
    npc_last_destination_y = npc_destination_y;

    npc_waypoint_idle_range = 32;
    npc_waypoint_jump_range = 64;
    npc_waypoint_flyby_range = 96;
    npc_jump_dist = 256;
    npc_last_waypoint = "";
    npc_last_waypoint_obj = noone;
    nearest_waypoint = noone;
    npc_waypoint = "";
    npc_final_waypoint = "";
    npc_waypoint_reached = false;
    npc_waypoint_x = npc_destination_x;
    npc_waypoint_y = npc_destination_y;
    last_waypoint_change = 0;
    destination_mode = false;
    cannot_see_waypoint = false;
    npc_last_find_path = 0;
    npc_find_path_wait_time = 10;

    npc_progress_dir_x = 0;
    npc_progress_dir_y = 0;

    npc_wanna_run = false;
    npc_wanna_jump = false;
    npc_wanna_climb = false;
    npc_wanna_walljump = false;
    npc_wanna_walk = false;
    npc_wanna_rest = false;

    npc_running = false;
    npc_walking = false;
    npc_resting = false;

    npc_walk_start = 0;
    npc_walk_speed = 1;
    npc_walk_time = 120;

    npc_rest_start = 0;
    npc_rest_time = 120;

    npc_wallhold_start = 0;
    npc_wallhold_time = walljump_grace;
    npc_wallturn_time = npc_wallhold_time/2;

    npc_last_stuck_check = 0;
    npc_stuck_check_delay = 150;
    npc_stuck_dist = 16;
    npc_stuck_start = 0;
    npc_stuck = false;
    npc_stuck_x = 0;
    npc_stuck_y = 0;
    npc_stuck_wanna_run = false;
    npc_stuck_facing_right = false;
    npc_unstuck_done = false;

    npc_counter_confusion = false;
    npc_counter_confusion_start = -1;
    npc_confusion_start_delay = 60;
    npc_confusion_stop_delay = 60;
}
