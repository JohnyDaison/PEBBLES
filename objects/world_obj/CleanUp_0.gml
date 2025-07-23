place_graph.destroy();

var count = ds_list_size(places);
for (var i = count - 1; i >= 0; i--) {
    with (places[| i]) {
        instance_destroy();
    }
}

ds_list_destroy(places);
