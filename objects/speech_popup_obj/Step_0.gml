event_inherited();

if(split_done && str != "" && !fading)
{
    if(spoken_count < string_length(str) && instance_exists(source))   
    {
        x = source.x;
        y = source.y + y_offset;
        if((singleton_obj.step_count mod source.speech_tick) == 0)
        {
            var char = string_char_at(str, spoken_count+1);
            display_str += char;
                        
            var word_index = ds_list_size(display_word_list) - 1;
            if(word_index == -1)
            {
                word_index = 0;
                //display_word_list[| word_index] = "";
                display_word_progress_map[? word_index] = 0;
            }
            
            var word_length = string_length(word_list[| word_index]);
            var progress_map = display_word_progress_map;

            if(progress_map[? word_index] < word_length)
            {
                progress_map[? word_index]++;
            }
            else
            {
                if(word_index < word_count-1)
                {
                    word_index++;
                    //display_word_list[| word_index] = "";
                    progress_map[? word_index] = 0;
                }
            }
            
            var word_progress = progress_map[? word_index];
            
            display_word_list[| word_index] = string_copy(word_list[| word_index], 1, word_progress);
            
            speech_volume = source.speech_volume;
            //speech_pitch = source.speech_pitch;
            
            if(!(char == " " || char == "\"" || char == "'" || char == "," || char == ":" || char == ";"
            || char == "." || char == "?" || char == "!"))
            {
                var term_id = term_index_map[? word_index];
                var is_term = !is_undefined(term_id);
                var term_color = my_color;
        
                if(is_term)
                {
                    term_color = DB.term_color_map[? term_id];
                }
                
                my_sound_play_colored(choose(speech1_sound, speech2_sound, speech3_sound), term_color, true, speech_volume);
            }
            
            spoken_count++;
            
            /*
            my_draw_set_font(font);
            str_height = string_height_ext(display_str, line_height, max_width);
            
            height = str_height + 12;
            image_yscale = height/36;
            */
            
            str_height = display_line_count*(line_height-1);
            
            height = str_height + 2*vert_margin;
            image_yscale = height/36;
        }
    }
    else
    {
        if(instance_exists(source))
        {
            if(next_str == "")
            {
                with(source)
                {
                    speech_stop();
                }
            }
            else
            {
                alarm[3] = max_alpha_length + min( floor((height + line_offset)/rise_speed), fade_out_length-1);
            }
        }
        
        fading = true;
        alarm[0] = max_alpha_length + fade_out_length;
    }
}