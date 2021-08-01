/// @description Insert description here
// You can write your code in this editor
var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);
var targetX;
var targetY;
var curr_sr;
if(instance_exists(o_player)){
	targetX = o_player.x - view_wport[0]/2;
	targetY = o_player.y - view_hport[0]/2;
	curr_sr = sub_rooms[find_subroom(o_player.x, o_player.y, sub_rooms)];
}else{
	targetX = camX;
	targetY = camY;
	curr_sr = sub_rooms[0];
}
show_debug_message(string(curr_sr.xx));
targetX = clamp(targetX, curr_sr.xx, (curr_sr.xx+curr_sr.ww)-view_wport[0]);
targetY = clamp(targetY, curr_sr.yy, (curr_sr.yy+curr_sr.hh)-view_hport[0]);

camX = lerp(camX, targetX, 0.1);
camY = lerp(camY, targetY, 0.1);

camera_set_view_pos(view_camera[0], camX, camY);