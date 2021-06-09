/// @description Setup of player character
show_debug_message("start y: "+string(ystart));

//position variables
exact_x = xstart;
exact_y = ystart;

//movement variables
h_spd = 0;
v_spd = 0;
slow_down = 0.1
speed_up_ground = 0.1;
grav =  0.5;
jump_spd = -2;

//state checks
is_grounded = true;
jump_held = false;

//input checks
input_left = false; //lateral controls
input_right = false;
input_jump_press = false; //jump controls
input_jump_down = false;
input_brake = false; //charge and ignite controls
input_ignite = false;