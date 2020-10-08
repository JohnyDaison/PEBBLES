near_gate = instance_nearest(x,y,gate_obj);
if(near_gate == noone || !(near_gate.x == x && near_gate.y == y))
{
    near_gate = instance_create(x,y, gate_obj);
}

near_gate.enabled[? round(image_angle/90)] = true;

instance_destroy();

