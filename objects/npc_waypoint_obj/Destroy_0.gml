chunk_deregister(chunkgrid_obj, id);

with(place_controller_obj)
{
    nav_graph_remove_node(other.waypoint_id);
}

event_inherited();