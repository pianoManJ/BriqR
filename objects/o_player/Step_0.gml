/// @description Handles actions of player character
//input checks
input_left = keyboard_check(ord("A"));
input_right = keyboard_check(ord("D"));
input_jump_press = keyboard_check_pressed(ord("J"));
input_jump_down = keyboard_check(ord("J"));
input_brake = keyboard_check(ord("K"));
input_ignite = keyboard_check_pressed(ord("H"));
input_d_mode = keyboard_check_pressed(vk_enter);

//debug mode toggle
if(input_d_mode){
	d_mode_on = abs(d_mode_on-1); //should switch d_mode_on between true and false
}

//horizontal movement

//test subpixel movement (debug)
if(keyboard_check_pressed(ord("Q"))){
	exact_x -= 0.1
}
if(keyboard_check_pressed(ord("E"))){
	exact_x += 0.1
}

if(input_left){
	h_spd -= speed_up_ground;
}else if(input_right){
	h_spd += speed_up_ground;
}else{
	if(sign(h_spd) != sign(h_spd+sign(-1*slow_down*sign(h_spd)))){
		h_spd = 0;
	}else{
		h_spd += -1*slow_down*sign(h_spd);
	}
}

if(input_brake && is_grounded){
	if(sign(h_spd) != sign(h_spd+sign(-1 * brake_acc*sign(h_spd)))){
		h_spd = 0;
	}else{
		h_spd -= sign(h_spd)* brake_acc;
	}
	briq_temp += abs(h_spd);
}
if(is_grounded){
	if(abs(h_spd) >= ground_cap){
		h_spd = sign(h_spd)*ground_cap;
	}
}else{
	if(abs(h_spd) >= air_cap_hard){
		h_spd = sign(h_spd)*air_cap_hard;
	}else if(abs(h_spd) >= air_cap_soft){
		h_spd = sign(h_spd)*air_cap_soft;
	}
}
//vertical movement
v_spd += grav;
if(input_ignite && briq_charge > 0){
	briq_charge -= 1;
	if(is_grounded){
		if(h_spd != 0){
			can_long_jump = true;
			alarm_set(0, 40);
		}
	}else{
		v_spd = -5;
		jump_held = false;
		alarm_set(0, -1);
	}
}

//jump logic
if(input_jump_down && jump_held){
	v_spd = jump_spd;
}else{
	jump_held = false;
	alarm_set(0, -1);
}

if((input_jump_press && is_grounded)){//logic for starting jump from ground
	if(can_long_jump){
		v_spd = jump_spd*3;
		h_spd = sign(h_spd)*5;
		can_long_jump = false;
		jump_held = false;
		alarm_set(0, -1);
	}else{
		v_spd = jump_spd;
		jump_held = true;
		alarm_set(0, 20);
	}
}else if (jump_held){
	v_spd = jump_spd;
	jump_held = true;
}

var will_collide_y = tile_meeting(x, round(exact_y+v_spd), "Tiles_1");

//is_grounded check, sets vertical speed to zero when grounded
grounded_before = is_grounded;
if(v_spd > 0){ //check if Briquette is falling
	if(will_collide_y){
		is_grounded = true;
	}else{
		is_grounded = false;
	}
}else{
	is_grounded = false;
}
//soft air speed cap value calculation
if(is_grounded != grounded_before){
	if(!is_grounded){
		air_cap_soft = abs(h_spd) + 5;
	}
}

//position calculations.
if(will_collide_y){ //y position calculations
	var i = sign(v_spd);
	v_spd=0;
	while(!tile_meeting(x, y+i, "Tiles_1")){
		y += i;
		exact_y = y;
	}
}else{
	exact_y += v_spd;
	y = round(exact_y);
}

var will_collide_x = tile_meeting(round(exact_x+h_spd), y, "Tiles_1");
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

if(briq_temp >= briq_temp_MAX){
	briq_temp = 0;
	if(briq_charge < briq_charge_MAX){
		briq_charge += 1;
	}
}
