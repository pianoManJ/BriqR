/// @description Insert description here
// You can write your code in this editor
if(d_mode_on){
	draw_set_font(d_font);
	draw_set_color(c_black);
	draw_text(8,8,"Player Position: "+string(x)+" "+string(y));
	draw_text(8,20,"Player horizontal speed: "+string(h_spd));
	draw_text(8,32,"Player vertical speed: "+string(v_spd));
	draw_text(8,44,"Player Temperature: "+string(briq_temp)+" / "+string(briq_temp_MAX));
	draw_text(8,56,"Player Charges: "+string(briq_charge)+" / "+string(briq_charge_MAX));
	draw_text(8,68,"h_axis: " +string(h_axis));
	draw_text(8,80,"grounded: " +string(is_grounded));
	draw_text(8,92, "window size: "+string(window_get_width())+"x"+string(window_get_height()));
	draw_text(8,104, "JUST BRAKE POSSIBLE: " + string(just_brake));
	draw_text(8,116, "JUMP LENIENCY POSSIBLE: " + string(jump_leniency));
	draw_text(8,128, "Room: " + room_get_name(room));
	draw_text(8,140, "Sub-room: "+string(find_subroom(x, y, o_game.sub_rooms)));
}

space = 48;
charge_pos = window_get_width()*2/3;

//Charge count
for(var i = 1; i<=8; i++){
	if (i <= briq_charge){
		draw_sprite_stretched(charge, 0, charge_pos, 24, 32, 32);
	}
	charge_pos += space;
}
//temp base
draw_sprite(heat_guage_base, 0, window_get_width()*2/3, 68);
draw_sprite_stretched(heat_gauge, 0, window_get_width()*2/3, 68, 256*(briq_temp/briq_temp_MAX), 32);