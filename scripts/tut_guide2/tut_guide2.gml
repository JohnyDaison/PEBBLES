function tut_guide2(argument0) {
	if(npc_active || phase != 0)
	{
	    script_execute(topic, argument0);
	    npc_guy2_step();
	}



}
