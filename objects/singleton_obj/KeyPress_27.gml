if(room != mainmenu)
{
    if(instance_exists(gamemode_obj))
    {
        if(room != match_summary && room != level_editor)
        {
            if(gamemode_obj.match_started && !gamemode_obj.limit_reached && !paused)
            {
                pause_game();
            }
            else if(paused)
            {
                resume_game();
            }
        }
        if(room == level_editor)
        {
            end_test_script();
        }
    }
    else
    {
        goto_mainmenu();
    }
}
else if(instance_exists(play_menu_window))
{
    goto_mainmenu();
}
else if(instance_exists(main_menu_window))
{
    game_end();
}
