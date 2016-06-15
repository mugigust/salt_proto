///Físicas de plataforma

// Setando variáveis de teclas
if(cutsceneOn)
{
    
}
else
{
    var rkey = keyboard_check(vk_right) || (gamepad_axis_value(0,gp_axislh) > 0); //Tecla Direita
    var lkey = -(keyboard_check(vk_left) || (gamepad_axis_value(0,gp_axislh) < -0)); //Tecla Esquerda
    var jkey = keyboard_check_pressed(vk_up) || (gamepad_button_check_pressed(0,gp_face1)); //Tecla Cima/Pulo
    var jkey_held = keyboard_check(vk_up) || (gamepad_button_check(0,gp_face1)); //Checagem de tecla pressionada
    var eatkey = keyboard_check_pressed(vk_control) || (gamepad_button_check_pressed(0,gp_face3)); //Tecla de Comer
    
    if(damaged)
    {
        attacking = false;
        eating = false;
        with(obj_Attack)
        {
            instance_destroy();
        }
    }
    if(powerUpId == 0)
    {
        formID = 0;
    }
    scr_PlayerSpriteController();
    
    var move = rkey + lkey;
    if(place_meeting(x,y,obj_PAR_Solid))
    {
        while(place_meeting(x,y,obj_PAR_Solid))
        {
            move = 0;
            x -= facing;
        }
    }
    
    if(place_meeting(x,y,obj_Solid_Vanishable))
    {
        hiddenAreaVisible = true;
    }
    else
    {
        hiddenAreaVisible = false;
    }
    
    if (control)
    {
        hspd = move * spd;
        if(move > 0)
            facing = 1;
        else if(move < 0)
            facing = -1;
    }
    else if(!eating && !attacking && vulnerable)
    {
        hspd = 0;
        vspd = 0;
    }
    else if(attacking && onGround)
    {
        hspd = 0;
        vspd = 0;
    }
    
    // Gravidade
    
    if(vspd < 50 && onGrav)
    {
        vspd += grav;
    }
    
    // Verificar o chão
    if(place_meeting(x, y+1, obj_PAR_Solid))
    {
        jumps = jumpsmax;
        onGround = true;
    }
    else
    {
        onGround = false;
    }
    
    if(jkey_held && !eating && jumps > 0 && control)
    {
        vspd = -jspd;
        jumps -= 1;
    }
    else if(!jkey_held && control)
    {
        if(vspd < 0)
            vspd = vspd / 1.5;
    }
    
    scr_CollisionController();
    
    // Mover Horizontalmente
    
    x += hspd;
    
    // Mover Verticalmente
    
    y += vspd;
    
    // Controle dos Sprites
    if(formID == 0)
    {
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
            sprite_index = spr_Salt_Hurt;
            control = false;
            hspd = -((spd * facing)*2);
            if(jumps > 0)
            {
                vspd = -jspd/2;
                jumps -= 1;
            } 
            
        }
        else if(doorIn)
        {
            if(sprite_index != spr_Salt_Entering)
            {
                sprite_index = spr_Salt_Entering;
                image_index = 0;
            }
            image_speed = 0.3;
        }
        else if(spit)
        {
            scr_Attack1Controller(formID);
        }
        else if(transforming)
        {
            control = false;
            if(sprite_index != spr_Salt_Transforming)
            {
                sprite_index = spr_Salt_Transforming;
                image_index = 0;
            }
            
            image_speed = 0.3;
            if(image_index > 10)
            {
                bellyFull = false;
                transforming = false;
                formID = powerUpId;
                
                if(formID!=0)
                    transformed = true;
                    
                control = true;
            }
        }
        else if(eating)
        {
            scr_Attack1Controller(formID);
        }
        else
        {
            if(jumps = 0)
            {
                if(sprite_index != jumpingSprite)
                {
                    sprite_index = jumpingSprite;
                    image_index = 0;
                }
                if(!bellyFull)
                {
                    if(vspd < 0)
                    {
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
                    
                    if(vspd < 0)
                    {
                        image_index = 0;
                        image_speed = 0;
                    }
                    else if (vspd >= 0)
                    {
                        image_index = 1;
                        image_speed = 0;
                    }
                }
                
            }
            else
            {   
                if(!bellyFull)
                {
                    if(xprevious != x)
                    {
                        sprite_index = walkingSprite;
                        image_speed = 0.3;  
                    }
                    else
                    {
                        sprite_index = idleSprite;
                        image_speed = 0.4;
                    }
                }
                else
                {
                    if(xprevious != x)
                    {
                        sprite_index = walkingSprite;
                        image_speed = 0.3;  
                    }
                    else
                    {
                        sprite_index = idleSprite;
                        image_speed = 0.3;
                    }
                }
            }
        }
        
        
        if(bellyFull)
        {
            if(eatkey)
            {
                spit = true;
            }
            if(keyboard_check(vk_down) || (gamepad_axis_value(0,gp_axislv) > 0))
            {
                transforming = true;
            }
        }
    }
    else
    {
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
            sprite_index = spr_Salt_Hurt;
            control = false;
            hspd = -((spd * facing)*2);
            if(jumps > 0)
            {
                vspd = -jspd/2;
                jumps -= 1;
            } 
        }
        else if(doorIn)
        {
            sprite_index = spr_Salt_Entering;
            image_speed = 0.3;
        }
        else if(attacking)
        {
            scr_Attack1Controller(formID);
        }
        else if(jumps = 0)
        {
            sprite_index = jumpingSprite;
            if(vspd < 0)
            {
                
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
            if(xprevious != x)
            {
                sprite_index = walkingSprite;
                image_speed = 0.3;  
            }
            else
            {
                sprite_index = idleSprite;
                image_speed = 0.3;
            }
        }
        
        if(eatkey && !attacking)
        {
            attacking = true;
        }
    
    }
    
    
    // Controlar a direção que o personagem está virado
    
    if(facing = 1)
    {
        image_xscale=1;  
    } 
    else if(facing = -1)
    {
        image_xscale=-1;
    }
}
