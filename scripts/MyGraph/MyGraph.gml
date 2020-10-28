function MyGraph() constructor {
    nodes = ds_map_create();
    connections = ds_map_create();
    my_console_log("MyGraph created");
    
    static add_node = function(node_id, node) {
        var existing = nodes[? node_id];
        
        if (!is_undefined(existing)) {
            my_console_log("Node " + node_id + " already exists");
            return false;
        }
        
        nodes[? node_id] = node;
    }
    
    static add_connection = function(connection_id, params) {
        var existing = connections[? connection_id];
        
        if (!is_undefined(existing)) {
            my_console_log("Connection " + connection_id + " already exists");
            return false;
        }
        
        var from_node = nodes[? params.from];
        var to_node = nodes[? params.to];
        
        if (is_undefined(from_node)) {
            my_console_log("Connection " + connection_id + " - From node " + from_node + " doesn't exist");
            return false;
        }
        
        if (is_undefined(to_node)) {
            my_console_log("Connection " + connection_id + " - To node " + to_node + " doesn't exist");
            return false;
        }
        
        connections[? connection_id] = params;
    }
    
    static destroy = function() {
        ds_map_destroy(nodes);
        ds_map_destroy(connections);
        my_console_log("MyGraph destroyed");
    }
}