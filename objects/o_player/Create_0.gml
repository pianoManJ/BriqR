/// @description Setup of player character
//debug mode variable
d_mode_on = false;
input_d_mode = false;

//position variables
exact_x = xstart;
exact_y = ystart;

//movement variables
h_spd = 0;
v_spd = 0;
slow_down = 0.1;
brake_acc = 0.15;
speed_up_ground = 0.1;
grav =  0.5;
jump_spd = -2;
ground_cap = 5;
air_cap_soft = 5;
air_cap_hard = 15;
added_air_speed = 0;

//state checks
grounded_before = true;
is_grounded = true;
jump_held = false;

//input checks
input_left = false; //lateral controls
input_right = false;
input_jump_press = false; //jump controls
input_jump_down = false;
input_brake = false; //charge and ignite controls
input_ignite = false;

//heat and charge
briq_temp_MAX = 200;
briq_charge_MAX = 8;
briq_temp = 0;
briq_charge = 0;
can_long_jump = false;