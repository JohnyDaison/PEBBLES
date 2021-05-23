/// @description  DARK FIELD TRAIL
field = instance_create(x,y, black_force_field_obj);
field.field_power = 0.2;
field.radius = radius*min(1,force_used/force);
field.temporary = true;
field.holographic = holographic;
field.my_player = my_player;
field.my_guy = my_guy;

alarm[2] = trail_delay;
