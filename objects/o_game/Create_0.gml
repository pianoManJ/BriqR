/// @description Insert description here
// You can write your code in this editor
view_enabled = true;
view_visible[0] = true;
view_xport[0] = 0;
view_yport[0] = 0;
view_wport[0] = 320;
view_hport[0] = 192;
//set up a camera view
view_camera[0]= camera_create_view(0, 0, view_wport[0], view_hport[0], 0, o_player, -1, -1, 160, 96);
var _dwidth = display_get_width();
var _dheight = display_get_height();
var _xpos = (_dwidth /2) - 320*2;
var _ypos = (_dheight /2) -192*2;
window_set_rectangle(_xpos, _ypos, 320*4, 192*4);

surface_resize(application_surface, 320*4, 192*4);