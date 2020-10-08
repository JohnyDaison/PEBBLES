action_inherited();
self.width = 1216;
self.height = 656;
x = room_width/2-self.width/2;
y = room_height/2-self.height/2;
self.text = "How to Play";
self.modal = true;

top_line = 80;

eloffset_x = x + 16;
eloffset_y = y + top_line;



eloffset_x += 360; 
eloffset_y -= 16;

eloffset_x = x;
eloffset_y += 384;

ii = gui_add_button(self.width/2,0,"OK",goto_mainmenu);
ii.icon = big_tick_spr;
ii.center_icon = true;
ii.show_icon = true;

alarm[2] = 2;


