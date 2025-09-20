/// @param {Real} color
function color_to_components(color) {
    var comp = [];

    comp[g_red] = sign(color & g_red);
    comp[g_green] = sign(color & g_green);
    comp[g_blue] = sign(color & g_blue);

    num_colors_used = comp[g_red] + comp[g_green] + comp[g_blue];

    if (num_colors_used == 0) {
        comp[g_dark] = 1;
        num_colors_used = 1;
    }
    else {
        comp[g_dark] = 0;
    }

    return comp;
}
