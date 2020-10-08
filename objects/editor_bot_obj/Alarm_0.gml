var bot = instance_create(x,y, basic_bot);

with(bot)
{
    if(!is_undefined(other.npc_init_script))
    {
        script_execute(other.npc_init_script);
    }
    
    if(!is_undefined(other.npc_script))
    {
        npc_script = other.npc_script;
    }
    
    if(!is_undefined(other.npc_destroy_script))
    {
        npc_destroy_script = other.npc_destroy_script;
    }


    if(!is_undefined(other.name))
    {
        name = other.name;
    }
    
    if(!is_undefined(other.score_multiplier))
    {
        score_multiplier = other.score_multiplier;
    }
    
    if(!is_undefined(other.difficulty))
    {
        difficulty = other.difficulty;
    }


    if(!is_undefined(other.bot_activation_distance))
    {
        bot_activation_distance = other.bot_activation_distance;
    }
    
    if(!is_undefined(other.stay_activated))
    {
        stay_activated = other.stay_activated;
    }
    
    if(!is_undefined(other.spawn_batteries))
    {
        spawn_batteries = other.spawn_batteries;
    }
}

instance_destroy();