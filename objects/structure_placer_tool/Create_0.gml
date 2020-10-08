action_inherited();
name = "Structure Placer";
tool_sprite[0] = bigX_icon;
tool_sprite[1] = small_crystal2_spr;
tool_sprite[2] = jump_pad_icon;
tool_sprite[3] = turret_mount_spr;

erase = false;
create = true;
overwrite = false;

dragging = false;
can_place = false;
has_placed = false;
can_erase = false;
free_cell = false;

cell_x = 0;
cell_y = 0;
last_cell_x = 0;
last_cell_y = 0;

structure_radius = 0;

