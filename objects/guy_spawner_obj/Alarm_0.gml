/// @description  CREATE ALL THE THINGS
if(player_start_point)
{
    var main_player = my_player;
    var spawner = id;

    create_player_things(main_player);
    ds_list_add(my_players, main_player);
    
    with(player_obj)
    {
        if(id != main_player && team_number == main_player.team_number)
        {
            var team_player = id;
            
            with(spawner)
            {
                if(instance_exists(team_player) && instance_number(guy_spawner_obj) < team_player.number
                    && team_player.number > main_player.number)
                {
                    create_player_things(team_player);
                    ds_list_add(my_players, team_player);
                }
            }
        }
    }

    players_created = true;
}
