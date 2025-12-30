/// @desc Pause a game sound
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
function AudioEngineGamePause(_ref) {
	//Simply call the generic method
	__AEPauseByRef(_ref);
}

/// @desc Pause all game static sounds from a category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineGamePauseCategory(_category = 0) {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME, _category);
	
	array_foreach(_filtered, __AEPause);
	
}

/// @desc Pause all game static sounds
function AudioEngineGamePauseAllStatic() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME);
	
	array_foreach(_filtered, __AEPause);

}

/// @desc Pause all game spatialized sounds
function AudioEngineGamePauseAllSpatialized() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME);
	
	array_foreach(_filtered, __AEPause);

}

/// @desc Pause all game sounds
function AudioEngineGamePauseAll() {
	AudioEngineGamePauseAllStatic();
	AudioEngineGamePauseAllSpatialized();
}


