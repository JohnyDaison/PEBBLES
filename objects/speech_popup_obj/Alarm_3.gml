/// @description CREATE SPLIT POPUP
//y -= (height - line_offset);
if(!interrupted)
{
    with(source)
    {
        var i = instance_create(x, bbox_top - 64, speech_popup_obj);
        i.str = other.next_str;
        i.my_color = speech_color;    
        i.source = id;
        i.y_offset = (bbox_top - 64) - y;
                
        speech_popup = i;
    }
}