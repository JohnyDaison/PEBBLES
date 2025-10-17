event_inherited();

var small_margin = 8;
var large_margin = 16;
var line_height = 32;

self.width = 992;
self.text = "Control Settings";
self.modal = true;

var labels = [];

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
labels[look] = "Aim Mode";
labels[altfire] = "Toggle Cannon";
labels[inventory_1] = "Item 1";
labels[inventory_2] = "Item 2";
labels[inventory_3] = "Item 3";
labels[inventory_4] = "Item 4";
labels[colorinfo] = "Color Info";
labels[pause] = "Pause";

self.input_count = colorinfo + 1;


var top_line = 64;
var column_size = 176;
var column_start = top_line + line_height;

var columnCenters = [
    column_size * 1 / 2,
    column_size * 3 / 2,
    column_size * 5 / 2,
    column_size * 7 / 2,
    column_size * 9 / 2
];

self.height = column_start - (line_height / 2) + (line_height * (self.input_count + 1)) + (2 * small_margin);
self.x = room_width / 2 - self.width / 2;
self.y = room_height / 2 - self.height / 2;


self.eloffset_x = self.x + large_margin;
self.eloffset_y = self.y + top_line;

gui_add_label(columnCenters[1], 0, "Keyboard 1");
gui_add_label(columnCenters[2], 0, "Keyboard 2");
gui_add_label(columnCenters[3], 0, "Gamepad 1");
gui_add_label(columnCenters[4], 0, "Gamepad 2");

self.eloffset_y = self.y + column_start;

for (var i = 0; i < self.input_count; i++) {
    var inst = noone;
    gui_add_label(columnCenters[0], 0, labels[i]);

    inst = gui_add_keybinder(columnCenters[1], 0, keyboard1_obj.binds[? i]);
    self.key1[i] = ds_list_find_index(self.gui_content, inst);

    inst = gui_add_keybinder(columnCenters[2], 0, keyboard2_obj.binds[? i]);
    self.key2[i] = ds_list_find_index(self.gui_content, inst);

    inst = gui_add_gamepad_binder(columnCenters[3], 0, 0, i);
    self.pad1[i] = ds_list_find_index(self.gui_content, inst);

    inst = gui_add_gamepad_binder(columnCenters[4], 0, 1, i);
    self.pad2[i] = ds_list_find_index(self.gui_content, inst);

    self.eloffset_y += line_height;
}

self.eloffset_x = self.x;
self.eloffset_y += small_margin;

var inst = gui_add_button(self.width / 2, 0, "OK", control_config_OK);
inst.icon = big_tick_spr;
inst.center_icon = true;
inst.show_icon = true;
