function __background_set_internal(argument0, argument1, argument2, argument3) {
	var __prop = argument0;
	var __bind = argument1;
	var __val = argument2;
	var __backinfo = argument3;

	if (__backinfo[0] == -1)
	{
	    return -1;    // erm
	}

	var __backid = __backinfo[0];
	var __layerid = __backinfo[1];
	var __isfore = __backinfo[2];


	switch(__prop)
	{
	    case e__BG.Visible: layer_background_visible(__backid, __val); break;    
	    case e__BG.Index: layer_background_change(__backid, __val)  break;
	    case e__BG.X: layer_x(__layerid, __val); break;
	    case e__BG.Y: layer_y(__layerid, __val); break;    
	    case e__BG.HTiled: layer_background_htiled(__backid, __val); break;
	    case e__BG.VTiled: layer_background_vtiled(__backid, __val); break;
	    case e__BG.XScale: layer_background_xscale(__backid, __val); break;
	    case e__BG.YScale: layer_background_yscale(__backid, __val); break;
	    case e__BG.HSpeed: layer_hspeed(__layerid, __val); break;
	    case e__BG.VSpeed: layer_vspeed(__layerid, __val); break;
	    case e__BG.Blend: layer_background_blend(__backid, __val); break;
	    case e__BG.Alpha: layer_background_alpha(__backid, __val); break;
	    case e__BG.Stretch: layer_background_stretch(__backid, __val); break;
	    default: break;
	};

	return -1;


}
