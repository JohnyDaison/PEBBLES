event_inherited();

// BLINK
if(blink_step < blink_time)
{
    blink_step++;
    self.alpha = self.orig_alpha;
    if(blink_step <= blink_peak)
    {
        blink_ratio = blink_step/blink_peak;
    }
    if(blink_step > blink_peak)
    {
        blink_ratio = 1 - (blink_step - blink_peak)/(blink_time - blink_peak);
    }
    self.bg_color = merge_color(self.orig_bg_color, self.blink_color, blink_ratio);
}

// SLIDE
slide_step++;
if(slide_step > slide_time)
{
    if(x > side_x)
    {
        x -= move_speed;
        if(x < side_x)
        {
            x = side_x;
        }
    }
}

// FADEOUT
if(fadeout_step < fadeout_time)
{
    fadeout_step++;   
    
    self.alpha = min(1,2 - 2*fadeout_step/fadeout_time);
    if(self.alpha <= 0)
    {
        message = "";
        fadeout_step = fadeout_time;
        self.alpha = 0;
    }
}

// MESSAGE
if(message == "")
{
    instance_destroy();
    exit;
}

with(item_description_overlay)
{
    if(other.id != id && (other.birth_step > birth_step) && abs(other.y - y) <= height + margin)
    {
        y += move_speed;       
    }
}

