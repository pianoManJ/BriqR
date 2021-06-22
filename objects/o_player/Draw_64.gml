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
}