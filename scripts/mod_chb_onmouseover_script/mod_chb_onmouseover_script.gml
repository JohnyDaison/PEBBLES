function mod_chb_onmouseover_script() {
    var gmmod = DB.gamemode_mods[? self.gmmod_id];

    var window = mod_tooltip_window;
    var icon_label = window.mod_icon_label;
    var name_label = window.mod_name_label;
    var description_label = window.mod_description_label;

    var state_str = "";

    icon_label.icon = gmmod[? "icon"];
    //icon_label.enabled_icon_color = enabled_icon_color;
    icon_label.bg_color = checked_bg_color;

    name_label.text = gmmod[? "name"];
    switch(gmmod[? "type"])
    {
        case "bool":
            if(checked)
                state_str = "(On)";
            else
                state_str = "(Off)";
            break;
    }

    if(state_str != "")
    {
        name_label.text += state_str;
    }

    description_label.text = gmmod[? "description"];
    window.mod_button = id;

    gui_show_element(window);
}
