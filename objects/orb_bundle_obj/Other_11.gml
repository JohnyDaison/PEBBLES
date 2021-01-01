effect_create_above(ef_firework,x,y,1,tint);

var total_orbs = orb_count * stack_size;

for(var i=0; i < total_orbs; i++)
{
	var xx = random(16) - 8;
    var yy = random(16) - 8;
    
    var orb = instance_create(x, y, color_orb_obj);
    orb.my_color = my_color;
    orb.color_added = true;
    orb.airborne = true;
}
