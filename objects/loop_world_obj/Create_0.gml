event_inherited();

name = "Loop World";

var room1 = add_place_in_room(room_loop_world_1, "Loop World 1", 0,0, 2048,2048, 0);
room1.description = "First";
room1.controller = autogenerate_place_controller_obj;
ds_list_add(room1.level_configs_list, "match");
place_graph.add_node("room1_right", room1, "first_conn");

var room2 = add_place_in_room(room_loop_world_2, "Loop World 2", 0,0, 2048,2048, 0);
room2.description = "Second";
room2.controller = autogenerate_place_controller_obj;
ds_list_add(room2.level_configs_list, "match");
place_graph.add_node("room2_left", room2, "first_conn");

place_count = ds_list_size(places);
current_place = places[|0];

place_graph.add_connection("room1_right", "room2_left");
place_graph.add_connection("room2_left", "room1_right");
