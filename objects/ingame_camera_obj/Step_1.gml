event_inherited();

if (source_cam == noone) {
    var pl = gamemode_obj.players[? for_player];
    var big_cam = pl.my_camera;
    
    if (instance_exists(big_cam)) {
        source_cam = big_cam.id;
        my_player = source_cam.my_player;
    }
}
