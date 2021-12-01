if(instance_exists(dial))
{
    if(enabled && visible && !dial.enabled)
    {
        dial.had_focus = true;
    }
    dial.enabled = self.enabled;
    dial.tooltip = self.tooltip;
    if(dial.value == self.min_value && self.min_value == self.max_value)
    {
        locked = true;
        dial.had_focus = false;
    }
    minus_box.enabled = (self.enabled && visible && min_value < 0);
    minus_box.visible = visible && minus_box.enabled;
    
    if(!dial.active)
    {
        if(cur_sign*dial.value > self.max_value)
        {
            dial.value = abs(self.max_value);
            cur_sign = sign(self.max_value);
        }
        if(cur_sign*dial.value < self.min_value)
        {
            dial.value = abs(self.min_value);
            cur_sign = sign(self.min_value);
        }
        self.value = cur_sign * dial.value;
        if (self.value != last_value) {
            script_execute(self.onchange_script);
        }
        last_value = self.value;
    }
    if(value == 0)
    {
        cur_sign = 1;
    }
    if(sign(cur_sign) == -1)
    {
        minus_box.text = "-";
    }
    else
    {
        minus_box.text = "";
    }
}
