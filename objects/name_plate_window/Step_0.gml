if(instance_exists(my_guy))
{
    text = my_guy.name;
    visible = !my_guy.invisible;
    flag_icon = my_guy.my_player.icon;
}
else
{
    instance_destroy();
}

