event_inherited();

draw_set_alpha(self.field_alpha);

switch(shape)
{
    // TODO: tinted texture drawing
    case shape_circle:
    draw_set_blend_mode_ext(bm_dest_colour,bm_one);
    draw_circle_colour(x,y,radius,self.tint,c_white,false);
    draw_set_alpha(self.field_alpha*0.5);
    //draw_ellipse_color(x-radius*5/15,y-radius*11/12,x+radius*5/15,y-radius*9/12,c_ltgray,c_white,false);
    draw_set_blend_mode(bm_normal); 
    break;
    
    case shape_rect:
    
    draw_set_color(self.tint);
    draw_roundrect(round(x-width/2),round(y-height/2),round(x+width/2),round(y+height/2),false)
    
    break;
}
draw_set_alpha(1);

