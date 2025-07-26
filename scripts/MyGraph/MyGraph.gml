function MyGraph() constructor {
    class_name = instanceof(self);
    nodes = ds_map_create();
    node_list = ds_list_create();
    connections = ds_map_create();
    connection_list = ds_list_create();
    my_console_log(class_name + " created");
    
    static add_node = function(node_id, node) {
        var existing = nodes[? node_id];
        
        if (!is_undefined(existing)) {
            my_console_log("Node " + node_id + " already exists");
            return false;
        }
        
        nodes[? node_id] = node;
        ds_list_add(node_list, node_id);
        
        return true;
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
            my_console_log("Connection " + connection_id + " - From node " + params.from + " doesn't exist");
            return false;
        }
        
        if (is_undefined(to_node)) {
            my_console_log("Connection " + connection_id + " - To node " + params.to + " doesn't exist");
            return false;
        }
        
        connections[? connection_id] = params;
        ds_list_add(connection_list, connection_id);
        
        return true;
    }
    
    static destroy = function() {
        ds_map_destroy(nodes);
        ds_list_destroy(node_list);
        ds_map_destroy(connections);
        ds_list_destroy(connection_list);
        my_console_log(class_name + " destroyed");
    }
}