var i = direction/90;
var xx = 1, xcor = 0;
var yy = 1, ycor = 0;
if(i==1)
    ycor = 1;   
if(i==2)
    xcor = 1;
if(i>1)
    xx = -1;
           
draw_sprite_ext(sprite_index, image_index, x+xcor,y+ycor, xx,yy, (i mod 2)*90, tint, 1);

action_inherited();
