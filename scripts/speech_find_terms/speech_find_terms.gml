/// @description speech_find_terms(string)
/// @function speech_find_terms
/// @param string
function speech_find_terms() {

	var speech_str = argument[0];
	var speech_length = string_length(speech_str);

	var remaining_str = speech_str;
	var word_index;
	var term_count = ds_list_size(DB.term_name_list);
	var term_i, term_id, term_name, term_found, term_length, term_word_count, term_word_index, term_words_length;

	for(word_index = 0; word_index < word_count; word_index++)
	{
	    var word = word_list[| word_index];
	    var word_length = string_length(word);
    
	    term_length = word_length;
    
	    for(term_i = 0; term_i < term_count; term_i++)
	    {
	        term_id = DB.term_id_list[| term_i];
	        term_name = DB.term_name_map[? term_id];
        
	        term_found = (string_pos(term_name, remaining_str) == 1);
        
	        if(term_found)
	        {
	            term_length = string_length(term_name);
	            term_word_count = 0;
	            term_words_length = 0;
	            term_word_index = word_index;
            
	            while(term_words_length < term_length)
	            {
	                var term_word = word_list[| term_word_index];
	                var term_word_length = string_length(term_word);
                
	                term_words_length += term_word_length;
	                term_word_count++;
                
	                if(term_word_count > 1)
	                {
	                    word_list[| term_word_index-1] += " " + term_word;
	                    ds_list_delete(word_list, term_word_index);
	                    word_count--; 
                    
	                    term_words_length += 1;
	                }
	                else
	                {
	                    term_word_index++;
	                }
	            }
            
	            term_length = term_words_length;
            
	            term_index_map[? word_index] = term_id;
            
	            break;
	        }
	    }
    
	    remaining_str = string_copy(remaining_str, term_length + 2, speech_length);
	}




}
