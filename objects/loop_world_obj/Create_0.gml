event_inherited();

name = "Loop World";

var room1 = add_place_in_room(room_loop_world_1, "Loop World 1", 0,0, 2048,2048, 0);
room1.description = "First";
room1.controller = autogenerate_place_controller_obj;
ds_list_add(room1.level_configs_list, "match");
place_graph.add_node("room1", room1);

var room2 = add_place_in_room(room_loop_world_2, "Loop World 2", 0,0, 2048,2048, 0);
room2.description = "Second";
room2.controller = autogenerate_place_controller_obj;
ds_list_add(room2.level_configs_list, "match");
place_graph.add_node("room2", room2);

place_count = ds_list_size(places);
current_place = places[|0];

place_graph.add_connection("1-2",   {from: "room1", to: "room2"});
place_graph.add_connection("2-1",   {from: "room2", to: "room1"});
place_graph.add_connection("1-2-1", {from: "room1", to: "room2", both_ways: true});