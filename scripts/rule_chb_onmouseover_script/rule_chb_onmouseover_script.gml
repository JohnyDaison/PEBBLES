function rule_chb_onmouseover_script() {
    var gmmod = DB.gamemode_rules[? self.gmrule_id];

    var window = rule_tooltip_window;
    var icon_label = window.rule_icon_label;
    var name_label = window.rule_name_label;
    var description_label = window.rule_description_label;

    var state_str = "";

    icon_label.icon = gmmod[? "icon"];
    //icon_label.enabled_icon_color = enabled_icon_color;
    icon_label.bg_color = checked_bg_color;

    name_label.text = gmmod[? "name"];
    
    if(checked)
        state_str = "(On)";
    else
        state_str = "(Off)";

    if(state_str != "")
    {
        name_label.text += state_str;
    }

    description_label.text = gmmod[? "description"];
    window.rule_button = id;

    gui_show_element(window);
}
