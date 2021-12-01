function goto_arena() {
    DB.player_num = 0;
    if(instance_exists(gamemode_obj))
    {
        room_goto(gamemode_obj.world.current_place.room_id);
    }
}
