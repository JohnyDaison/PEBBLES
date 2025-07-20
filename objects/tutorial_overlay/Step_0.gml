event_inherited();

if(blink_step < blink_time)
{
    var blink_ratio;
    blink_step++;
    
    if(blink_step <= blink_peak)
    {
        blink_ratio = blink_step/blink_peak;
    }
    else
    {
        blink_ratio = 1 - (blink_step - blink_peak)/(blink_time - blink_peak);
    }
    
    self.alpha = self.orig_alpha;
    self.bg_color = merge_color(self.orig_bg_color, self.blink_color, blink_ratio);
}

if(fadeout_step < fadeout_time)
{
    fadeout_step++;   
    
    self.alpha = 1 - fadeout_step/fadeout_time;
    if(self.alpha <= 0)
    {
        message = "";
        fadeout_step = fadeout_time;
        self.alpha = 0;
    }
}

if(message == "")
{
    self.cur_message_step = 0;
}
else
{
    self.cur_message_step += 1;
}
