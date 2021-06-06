/// @description Handles actions of player character
//input checks
input_left = keyboard_check(ord("A"));
input_right = keyboard_check(ord("D"));

//horizontal movement
if(input_left){
	h_spd -= 0.1;
}else if(input_right){
	h_spd += 0.1;
}else{
	h_spd = 0;
}

x += h_spd