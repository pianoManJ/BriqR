/// @description Handles actions of player character
//input checks
input_left = keyboard_check(ord("A"));
input_right = keyboard_check(ord("D"));
input_jump_press = keyboard_check_pressed(ord("J"));
input_jump_down = keyboard_check(ord("J"));

//horizontal movement
if(input_left){
	h_spd -= speed_up_ground;
}else if(input_right){
	h_spd += speed_up_ground;
}else{
	if(sign(h_spd) != sign(h_spd+sign(-0.1*sign(h_spd)))){
		h_spd = 0;
	}else{
		h_spd += -0.1*sign(h_spd);
	}
}

//vertical movement
v_spd += grav;

//jump logic
if(input_jump_press && is_grounded){//logic for starting jump from ground
	v_spd = jump_spd;
}

var will_collide_x = tile_meeting(round(x+h_spd), y, "Tiles_1");
var will_collide_y = tile_meeting(x, round(y+v_spd), "Tiles_1");
//show_debug_message(string(will_collide_x));

//is_grounded check, sets vertical speed to zero when grounded
if(tile_meeting(x, round(y+(-1*abs(v_spd))), "Tiles_1")){
	is_grounded = true;
	v_spd = 0;
}else{
	is_grounded = false;
}

//position calculations.
if(will_collide_x){//x position calculations
	var i = sign(h_spd);
	h_spd=0;
	while(!tile_meeting(x+i, y, "Tiles_1")){
		x += i;
		exact_x = x;
	}
}else{
	exact_x += h_spd;
	x = round(exact_x);
}
if(will_collide_y){ //y position calculations
	var i = sign(v_spd);
	v_spd=0;
	while(!tile_meeting(x, y+i, "Tiles_1")){
		y += i;
		exact_y = y;
	}
	show_debug_message("collided - y: "+ string(y));
}else{
	exact_y += v_spd;
	y = round(exact_y);
	show_debug_message("y_position: "+ string(y));
}