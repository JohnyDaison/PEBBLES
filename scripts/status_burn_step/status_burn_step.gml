function status_burn_step() {
    var burn = DB.status_effects[? "burn"];

    if(status_left[? "frozen"] > 0)
    {
        status_left[? "frozen"] -= 1;
    }
    else
    {
    
        var dmg = burn.tick_damage; //* (0.5+(self.status_left[? "burn"] / burn.max_charge)) 
        self.damage += dmg;
    
        // DAMAGE POPUP
        if(!instance_exists(burn_popup))
        {
            burn_popup = create_damage_popup(dmg, g_red, id, "burn");
            burn_popup.visible = false;
        }
        else
        {
            with(burn_popup)
            {
                x = other.x;
                y = other.y;
                damage += dmg;
                fade_ratio = 0.6;
                alarm[0] = life_length - fade_in_length;
                //alarm[1] = 2;
            }
        }
        if (my_player.my_guy == id) {
            my_player.burn_dmg_total += dmg;
        }
    }
}
