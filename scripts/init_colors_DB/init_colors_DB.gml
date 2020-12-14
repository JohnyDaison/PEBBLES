function init_colors_DB() {
    
	// COLORS
	colormap = ds_map_create();
	colornames = ds_map_create();
	colorpitch = ds_map_create();
	colormatrix = ds_grid_create(9,9);


	// MAP OF GAME COLORS TO REPRESENTATIONS
	colormap[? g_nothing] = c_black;
	colormap[? g_black] = c_dkgray;
	colormap[? g_red] = make_colour_rgb(255,20,20); //c_red;
	colormap[? g_green] = make_colour_rgb(30,220,30); //0,200,0
	colormap[? g_blue] = make_colour_rgb(50,50,255);  //50,55,255
	colormap[? g_yellow] = make_colour_rgb(250,250,0);
	colormap[? g_purple] = make_colour_rgb(240,50,240); //220,0,220
	colormap[? g_azure] = make_colour_rgb(50,250,240); //50,220,220
	colormap[? g_white] = c_white;
	colormap[? g_octarine] = c_ltgray;
	colormap[? "bf_orange"] = make_colour_rgb(252,135,10);


	// MAP OF GAME COLORS TO NAMES
	colornames[? g_nothing] = "Void";
	colornames[? g_black] = "Dark";
	colornames[? g_red] = "Red";
	colornames[? g_green] = "Green";
	colornames[? g_blue] = "Blue";
	colornames[? g_yellow] = "Yellow";
	colornames[? g_purple] = "Magenta";
	colornames[? g_azure] = "Cyan";
	colornames[? g_white] = "White";
	colornames[? g_octarine] = "Octarine";


	// MAP OF GAME COLORS TO PITCHES
	colorpitch[? g_black] = 0.666;
	colorpitch[? g_red] = 0.786;
	colorpitch[? g_yellow] = 0.885;
	colorpitch[? g_green] = 1;
	colorpitch[? g_azure] = 1.1;
	colorpitch[? g_blue] = 1.15;
	colorpitch[? g_purple] = 1.3;
	colorpitch[? g_white] = 1.4;
	colorpitch[? g_octarine] = 1.5;


	// COLOR DIRECTIONS
	colordirs = ds_map_create();
	colordirs[? g_red] = 0;
	colordirs[? g_yellow] = 0.66;
	colordirs[? g_green] = 1.33;
	colordirs[? g_azure] = 2;
	colordirs[? g_blue] = 2.66;
	colordirs[? g_purple] = 3.33;


	// COLOR MATRIX - POWER RATIOS
    var power_level;
	power_level[0] = -0.10;
	power_level[1] = 0.25;
	power_level[2] = 0.50;
	power_level[3] = 0.75;
	power_level[4] = 1.00;
	power_level[5] = 1.25;

	// init all - base
	ds_grid_set_region(colormatrix, g_black, g_black, g_octarine, g_octarine, power_level[2]);
    

	// buffed basic vs. basic
	ds_grid_set(colormatrix, g_red, g_green, power_level[4]);
	ds_grid_set(colormatrix, g_green, g_blue, power_level[4]);
	ds_grid_set(colormatrix, g_blue, g_red, power_level[4]);

	// new debuffed basic vs. basic
	ds_grid_set(colormatrix, g_green, g_red, power_level[1]);
	ds_grid_set(colormatrix, g_blue, g_green, power_level[1]);
	ds_grid_set(colormatrix, g_red, g_blue, power_level[1]);

	// buffed basic vs. double
	ds_grid_set(colormatrix, g_red, g_azure, power_level[4]);
	ds_grid_set(colormatrix, g_green, g_purple, power_level[4]);
	ds_grid_set(colormatrix, g_blue, g_yellow, power_level[4]);
    

	// debuffed double vs. basic
	ds_grid_set(colormatrix, g_yellow, g_blue, power_level[1]);
	ds_grid_set(colormatrix, g_purple, g_green, power_level[1]);
	ds_grid_set(colormatrix, g_azure, g_red, power_level[1]);

	// buffed double vs. double
	ds_grid_set(colormatrix, g_yellow, g_azure, power_level[4]);
	ds_grid_set(colormatrix, g_purple, g_yellow, power_level[4]);
	ds_grid_set(colormatrix, g_azure, g_purple, power_level[4]);

	// new debuffed double vs. double
	ds_grid_set(colormatrix, g_azure, g_yellow, power_level[1]);
	ds_grid_set(colormatrix, g_yellow, g_purple, power_level[1]);
	ds_grid_set(colormatrix, g_purple, g_azure, power_level[1]);


	// basic vs. white 
	ds_grid_set(colormatrix, g_red, g_white, power_level[4]);
	ds_grid_set(colormatrix, g_green, g_white, power_level[4]);
	ds_grid_set(colormatrix, g_blue, g_white, power_level[4]);

	// double vs. white
	ds_grid_set(colormatrix, g_yellow, g_white, power_level[1]);
	ds_grid_set(colormatrix, g_purple, g_white, power_level[1]);
	ds_grid_set(colormatrix, g_azure, g_white, power_level[1]);

	// white vs. basic
	ds_grid_set(colormatrix, g_white, g_red, power_level[2]);
	ds_grid_set(colormatrix, g_white, g_green, power_level[2]);
	ds_grid_set(colormatrix, g_white, g_blue, power_level[2]);
    
    // white vs. double
	ds_grid_set(colormatrix, g_white, g_yellow, power_level[4]);
	ds_grid_set(colormatrix, g_white, g_purple, power_level[4]);
	ds_grid_set(colormatrix, g_white, g_azure, power_level[4]);

	// white vs. black
	ds_grid_set(colormatrix, g_white, g_black, power_level[4]);


	// octarine vs. all
	ds_grid_set_region(colormatrix, g_octarine, g_black, g_octarine, g_octarine, power_level[4]);

	// other vs. octarine
	ds_grid_set_region(colormatrix, g_black, g_octarine, g_white, g_octarine, power_level[4]);
    

	// the main diagonal minus black and octarine
	for(var i=g_red; i<=g_white; i+=1)
	{
	    ds_grid_set(colormatrix, i, i, power_level[0]);
	}
}