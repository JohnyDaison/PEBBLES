/*
i = instance_create(x,y-32,text_popup_obj);
i.str = message;
i.my_color = my_color;
i.tint_updated = false;
*/

if(instance_exists(my_guy) && my_guy != id)
{
    increase_stat(my_guy.my_player, "secrets_found", 1, false);
    increase_stat(my_guy.my_player, "score", 5, true);
    //battlefeed_post_string(my_guy.my_player, message);
    if(image != noone)
    {
        battlefeed_post_image(my_guy.my_player, image);
    }
    
    with(my_guy)
    {
        if(other.message != "")
        {
            speech_start("secret/read", true, other);
        }
        else if(other.description != "")
        {
            speech_start("secret/observe", true, other);
        }
        else if(other.comment != "")
        {
            speech_start("secret/comment", true, other);
        }
    }
}



