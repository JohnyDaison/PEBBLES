///@description RESPAWN BOT

if(!instance_exists(my_guy))
{
    my_guy = instance_create(x,y, basic_bot);

    with(my_guy)
    {
        sparring_bot1_init();
        npc_script = sparring_bot1;
        difficulty = other.difficulty_level/10;
        score_multiplier = difficulty;
        normal_hp = hp;
        hp = min(1, difficulty) * normal_hp;
        
        name = DB.bot_names[? other.difficulty_level]+ " L"+string(other.difficulty_level);
        
        my_player.my_guy = id;
        my_spawner = other.id;
        my_player.my_spawner = other.id;
    
        // Main camera should be World's my_camera and follow World's my_guy?
    }

    instance_create(x,y,spawn_effect_obj);
}