var count = ds_list_size(player_view_list);

for(var i = count-1; i >= 0; i--)
{
    var player_view = player_view_list[| i];
    with(self.cameras[? player_view])
    {
        instance_destroy();
    }
}
ds_map_destroy(self.cameras);
ds_list_destroy(player_view_list);

event_inherited();
