///Físicas de plataforma

// Setando variáveis de teclas

var rkey = keyboard_check(vk_right); //Tecla Direita
var lkey = -keyboard_check(vk_left); //Tecla Esquerda
var jkey = keyboard_check_pressed(vk_up); //Tecla Cima/Pulo
var jkey_held = keyboard_check(vk_up); //Checagem de tecla pressionada
var eatkey = keyboard_check_pressed(vk_control); //Tecla de Comer


var move = rkey + lkey;
if(place_meeting(x,y,obj_PAR_Solid))
{
    while(place_meeting(x,y,obj_PAR_Solid))
    {
        move = 0;
        x -= facing;
    }
}

if (control)
{
    hspd = move * spd;
    if(move > 0)
        facing = 1;
    else if(move < 0)
        facing = -1;
}

// Gravidade
if(vspd < 50)
{
    vspd += grav;
}

// Verificar o chão
if(place_meeting(x, y+1, obj_PAR_Solid))
{
    jumps = jumpsmax;
}

if(jkey_held && !eating && jumps > 0)
{
    vspd = -jspd;
    jumps -= 1;
}
else if(!jkey_held)
{
    if(vspd < 0)
        vspd = vspd / 1.5;
}


// Colisão Horizontal
if(place_meeting(x+hspd,y,obj_PAR_Solid))
{
    while(!place_meeting(x+sign(hspd),y,obj_PAR_Solid))
    {
        x += sign(hspd);
    }
    hspd = 0;
}


// Mover Horizontalmente

x += hspd;

// Colisão Vertical
if(place_meeting(x,y+vspd,obj_PAR_Solid))
{
    while(!place_meeting(x,y+sign(vspd),obj_PAR_Solid))
    {
        y += sign(vspd);
    }
    vspd = 0;
}

// Mover Verticalmente

y += vspd;

// Controle dos Sprites
if(eatkey && !eating && !bellyFull)
{
    alarm[0] = 1;
}

if(damaged)
{
    vulnerable = false;
    alarm[2] = 20;
    if(saltLife < 9)
        saltLife++;
    damaged = false;
    if(saltLife > 8)
    {
     game_restart();
    }   
}

if(!vulnerable)
{
    control = false;
    hspd = -((spd * facing)*2);
    if(jumps > 0)
    {
        vspd = -jspd/2;
        jumps -= 1;
    } 
}
else if(eating && !bellyFull)
{
    sprite_index = spr_Salt_Chomp;
    hspd = (spd * facing) * 1.8;
    
    if(image_index > 5)
    {
        image_speed = 0;
        hspd = 0;
    }
    /* if(jumps > 0)
    {
        vspd = -jspd/2;
        jumps -= 1;
    } 
    */
}
else
{
    if(jumps = 0)
    {
        if(vspd < 0)
        {
            sprite_index = spr_Salt_Jumping;
            image_index = 0;
            image_speed = 0;
        }
        else if (vspd >= 0)
        {
            if(image_index > 3)
            {
                image_speed = 0;
                image_index = 4;
            }
            else
            {
                image_speed = 0.6;
            }
        }
        
    }
    else
    {   
        if(!bellyFull)
        {
            if(xprevious != x)
            {
                sprite_index = spr_Salt_Walking;
                image_speed = 0.3;  
            }
            else
            {
                sprite_index = spr_Salt_Idle;
                image_speed = 0.4;
            }
        }
        else
        {
            if(xprevious != x)
            {
                sprite_index = spr_FatSalt_Walking;
                image_speed = 0.3;  
            }
            else
            {
                sprite_index = spr_FatSalt_Idle;
                image_speed = 0.3;
            }
        }
    }
}
// Controlar a direção que o personagem está virado

if(bellyFull && keyboard_check(vk_down))
{
    
}

if(facing = 1)
{
    image_xscale=1;  
} 
else if(facing = -1)
{
    image_xscale=-1;
}
