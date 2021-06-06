// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function tile_meeting(x,y,layer)
/// @param x
/// @param y
/// @param layer
function tile_meeting(_x, _y, _layer){
	var _tm = layer_tilemap_get_id(_layer);
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x -x),y),
	var _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y -y)),
	var _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x -x),y),
	var _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y -y));
	
	for(var x_temp = _x1; x_temp <= _x2; x_temp++){
		for(var y_temp = _y1; y_temp <= _y2; y_temp++){
			if(tile_get_index(tilemap_get(_tm, x_temp, y_temp))){
				return true;
			}
		}
	}
	return false;
}