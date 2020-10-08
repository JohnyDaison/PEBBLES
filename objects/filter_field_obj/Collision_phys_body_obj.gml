if(other.my_color != my_color && collision_rectangle(x1-other.hspeed, y1-other.vspeed,
                                     x2-other.hspeed, y2-other.vspeed, other.id, false, true))
{
    if(other.speed > speedlimit) {
        other.speed *= 0.8;
    }
    
    var oldxdiff = other.xprevious - x;
    var oldydiff = other.yprevious - y;
    var xdiff = (other.x + other.hspeed) - x;
    var ydiff = (other.y + other.vspeed) - y;
    var leftdiff   =  (other.bbox_right + other.hspeed) - x1;
    var rightdiff  =  (other.bbox_left + other.hspeed) - x2;
    var topdiff    =  (other.bbox_bottom + other.vspeed) - y1;
    var bottomdiff =  (other.bbox_top + other.vspeed) - y2;
    var boost_coef = 1;
    var hboost = 0;
    var vboost = 0;

    if(abs(leftdiff) < abs(rightdiff))
    {
        hboost = -boost_coef;
    }
    else
    {
        hboost = boost_coef;
    }
    
    if(abs(topdiff) < abs(bottomdiff))
    {
        vboost = -boost_coef;
    }
    else
    {
        vboost = boost_coef;
    }
    
    if(sign(oldxdiff) != sign(xdiff) && abs(other.hspeed) > speedlimit)
    {
        other.x = other.xprevious;
        other.hspeed = 0;
        hboost *= -1;
    }
    
    if(sign(oldydiff) != sign(ydiff) && abs(other.vspeed) > speedlimit)
    {
        other.y = other.yprevious;
        other.vspeed = 0;
        vboost *= -1;
    }
    
    if(sign(oldydiff) == -1 && sign(topdiff) == 1)
    {
        vboost -= (other.gravity+other.friction);
    }

    with(other)
    {
        if(object_is_ancestor(object_index, guy_obj))
        {
            if(abs(topdiff) > 2)
            {
                holding_wall = false;
            }
            
            if(air_dashing)
            {
                lost_control = true;
                front_hit = true;
            }
            
            if(max_doublejumps > 0 && doublejump_count == max_doublejumps)
            {
                doublejump_count--;
            }
        }
        
        if(!place_meeting(x+hspeed+hboost, y, terrain_obj)) {
             hspeed += hboost;
        }
        if(!place_meeting(x, y+vspeed+vboost, terrain_obj)) {
             vspeed += vboost;
        }
    }
}

