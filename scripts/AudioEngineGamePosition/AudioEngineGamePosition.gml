/// @desc Change the position of an emetter
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} [_z] Z position. Default to 0
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineGamePosition(_ref, _x, _y, _z, _category){
	// If it's a real value, it means we receive the Id.Sound instead of Played reference
	if(is_real(_ref)) {
		var _sound = __AEGameFindSound(_ref, _category);
	
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
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineGamePositionAtObject(_ref, _instance, _z, _category) {
	AudioEngineGamePosition(_ref, _instance.x, _instance.y, _z, _category);
}


/// @desc Set the position for an object
/// @param {Struct.__AESystemPlaying} _sound Sound playing
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} _z Z position
function __AEGamePositionFound(_sound, _x, _y, _z) {
		if(!_sound.spatialized) {
			// The sound is not spatialized
			return
		}

		var _bus = __AEBusGet(_sound.busName);

		audio_emitter_position(_bus.emitter, _x, _y, _z);

}