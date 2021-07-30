// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function find_subroom(xx,yy,subrm)
/// @param xx
/// @param yy
/// @param subrm
function find_subroom(xx, yy, subrm){
	for(i=0; i < array_length(subrm); i++){
		if((xx > subrm[i].pos.xx) && (xx < (subrm[i].pos.xx + subrm[i].size.ww))){
			if((yy > subrm[i].pos.yy) && (yy < (subrm[i].pos.yy + subrm[i].size.hh))){
				return i;
			}
		}
	}
	return -1;
}