size = ds_list_size(self.gui_content);
for(i=0;i<size;i+=1)
{
    with((ds_list_find_value(self.gui_content,i))) instance_destroy();
}
ds_list_destroy(self.gui_content);
if(self.gui_parent != noone)
{
    with(self.gui_parent)
    {
        ds_list_replace(self.gui_content,
                        ds_list_find_index(self.gui_content,other),
                        noone);
    }
}