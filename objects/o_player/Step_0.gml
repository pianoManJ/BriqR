/// @description Handles actions of player character
//input checks
gamepad_slot = 0;
gp_num = gamepad_get_device_count();
for(var i = 0; i < gp_num; gamepad_slot ++){
	if(gamepad_is_connected(i)){
		gamepad_slot = i;
		break;
	}
}
h_axis = gamepad_axis_value(gamepad_slot, gp_axislh);
v_axis = gamepad_axis_value(gamepad_slot, gp_axislv);

input_left = keyboard_check(ord("A"))||gamepad_button_check(gamepad_slot, gp_padl)||(h_axis < -0.7);
input_right = keyboard_check(ord("D"))||gamepad_button_check(gamepad_slot, gp_padr)||(h_axis > 0.7);
input_jump_press = keyboard_check_pressed(ord("J"))||gamepad_button_check_pressed(gamepad_slot, gp_face1);
input_jump_down = keyboard_check(ord("J"))||gamepad_button_check(gamepad_slot, gp_face1);
input_brake = keyboard_check(ord("K"))||gamepad_button_check(gamepad_slot, gp_shoulderrb);
input_brake_press = keyboard_check_pressed(ord("K"))||gamepad_button_check_pressed(gamepad_slot, gp_shoulderrb);
input_ignite = keyboard_check_pressed(ord("H"))||gamepad_button_check_pressed(gamepad_slot, gp_face2);
input_d_mode = keyboard_check_pressed(vk_enter)||gamepad_button_check_pressed(gamepad_slot, gp_start);


//debug mode toggle
if(input_d_mode){
	d_mode_on = abs(d_mode_on-1); //should switch d_mode_on between true and false
}

/*----------HORIZONTAL MOVEMENT----------*/

//test subpixel movement (debug)
if(keyboard_check_pressed(ord("Q"))){
	exact_x -= 0.1
}
if(keyboard_check_pressed(ord("E"))){
	exact_x += 0.1
}

//inputs for left and right. will accelerate up to the speed cap
if(input_left){
	if(abs(h_spd)<=ground_cap||!is_grounded){
		h_spd -= speed_up_ground;
	}
}else if(input_right){
	if(abs(h_spd)<=ground_cap||!is_grounded){
		h_spd += speed_up_ground;
	}
//no directional inputs will slow the player to a halt
}else{
	if(sign(h_spd) != sign(h_spd+sign(-1*slow_down*sign(h_spd)))){
		h_spd = 0;
	}else{
		h_spd += -1*slow_down*sign(h_spd);
	}
}

//brake inputs
if(input_brake && is_grounded){
	if(sign(h_spd) != sign(h_spd+sign(-1 * brake_acc*sign(h_spd)))){
		h_spd = 0;
	}else{
		h_spd -= sign(h_spd)* brake_acc;
	}
	briq_temp += abs(h_spd);
}

if(input_brake_press && just_brake && h_spd != 0){
	briq_charge ++;
	just_brake = false;
	alarm_set(1,-1)
}

//speed cap checks
if(is_grounded){
	if(abs(h_spd) >= ground_cap){
		//h_spd = sign(h_spd)*ground_cap;
		if(sign(h_spd-(sign(h_spd)*ground_cap)) != sign((h_spd-(sign(h_spd)*speed_up_ground))-(sign(h_spd)*ground_cap))){
			h_spd = sign(h_spd)*ground_cap;
		}else{
			h_spd += -1*sign(h_spd)*speed_up_ground;
		}
	}
}else{
	if(abs(h_spd) >= air_cap_hard){
		h_spd = sign(h_spd)*air_cap_hard;
	}else if(abs(h_spd) >= air_cap_soft){
		h_spd = sign(h_spd)*air_cap_soft;
	}
}

/*----------VERTICAL MOVEMENT----------*/

v_spd += grav;

//ignite logic
if(input_ignite && briq_charge > 0){
	briq_charge -= 1;
	instance_create_layer(x,y,"instances",o_fire_t)
	if(is_grounded){
		if(h_spd != 0){
			h_spd += 3*sign(h_spd);
			can_long_jump = true;
			alarm_set(1, 40);
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

if(input_jump_press &&(is_grounded||jump_leniency)){//logic for starting jump from ground
	v_spd = jump_spd;
	jump_held = true;
	alarm_set(0, 20);
	jump_leniency = false; //cancels jump leniency
	alarm_set(2,-1);
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
//changes in grounded state
if(is_grounded != grounded_before){
	if(!is_grounded){
		air_cap_soft = abs(h_spd) + 5;//adjusts the soft air speed cap
		if(v_spd >= 0){
			jump_leniency = true; //activates jump leniency
			alarm_set(2, 7);
		}
	}else{
		just_brake = true;//allows player to perform a perfect brake
		alarm_set(1, 3);
	}
}

/*----------POSITION CALCULATIONS----------*/

//y position calculations
if(will_collide_y){ 
	var i = sign(v_spd);
	if(i<0){
		jump_held = false;
	}
	v_spd=0;
	while(!tile_meeting(x, y+i, "Tiles_1")){
		y += i;
		exact_y = y;
	}
}else{
	exact_y += v_spd;
	y = round(exact_y);
}

//x position calculations
var will_collide_x = tile_meeting(round(exact_x+h_spd), y, "Tiles_1");
if(will_collide_x){
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