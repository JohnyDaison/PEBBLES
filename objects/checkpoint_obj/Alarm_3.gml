/// @description  DUPLICATION FOR GUIDE AND OTHER PLAYERS
if(duplicate_me && !is_duplicate)
{
    for_player = 1;
    
    show_debug_message("DUPLICATE CHECKPOINT");
    
    var i, total = gamemode_obj.player_count; 
    for(i = 0; i <= total; i++) 
    {
        if(i != for_player)
        {
            inst = instance_create(x,y, object_index);
            inst.for_player = i;
            
            if(i == 0)
            {
                inst.holographic = true;
            }
            inst.is_duplicate = true;
            inst.invisible = self.invisible;
        }
    }
}

