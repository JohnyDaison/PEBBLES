var i, key, count;

// REGISTER IDS OF CORE GROUPS AND ANIMATION GROUPS
with(obj_group_obj)
{
    if(group_id == other.trigger_group_id)
    {
        other.trigger_group = id;
    }
    
    if(group_id == other.checkpoint_group_id)
    {
        other.checkpoint_group = id;
    }
    
    if(group_id == other.npc_waypoint_group_id)
    {
        other.npc_waypoint_group = id;
    }
    
    for(i=0; i<other.anim_group_count; i++)
    {
        if(i==0)
            key = ds_map_find_first(other.anim_groups);
        else
            key = ds_map_find_next(other.anim_groups, key);
        
        if(group_id == key)
        {
            other.anim_groups[? key] = id;
        }       
    }   
}

// SET UP ZONES' TRIGGER SCRIPTS AND MAP ENTRIES
if(instance_exists(trigger_group))
{
    count = ds_list_size(trigger_group.members);
    
    for(i=0; i<count; i++)
    {
        var zone = trigger_group.members[|i];
        zone.trigger_script = zone_trigger_script;
        var key = zone.my_keys[? trigger_group.id];
        
        if(is_undefined(trigger_map[? key]))
        {
            trigger_map[? key] = ds_list_create();
        }
    }
}

// ADD CHECKPOINTS WITH MATCHING member_id TO TRIGGER MAP
if(instance_exists(checkpoint_group))
{
    count = ds_list_size(checkpoint_group.members);
    
    for(i=0; i<count; i++)
    {
        var checkpoint = checkpoint_group.members[|i];
        var key = checkpoint.my_keys[? checkpoint_group.id];
        
        if(!is_undefined(trigger_map[? key]))
        {
            list = trigger_map[? key];
            ds_list_add(list, checkpoint);
        }
    }
}

