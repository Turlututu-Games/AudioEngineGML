/// @desc Stop a sound
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineGameStop(_ref, _category = 0) {
	
	// If it's a real value, it means we receive the Id.Sound instead of Played reference
	if(is_real(_ref)) {
		var _sound = __AEGameFindSound(_ref, _category);
	
		if(_sound != undefined) {
			__AEGameStopFound(_sound)	
		}
	} else {
		__AEGameStopFound(_ref)	
	}
	

}

/// @desc Stop a sound currently playing
/// @param {Struct.__AESystemPlaying} _sound Sound playing
function __AEGameStopFound(_sound) {

		audio_stop_sound(_sound.ref);

		// Clear the audio bus
		//__AEBusClear(_sound.busName);		
}
