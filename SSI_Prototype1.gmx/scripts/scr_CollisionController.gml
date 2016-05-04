// Colisão Horizontal

if(place_meeting(x+hspd,y,obj_PAR_Solid))
{
    while(!place_meeting(x+sign(hspd),y,obj_PAR_Solid))
    {
        x += sign(hspd);
    }
    hspd = 0;
}

// Colisão Vertical

if(place_meeting(x,y+vspd,obj_PAR_Solid))
{
    while(!place_meeting(x,y+sign(vspd),obj_PAR_Solid))
    {
        y += sign(vspd);
    }
    vspd = 0;
}
