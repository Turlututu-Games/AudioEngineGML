/// @desc Resume a game sound
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
function AudioEngineGameResume(_ref) {
	//Simply call the generic method
	__AEResumeByRef(_ref);
}

/// @desc Resume all game static sounds from a category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineGameResumeCategory(_category = 0) {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME, _category);
	
	array_foreach(_filtered, __AEResume);
	
}

/// @desc Resume all game static sounds
function AudioEngineGameResumeAllStatic() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME);
	
	array_foreach(_filtered, __AEResume);

}

/// @desc Resume all game spatialized sounds
function AudioEngineGameResumeAllSpatialized() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME);
	
	array_foreach(_filtered, __AEResume);

}

/// @desc Resume all game sounds
function AudioEngineGameResumeAll() {
	AudioEngineGameResumeAllStatic();
	AudioEngineGameResumeAllSpatialized();
}
