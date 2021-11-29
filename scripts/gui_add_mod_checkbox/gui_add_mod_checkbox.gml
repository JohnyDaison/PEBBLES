/// @description gui_add_mod_checkbox(xx, yy, gmmod_id, [size])
/// @function gui_add_mod_checkbox
/// @param xx
/// @param yy
/// @param gmmod_id
/// @param [size]
function gui_add_mod_checkbox() {
    var xx,yy,ii, size, gmmod_id, gmmod;

    xx = argument[0];
    yy = argument[1];
    gmmod_id = argument[2];

    ii = gui_add_checkbox(0, 0);
    size = ii.width;

    if(argument_count > 3)
    {
        size = argument[3];
        ii.height = size;
        ii.width = size;
    }

    gmmod = DB.gamemode_mods[? gmmod_id];

    ii.unchecked_icon = gmmod[? "icon"];
    ii.checked_icon = gmmod[? "icon"];
    //ii.tooltip = gmmod[? "name"];
    ii.gmmod_id = gmmod_id;

    ii.unchecked_bg_color = merge_color(c_black, c_dkgray, 0.5);
    ii.unchecked_icon_color = c_dkgray;
    ii.checked_bg_color = merge_color(c_black, c_white, 0.98);
    ii.center_icon = true;
    ii.thick_border_size = 3;

    ii.centered = true;
    ii.onmouseover_script = mod_chb_onmouseover_script;
    ii.onmouseleave_script = mod_chb_onmouseleave_script;

    ii.get_value = method(ii, function() {
        return checked;
    });

    return ii;
}
