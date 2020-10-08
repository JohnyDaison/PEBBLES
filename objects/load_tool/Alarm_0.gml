with(editor_object)
{
    instance_destroy();
}

filename = "level.dat";

// HEADER
file = file_text_open_read(filename);

// PLACE INFO
place_obj.name = file_text_read_string(file);
main_editor_toolbar.placename_input.text = place_obj.name;
file_text_readln(file);
place_obj.width = file_text_read_real(file)*32;
place_obj.height = file_text_read_real(file)*32;
file_text_readln(file);
file_text_readln(file);

// BLOCK PALETTE
while(!file_text_eoln(file))
//for(i=0;i<4;i+=1)
{
    block_index = file_text_read_real(file);
    block_name = file_text_read_string(file);
    show_debug_message(string(block_index) + " " + block_name);
    file_text_readln(file);
}
file_text_readln(file);

// SKIP TERRAIN DATA
file_text_read_string(file);
file_text_readln(file);

// HEADER SIZE
header_size = file_text_read_real(file);
show_debug_message("header " + string(header_size));
file_text_readln(file);

//OBJECTS
while(!file_text_eoln(file))
{
    object_type = file_text_read_real(file);
    x = file_text_read_real(file)+place_obj.x;
    y = file_text_read_real(file)+place_obj.y;
    
    object = noone;
    
    switch(object_type)
    {
        case 1:
            object = instance_create(x,y,editor_guy_spawner_obj);
            object.player_number = file_text_read_real(file);
        break;
        case 2:
            object = instance_create(x,y,editor_jump_pad_obj);
            object.max_power = file_text_read_real(file);
        break;
    }
    
    if(instance_exists(object))
    {
        with(object)
        {
            event_perform(ev_other,ev_user0);
        }
    }
    
    file_text_readln(file);
}
file_text_readln(file);

file_text_close(file);

with(singleton_obj)
{
    event_perform(ev_other,ev_room_end);
    event_perform(ev_other,ev_room_start);
}

// TERRAIN
file = file_bin_open(filename, 0);
file_bin_seek(file,header_size);

for(yy=place_obj.y; yy<place_obj.y+place_obj.height; yy+=32)
{
    for(xx=place_obj.x; xx<place_obj.x+place_obj.width; xx+=32)        
    {
        indexcolor = file_bin_read_byte(file);
        dmgenergy = file_bin_read_byte(file);
        
        block_color = indexcolor mod 8;
        block_index = (indexcolor - block_color)/8;

        block_energy = dmgenergy mod 16;
        block_damage = (dmgenergy - block_energy)/16;
        
        if(block_index > 0 && block_index < 31)
        {
            block = instance_create(xx,yy,editor_terrain_obj);
            block.palette_index = block_index;
            block.color = block_color;
            block.damage = block_damage;
            block.energy = block_energy;
            with(block)
            {
                event_perform(ev_other,ev_user0);
            }
        }
    }
}

file_bin_close(file);

/*
// OBJECTS
file = file_text_open_append(filename);

file_text_close(file);
*/
alarm[1]=1;

/* */
/*  */
