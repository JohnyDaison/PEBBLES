function drop_inv_item(index) {
    if(index > 0)
    {
        var item = self.inventory[? index];
        if(instance_exists(item))
        {
            var count = item.stack_size;
            if(count > 0 && !item.keep_on_death)
            {
                item = take_from_inventory(item, count);
                item.collected = false;
                item.my_guy = item.id;
                item.airborne = true;
                item.invisible = false;
            
                // A BIT OF MOVEMENT
                var xx = random(6)-3;
                var yy = random(6)-3;
            
                if(abs(xx) < 1)
                    xx = sign(xx);
                if(abs(yy) < 1)
                    yy = sign(yy);
                
                item.xprevious = x;
                item.yprevious = y;
                item.x = x + xx*5;
                item.y = y + yy*5;
                item.hspeed = xx/2;
                item.vspeed = yy/2;
            }
            
            item.newly_dropped_steps = item.newly_dropped_duration;
            item.newly_dropped_guy = id;
            
            return item;
        }
    }
    
    return noone;
}
