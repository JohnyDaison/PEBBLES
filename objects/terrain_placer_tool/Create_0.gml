action_inherited();
name = "Terrain Placer";
tool_sprite[0] = bigX_icon;
tool_sprite[1] = indestructible_icon;
tool_sprite[2] = destructible_icon;

erase = false;
destructible = false;
colorable = false;
create = true;
overwrite = false;

dragging = false;
can_place = false;
has_placed = false;
can_erase = false;
free_cell = false;
palette_index = 0;

cell_x = 0;
cell_y = 0;
last_cell_x = 0;
last_cell_y = 0;

