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
        dial.enabled = false;
        dial.had_focus = false;
    }
    up_arrow.enabled = (self.enabled && visible && self.value < self.max_value);
    down_arrow.enabled = (self.enabled && visible && self.value > self.min_value);
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
        self.value = cur_sign*dial.value;
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
/*
old_plus_state = plus_but.enabled;
old_minus_state = minus_but.enabled;

plus_but.enabled = self.enabled && sign(value) == -1;
minus_but.enabled = self.enabled && sign(value) == 1;

if(old_plus_state != plus_but.enabled)
{
    plus_but.depressed = old_plus_state;
}

if(old_minus_state != minus_but.enabled)
{
    minus_but.depressed = old_minus_state;
}

plus_but.icon_alpha = 0.5 + 0.5*(sign(!plus_but.enabled));
minus_but.icon_alpha = 0.5 + 0.5*(sign(!minus_but.enabled));
*/
