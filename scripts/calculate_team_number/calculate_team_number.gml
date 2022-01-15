function calculate_team_number(player_num) {
    var team_number;
    
    if(gamemode_obj.is_coop)
    {
        team_number = 1;
    } 
    else if(gamemode_obj.mode == "volleyball")
    {
        team_number = player_num mod 2;
        if(team_number == 0)
        {
            team_number = 2;
        }
    } 
    else
    {
        team_number = player_num mod 2;
        if(team_number == 0)
        {
            team_number = 2;
        }
    }
    
    return team_number;
}