var viewCamera = view_get_camera(view_current);
var viewX = camera_get_view_x(viewCamera);
var viewY = camera_get_view_y(viewCamera);

var portX = view_get_xport(view_current);
var portY = view_get_yport(view_current);

var redColor = make_color_rgb(255, 0, 0);
var greenColor = make_color_rgb(0, 255, 0);
var blueColor = make_color_rgb(0, 0, 255);

var showInverseFilterRectangle = false;

if (showInverseFilterRectangle && keyboard_check(vk_alt)) {
    var left_end = -0.5, right_end = 1.5;

    var xx = self.x + viewX - portX;

    var yy = self.y + viewY - portY;

    draw_set_color(c_white);
    draw_set_alpha(1);
    gpu_set_blendmode_ext(bm_inv_dest_color, bm_src_alpha_sat);
    draw_rectangle(xx + left_end * self.square_side, yy - self.square_side / 2, xx + right_end * self.square_side, yy + self.square_side / 2, false);
    gpu_set_blendmode(bm_normal);
}


if (keyboard_check(vk_alt)) {
    var left_end = -1.5, right_end = 0.5;

    var xx = x + viewX - portX;
    var yy = y + viewY - portY;

    // "main" lights
    draw_set_alpha(1);
    gpu_set_blendmode_ext(bm_dest_color, bm_one);
    draw_circle_color(xx - self.square_side, yy - self.square_side, 240, redColor, c_black, 0);
    draw_circle_color(xx + self.square_side, yy - self.square_side, 240, greenColor, c_black, 0);
    draw_circle_color(xx - self.square_side, yy + self.square_side, 240, blueColor, c_black, 0);

    xx += 3 * self.square_side;

    // "bloom?" lights
    draw_set_alpha(0.5);
    gpu_set_blendmode_ext(bm_src_alpha, bm_one);
    draw_circle_colour(xx - self.square_side, yy - self.square_side, 60, redColor, c_black, 0);
    draw_circle_color(xx + self.square_side, yy - self.square_side, 60, greenColor, c_black, 0);
    draw_circle_color(xx - self.square_side, yy + self.square_side, 60, blueColor, c_black, 0);

    xx -= 3 * self.square_side;
    yy += 3 * self.square_side;

    // color filters
    draw_set_alpha(1);
    gpu_set_blendmode_ext(bm_dest_color, bm_src_alpha_sat);
    draw_circle_color(xx - self.square_side, yy - self.square_side, 40, redColor, redColor, 0);
    draw_circle_color(xx + self.square_side, yy - self.square_side, 40, greenColor, greenColor, 0);
    draw_circle_color(xx - self.square_side, yy + self.square_side, 40, blueColor, blueColor, 0);

    // inverse filter
    draw_set_alpha(1);
    gpu_set_blendmode_ext(bm_inv_dest_color, bm_src_alpha_sat);
    draw_circle_color(xx + self.square_side, yy + self.square_side, 40, c_white, c_white, 0);

    xx += 3 * self.square_side;

    // "diffuse" lights
    draw_set_alpha(0.2);
    gpu_set_blendmode_ext(bm_inv_dest_color, bm_one);
    draw_circle_color(xx - self.square_side, yy - self.square_side, 160, redColor, c_black, 0);
    draw_circle_color(xx + self.square_side, yy - self.square_side, 160, greenColor, c_black, 0);
    draw_circle_color(xx - self.square_side, yy + self.square_side, 160, blueColor, c_black, 0);

    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}
