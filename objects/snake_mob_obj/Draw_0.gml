//draw_self();
draw_sprite_ext(sprite_index, image_index, x,y, 1,1, 0, tint, 1);

var i, prev_ter, ter;
if(alive)
{
    for(i=1; i < body_size; i++)
    {
        prev_ter = ter_group.members[| i-1];
        ter = ter_group.members[| i];
        var spr = snake_dot_spr;
        if(i < head_size)
        {
            spr = snake1_icon;
        }
        if(!is_undefined(ter) && instance_exists(ter))
        {
            draw_sprite_ext(spr, 0, ter.x, ter.y, 1,1, 0, tint, 1);
            
            var dot_x = mean(prev_ter.x, ter.x);
            var dot_y = mean(prev_ter.y, ter.y);
            draw_sprite_ext(snake_dot_spr, 1, dot_x, dot_y, 1,1, 0, tint, 1);
        }
    }

}

/*
if(instance_exists(eat_target))
{
    draw_set_colour(c_red);
    draw_set_alpha(1);
    draw_line(x+15, y+15, eat_target.x+15, eat_target.y+15);
}
*/

event_inherited();
