/// @desc Stop a game sound
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
function AudioEngineGameStop(_ref) {
	//Simply call the generic method
	__AEStopByRef(_ref);
}

/// @desc Stop game static sounds from a category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineGameStopCategory(_category = 0) {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME, _category);
	
	array_foreach(_filtered, __AEStop);
}

/// @desc Stop all game static sounds
function AudioEngineGameStopAllStatic() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME);
	
	array_foreach(_filtered, __AEStop);
}

/// @desc Stop all game spatialized sounds
function AudioEngineGameStopAllSpatialized() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME);
	
	array_foreach(_filtered, __AEStop);
}

/// @desc Stop all game sounds
function AudioEngineGameStopAll() {
	AudioEngineGameStopAllStatic();
	AudioEngineGameStopAllSpatialized();
}


