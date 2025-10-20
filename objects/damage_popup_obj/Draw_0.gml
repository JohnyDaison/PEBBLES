my_draw_set_font(label_font);
var dmg_str = "";

if(type == "paint_tool")
{
    dmg_str = "";
    fade_ratio = 1;
    if(instance_exists(source))
    {
        dmg_str += string(round(100*source.energy)) + "| ";
    }
    
    if(damage < 0)
    {
        dmg_str += "-";
    }
    else
    {
        dmg_str += "+";
    }
    
    dmg_str += string(round(100*abs(damage)));
}
else if(type == "energy_recharge")
{
    if(damage < 0)
    {
        dmg_str = "-";
    }
    else
    {
        dmg_str = "+";
    }
    
    dmg_str += string(round(100*abs(damage)));
}
else
{
    if(damage < 0)
    {
        dmg_str = "+"; // negative damage heals
    }
    
    dmg_str += string(round(100*abs(damage)));
}


half_width = string_width(dmg_str)/2 + 4;
half_height = string_height(dmg_str)/2 + 2;

draw_set_color(bg_color);
draw_set_alpha(bg_alpha * fade_ratio);
draw_roundrect(x-half_width,y-half_height, x+half_width,y+half_height, false);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(fade_ratio);
draw_set_color(makeTextOutlineColor(self.tint, true));

my_draw_text(x-1, y-1, dmg_str);
my_draw_text(x+1, y+1, dmg_str);
draw_set_color(tint);
my_draw_text(x, y, dmg_str);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

event_inherited();
