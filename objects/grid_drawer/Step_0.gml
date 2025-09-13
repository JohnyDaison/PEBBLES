var viewCamera = view_get_camera(0);
var viewX = camera_get_view_x(viewCamera);
var viewY = camera_get_view_y(viewCamera);
var viewWidth = camera_get_view_width(viewCamera);
var viewHeight = camera_get_view_height(viewCamera);

left_bound = max(floor(viewX / 32) * 32, place_obj.x);
right_bound = min(ceil((viewX + viewWidth) / 32) * 32, place_obj.x + place_obj.width);
top_bound = max(floor(viewY / 32) * 32, place_obj.y);
bottom_bound = min(ceil((viewY + viewHeight) / 32) * 32, place_obj.y + place_obj.height);
