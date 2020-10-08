/// @description DETECT TRIGGERABLES
var i, count = ds_list_size(triggerables);

for(i=0; i<count; i++)
{
    with(triggerables[| i])
    {
        if(place_meeting(x,y, other))
        {
            ds_list_add(other.trigger_targets, id);
            other.trigger_script = trigger_target_script; 
        }
    }
}
