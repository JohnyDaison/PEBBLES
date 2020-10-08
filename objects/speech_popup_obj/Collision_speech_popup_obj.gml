/*
if(debug_mode)
{
    show_debug_message("Speech popup collision");
}
*/

if( (y < other.y || ( y == other.y && id < other.id ) )
    && fading && other.fading)
{
    var higher = id;
    var lower = other.id;
    
    with(lower)
    {
        //rise_speed = min(rise_speed, higher.rise_speed);
        rise_speed = higher.rise_speed;
        
        var old_fade_length = max_alpha_length + fade_out_length;
        fade_out_length = floor(fade_out_dist/rise_speed);
        alarm[0] = floor((max_alpha_length + fade_out_length)*(alarm[0]/old_fade_length));
        
    }
    
    higher.y -= ceil(2*rise_speed) + 1;
}

if(fading && !other.fading)
{
    var skip_steps = 2;
    if(alarm[0] > skip_steps)
    {
        alarm[0] -= skip_steps;
        y -= skip_steps * rise_speed;
    }
}