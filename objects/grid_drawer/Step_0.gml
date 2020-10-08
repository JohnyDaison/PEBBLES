left_bound = max(floor(__view_get( e__VW.XView, 0 )/32)*32,place_obj.x);
right_bound = min(ceil((__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 ))/32)*32,place_obj.x + place_obj.width);
top_bound = max(floor(__view_get( e__VW.YView, 0 )/32)*32,place_obj.y);
bottom_bound = min(ceil((__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 ))/32)*32,place_obj.y + place_obj.height);

