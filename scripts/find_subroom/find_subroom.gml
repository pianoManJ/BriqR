// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function find_subroom(xx,yy,subrm)
/// @param xx
/// @param yy
/// @param subrm
function find_subroom(xx, yy, subrm){
	for(i=0; i < array_length(subrm); i++){
		if((xx >= subrm[i].xx) && (xx <= (subrm[i].xx + subrm[i].ww))){
			if((yy >= subrm[i].yy) && (yy <= (subrm[i].yy + subrm[i].hh))){
				return i;
			}
		}
	}
	return -1;
}