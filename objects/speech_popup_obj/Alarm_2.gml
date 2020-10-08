/// @description SETUP

// SPLIT
var split_pos = string_pos(DB.speech_splitter, str);
if(split_pos > 0)
{
    next_str = string_delete(str, 1, split_pos);
    str = string_copy(str, 1, split_pos - 1);
    //line_offset = max(height, string_length(str));
}

split_done = true;

// CALCULATE WIDTH, SPEED, FADE
my_draw_set_font(font);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
    
str_width = string_width_ext(str, line_height, max_width);
width = str_width + 16;
image_xscale = width/128;

string_explode(str, " ", word_list);
word_count = ds_list_size(word_list);

/*
my_console_log("BEFORE");
for(var word_index = 0; word_index < word_count; word_index++)
{
    var word = word_list[| word_index];
    my_console_log(word);
}
*/

speech_find_terms(str);

/*
my_console_log("AFTER");
for(var word_index = 0; word_index < word_count; word_index++)
{
    var word = word_list[| word_index];
    my_console_log(word);
}
*/

var base_x_offset = 0;
//var max_x_offset = str_width/2;
var max_x_offset = base_x_offset + max_width;
    
line_count = 0;
var base_y_offset = 0;

var x_offset = base_x_offset;
var y_offset = base_y_offset;

var line_x_offset = base_x_offset;
var line_index = 0;
var last_line_index = -1;
var prev_word_width = 0;
max_line_width = 0;

for(var word_index = 0; word_index < word_count; word_index++)
{
    var word = word_list[| word_index];
    var word_width = string_width(word);
    var end_of_message = word_index == word_count - 1;
    var cant_fit_word = (x_offset + word_width) > max_x_offset;
    var bring_prev_word = prev_word_width > 0 
        && (x_offset - line_x_offset > prev_word_width)
        && (end_of_message || prev_word_width < short_word_width);
    var prev_word_offset = prev_word_width + word_spacing;
        
    // END OF LINE
    if(cant_fit_word)
    {
        // PREV SHORT WORD
        if(bring_prev_word)
        {
            x_offset -= prev_word_offset;
        }
        
        x_offset -= word_spacing;
        line_width[? line_index] = x_offset - line_x_offset;
        
        if(max_line_width < line_width[? line_index])
        {
            max_line_width = line_width[? line_index];
        }
    }
        
    // NEW LINE
    if(cant_fit_word)
    {
        y_offset += line_height - 1;
        line_index++;
        line_count = line_index + 1;
    }
        
    // CARRIAGE RETURN
    if(last_line_index != line_index)
    {
        if(!is_undefined(line_width[? line_index]) && line_width[? line_index] > 0)
        {
            line_x_offset = -line_width[? line_index]/2;
        }
        else
        {
            line_x_offset = base_x_offset;
        }
           
        x_offset = line_x_offset;  
        
        // PREV SHORT WORD
        if(bring_prev_word)
        {
            x_offset += prev_word_offset;
        }
    }
        
    // NEXT WORD
    x_offset += word_width + word_spacing;
    
    // END OF MESSAGE
    if(end_of_message)
    {
        x_offset -= word_spacing;
        line_width[? line_index] = x_offset - line_x_offset;
        
        if(max_line_width < line_width[? line_index])
        {
            max_line_width = line_width[? line_index];
        }
    }
    
    display_word_progress_map[? word_index] = 0;
        
    last_line_index = line_index;
    prev_word_width = word_width;
}

display_line_count = 1;

str_width = line_width[? 0];
width = str_width + 2*hor_margin;
image_xscale = width/128;

rise_speed = clamp(12/string_length(str), 0.4, 2);
fade_out_length = floor(fade_out_dist/rise_speed);
max_alpha_length = fade_out_length;

if(instant)
{
    ds_list_copy(display_word_list, word_list);
    
    alarm[5] = 2;
}    

// BG
/*
if(my_color == g_black || my_color == g_blue)
{
    bg_color = c_ltgray; 
}
*/
    
