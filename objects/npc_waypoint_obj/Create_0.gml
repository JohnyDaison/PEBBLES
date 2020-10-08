event_inherited();

waypoint_id = "";
in_group = false;
walljump_point = false;
wallclimb_point = false;
dive_point = false;
jump_pad_point = false;
fullstop_point = false;
spawn_point = false;
cannon_point = false;
flyby_point = false;
airborne = false;
autospeak = false;
teleport_from_me = false;
teleport_to_me = false;
dont_teleport_to_me = false;
grab_attention = false;
wait_for_player = false;
auto_adjust = true;
invisible = true; // true
visible = !invisible;
connect_to = "";
one_way_connect_from = "";
one_way_connect_to = "";
side_attached = false;
side_terrain = noone;
moving = false;
dragged = false;

chunk_register(chunkgrid_obj, id);