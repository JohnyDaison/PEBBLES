/// @description  UNTOUCHED STAT
if(!singleton_obj.paused)
{
    if(core == core_energy && cover == cover_none)
    {
        if(my_color == g_dark && damage == 0 && energy == 0)
        {
            gamemode_obj.stats[? "terrain_untouched_total"] += 1;
            //if(my_player != gamemode_obj.environment)
            //{
                increase_stat(my_player, "terrain_side_untouched", 1, false);
            //}
        }
    }
}
