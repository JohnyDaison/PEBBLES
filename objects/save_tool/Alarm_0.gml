filename = "level.dat";
/*
// WIPE FILE
file = file_bin_open(filename, 1);
file_bin_rewrite(file);
file_bin_close(file);
*/
// HEADER
file = file_text_open_write(filename);

file_text_write_string(file,place_obj.name);
file_text_writeln(file);
file_text_write_real(file,place_obj.width/32);
file_text_write_real(file,place_obj.height/32);
file_text_writeln(file);
file_text_writeln(file);

file_text_write_real(file,0);
file_text_write_string(file,"Nothingness");
file_text_writeln(file);
file_text_write_real(file,1);
file_text_write_string(file,"Indestructible");
file_text_writeln(file);
file_text_write_real(file,2);
file_text_write_string(file,"Destructible");
file_text_writeln(file);
file_text_write_real(file,31);
file_text_write_string(file,"Ether");
file_text_writeln(file);
file_text_writeln(file);
file_text_close(file);

// TERRAIN
file = file_bin_open(filename, 2);
header_size = file_bin_size(file);
file_bin_seek(file,header_size);

for(yy=place_obj.y; yy<place_obj.y+place_obj.height; yy+=32)
{
    for(xx=place_obj.x; xx<place_obj.x+place_obj.width; xx+=32)        
    {
        block = instance_nearest(xx,yy,editor_terrain_obj);
        block_index = 31;
        block_color = g_dark;
        block_damage = 0;
        block_energy = 0;
        
        if(block.x == xx && block.y == yy)
        {
            block_index = block.palette_index;
        }
        
        file_bin_write_byte(file,block_index*8+block_color);
        file_bin_write_byte(file,block_damage*16+block_energy);
    }
}

file_bin_close(file);

// OBJECTS
file = file_text_open_append(filename);
file_text_writeln(file);
file_text_write_real(file,header_size);
file_text_writeln(file);

with(editor_guy_spawner_obj)
{
    file_text_write_real(other.file,1);
    file_text_write_real(other.file,x-place_obj.x);
    file_text_write_real(other.file,y-place_obj.y);
    file_text_write_real(other.file,player_number);
    file_text_writeln(other.file);
}

with(editor_jump_pad_obj)
{
    file_text_write_real(other.file,2);
    file_text_write_real(other.file,x-place_obj.x);
    file_text_write_real(other.file,y-place_obj.y);
    file_text_write_real(other.file,max_power);
    file_text_writeln(other.file);
}

file_text_writeln(file);
file_text_close(file);

alarm[1]=1;

/* */
/*  */
