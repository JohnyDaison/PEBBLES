event_inherited();

with(npc_waypoint_obj)
{
    if(waypoint_id != "dive_jump/success" && waypoint_id != "dive_bottom2")
    {
        auto_adjust = false;
    }
}