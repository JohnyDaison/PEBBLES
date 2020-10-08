window_axis = x+self.width/2;

ii = instance_create(window_axis,y+self.height/2,gui_infoarea);
ii.width = self.width - 16;
ii.height = self.height - 16;
ii.text = info;
ii.gui_parent = id;
ds_list_add(self.gui_content,ii);

