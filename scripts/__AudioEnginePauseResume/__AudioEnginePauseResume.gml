/// @desc Pause a sound currently playing
/// @param {Struct.__AESystemPlaying} _sound Sound playing
function __AEPause(_sound) {
	if(!audio_is_paused(_sound.ref)) {
		audio_pause_sound(_sound.ref);
	}
}

/// @desc Pause a sound currently playing by ref
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
function __AEPauseByRef(_ref) {
	
	// If it's a real value, it means we receive the Id.Sound instead of Played reference
	if(is_real(_ref)) {
		var _sound = __AESystemFindSound(_ref);
	
		if(_sound != undefined) {
			__AEPause(_sound)	
		}
	} else {
		__AEPause(_ref)	
	}

}

/// @desc Resume a sound
/// @param {Struct.__AESystemPlaying} _sound Sound playing
function __AEResume(_sound) {
	if(audio_is_paused(_sound.ref)) {
		audio_resume_sound(_sound.ref);
	}
}

/// @desc Resume a sound by ref
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
function __AEResumeByRef(_ref) {
	
	// If it's a real value, it means we receive the Id.Sound instead of Played reference
	if(is_real(_ref)) {
		var _sound = __AESystemFindSound(_ref);
	
		if(_sound != undefined) {
			__AEResume(_sound)	
		}
	} else {
		__AEResume(_ref)	
	}

}