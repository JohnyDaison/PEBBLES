/// @description INTRODUCTION
event_inherited();

// INTRODUCTION
if(!introduction_finished)
{
    with(player_obj)
    {
        if(self.id != gamemode_obj.environment && instance_exists(my_guy))
        {
            // DON'T MOVE
            my_guy.locked = true;
            
            // SAY HELLO
            /*
            if(!my_guy.speaking && !my_guy.has_spoken && !instance_exists(speech_popup_obj) && instance_exists(other.my_guy)
            && instance_exists(my_camera) && abs(my_camera.zoom_level - my_camera.normal_zoom) < 0.1)
            {
                with(my_guy)
                {
                    speech_start("tut_guide/hello_guide", true);   
                }
            }*/
        }
    }
    
    // INTRO ENDS WHEN GUIDE SPEAKS
    if(instance_exists(my_guy) && my_guy.speaking)
    {
        introduction_finished = true;
        with(player_obj)
        {
            if(self.id != gamemode_obj.environment && instance_exists(my_guy))
            {
                my_guy.has_spoken = false;
            }
        }
    }
}
    