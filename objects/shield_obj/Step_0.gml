///@description:  STATS, DESTRUCTION, REPULSION, UBERSHIELD
event_inherited();

// COPY STATS
if(instance_exists(my_guy) && my_guy != id)
{
    invisible = my_guy.invisible;
    holographic = my_guy.holographic;
    overcharge = my_guy.shield_overcharge;
    chargerate = my_guy.shield_chargerate;
    regenrate = 2*chargerate;
    collapse_threshold = my_guy.shield_threshold;
    
    cur_step = charge_step * regenrate;
    threshold = max_charge + overcharge;
    diff = threshold - charge;
}
else
{
    cur_step = charge_step * chargerate;
    threshold = max_charge + overcharge;
    diff = 1;
}


// DETECT DESTRUCTION
if(my_guy == id && charge >= threshold)
{
    done_for = true;
}
else if(my_guy != id && charge > collapse_threshold || charge <= 0)
{
    done_for = true;
    collapsed = true;
}


// TODO: ADD ORB DRAIN HERE
if(!done_for && !channeled)
{
    if(diff < 0 && my_guy != id)
    {
        cur_step = charge_step*faderate;
    }
    
    charge += sign(diff)*cur_step;
    
    if(abs(diff) < cur_step)
    {
        charge = threshold;
    }
}
channeled = false;

energy = charge;

if(!instance_exists(my_guy))
{
    instance_destroy();
    exit;
}

if(!instance_exists(gamemode_obj))
{
    instance_destroy();
    exit;
}

// APPLY DESTRUCTION
if(done_for)
{
    instance_destroy();
    exit;
}

if(!rule_get_state("shield_push") && my_guy != id) {
    exit;
}

var body, is_guy;
var shield = id;

// PHYS BODY REPULSION
with(phys_body_obj)
{
    if(holographic == other.holographic && !self.protected)
    {
        with(shield)
        { 
            body = collision_circle(x,y,radius,other.id,false,true);
            is_guy = object_is_child(other.id, guy_obj);
            
            if(instance_exists(body))
            {
                if(iff_check("shield_will_push_me", body, id)) //  body.my_player != my_guy.my_player
                {
                    if(is_guy && body.has_tped)
                    {
                        //body.speed = 0;
                        body.x = body.pre_tp_x;
                        body.y = body.pre_tp_y;
                        body.last_x = body.x;
                        body.last_y = body.y;
                        body.has_tped = false;
                        body.abi_cooldown[? g_blue] = body.blocked_tp_cooldown;
                    }
                    else if(!is_guy || !(instance_exists(body.my_spawner) 
                                    && object_is_child(body.my_spawner, guy_spawner_obj) 
                                    && body.locked && body.my_spawner.activated))
                    {
                        with(body)
                        {
                            last_attacker_update(other.id, "body", "push");
                        }
                        
                        var orig_h = body.hspeed;
                        var orig_v = body.vspeed;
                        apply_force(body,true);
                        if(!body.airborne && orig_v == 0)
                        {
                            body.vspeed = -1;
                        }
                        
                        if(is_guy && !my_guy.immovable)
                        {
                            var h_change = body.hspeed - orig_h;
                            var v_change = body.vspeed - orig_v;
                            if(sign(my_guy.hspeed) == sign(h_change))
                                my_guy.hspeed -= h_change/2;
                            if(sign(my_guy.vspeed) == sign(v_change))
                                my_guy.vspeed -= v_change/2;
                        }
                    }
                }
            }
            body = noone;
        }
    }
}

// UBERSHIELD
if(overcharge > 0 && charge > max_charge && is_shielded(my_guy, "uber"))
{
    with(phys_body_obj)
    {
        if(iff_check("shield_will_push_me", id, shield) && shield.my_color != my_color
            && point_distance(x,y,shield.x,shield.y) <= shield.radius)
        {
            last_attacker_update(shield.id, "body", "push");
            with(shield)
            {
                apply_force(shield,true);
            }
            speed *= 0.9;
            
            if(object_is_child(id, guy_obj))
            {
                spec_effect_to_guy(0.1, "signal");
                locked = true;
                if(stuck)
                {
                    lost_control = true;
                    
                    if(sign(x-shield.x) == facing)
                    {
                        back_hit = true;
                    }
                    else
                    {
                        front_hit = true;
                    }
                }
            }
        }
    }
    
    part_emitter_burst(system,em,pt,30);
}
