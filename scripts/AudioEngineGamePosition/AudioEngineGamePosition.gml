/// @desc Change the position of an emetter
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} [_z] Z position. Default to 0
function AudioEngineGamePosition(_ref, _x, _y, _z = 0){
	// If it's a real value, it means we receive the Id.Sound instead of Played reference
	if(is_real(_ref)) {
		var _sound = __AESystemFindSound(_ref);
	
		if(_sound != undefined) {
			__AEGamePositionFound(_sound, _x, _y, _z);	
		}
	} else {
		__AEGamePositionFound(_ref, _x, _y, _z);
	}
}

/// @desc Change the position of an emetter to match an object
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @param {Id.Instance,Asset.GMObject} _instance Object instance used to get the position
/// @param {Real} [_z] Z position. Default to 0
function AudioEngineGamePositionAtObject(_ref, _instance, _z) {
	AudioEngineGamePosition(_ref, _instance.x, _instance.y, _z);
}
