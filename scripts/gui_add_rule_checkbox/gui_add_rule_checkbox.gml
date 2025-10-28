/// @description gui_add_rule_checkbox(xx, yy, gmrule_id, [size])
/// @function gui_add_rule_checkbox
/// @param xx
/// @param yy
/// @param gmrule_id
/// @param [size]
function gui_add_rule_checkbox() {
    var xx,yy,ii, size, gmrule_id, gmmod;

    xx = argument[0];
    yy = argument[1];
    gmrule_id = argument[2];

    ii = gui_add_checkbox(0, 0);
    size = ii.width;

    if(argument_count > 3)
    {
        size = argument[3];
        ii.height = size;
        ii.width = size;
    }

    gmmod = DB.gamemode_rules[? gmrule_id];

    ii.unchecked_icon = gmmod[? "icon"];
    ii.checked_icon = gmmod[? "icon"];
    //ii.tooltip = gmmod[? "name"];
    ii.gmrule_id = gmrule_id;

    ii.unchecked_bg_color = merge_color(c_black, c_dkgray, 0.5);
    ii.unchecked_icon_color = c_dkgray;
    ii.checked_bg_color = merge_color(c_black, c_white, 0.98);
    ii.center_icon = true;
    ii.thick_border_size = 4;

    ii.centered = true;
    ii.onmouseover_script = rule_chb_onmouseover_script;
    ii.onmouseleave_script = rule_chb_onmouseleave_script;

    ii.get_value = method(ii, function() {
        return checked;
    });

    return ii;
}
