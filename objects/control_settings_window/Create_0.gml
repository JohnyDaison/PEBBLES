event_inherited();

self.width = 992;
self.height = 672;
x = room_width/2-self.width/2;
y = room_height/2-self.height/2;
self.text = "Control Settings";
self.modal = true;

labels[up] = "Up";
labels[down] = "Down";
labels[left] = "Left";
labels[right] = "Right";
labels[r] = "Red";
labels[g] = "Green";
labels[b] = "Blue";
labels[cast] = "Cast";
labels[channel] = "Channel";
labels[abi] = "Ability";
labels[jump] = "Jump";
labels[look] = "Look";
labels[altfire] = "Toggle Cannon";
labels[inventory_1] = "Item 1";
labels[inventory_2] = "Item 2";
labels[inventory_3] = "Item 3";
labels[inventory_4] = "Item 4";


top_line = 64;
column_size = 176;
column_start = top_line+32;

eloffset_x = x + 16;
eloffset_y = y + top_line;

gui_add_label(column_size*3/2, 0, "Keyboard 1");

gui_add_label(column_size*5/2, 0, "Keyboard 2");

gui_add_label(column_size*7/2, 0, "Gamepad 1");

gui_add_label(column_size*9/2, 0, "Gamepad 2");

eloffset_y = y + column_start;

for(i=0;i<=16;i+=1)
{
    gui_add_label(column_size*1/2, 32*i, labels[i]);
    
    ii = gui_add_keybinder(column_size*3/2, 32*i, keyboard1_obj.binds[? i]);
    self.key1[i] = ds_list_find_index(self.gui_content, ii);
    
    ii = gui_add_keybinder(column_size*5/2, 32*i, keyboard2_obj.binds[? i]);
    self.key2[i] = ds_list_find_index(self.gui_content, ii);
    
    /*
    ii = gui_add_joybinder(column_size*7/2, 32*i, 1, joystick1_obj.binds[? i]);
    ii.enabled = false;
    self.joy1[i] = ds_list_find_index(self.gui_content, ii);
    */
    
    ii = gui_add_gamepad_binder(column_size*7/2, 32*i, 0, i);
    self.pad1[i] = ds_list_find_index(self.gui_content, ii);
    
    /*
    ii = gui_add_joybinder(column_size*9/2, 32*i, 2, joystick2_obj.binds[? i]);
    ii.enabled = false;
    self.joy2[i] = ds_list_find_index(self.gui_content, ii);
    */
    
    ii = gui_add_gamepad_binder(column_size*9/2, 32*i, 1, i);
    self.pad2[i] = ds_list_find_index(self.gui_content, ii);
}

eloffset_x = x;
eloffset_y += 32*i+8;

ii = gui_add_button(self.width/2, 0, "OK", control_config_OK);
ii.icon = big_tick_spr;
ii.center_icon = true;
ii.show_icon = true;



