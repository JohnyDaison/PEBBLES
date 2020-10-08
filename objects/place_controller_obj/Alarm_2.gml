/// @description Generate nav graph

if(generate_nav_graph)
{
    nav_graph_clear();
    nav_graph_generate(remove_redundancy);
    generate_nav_graph = false;
    
    if(!remove_redundancy)
    {
        remove_redundancy = true;
        generate_nav_graph = true;
        alarm[2] = 60;
    }
}
