num = ds_list_size(self.cameras);
for(i=num-1; i>=0; i-=1)
{
    with(ds_list_find_value(self.cameras,i))
    {
        instance_destroy();
    }
}
ds_map_destroy(self.cameras);

action_inherited();
