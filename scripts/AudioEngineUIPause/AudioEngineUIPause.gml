/// @desc Pause a ui sound
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
function AudioEngineUIPause(_ref) {
	//Simply call the generic method
	__AEPauseByRef(_ref);
}

/// @desc Pause all ui sounds from a category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineUIPauseCategory(_category = 0) {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI, _category);
	
	array_foreach(_filtered, __AEPause);

}

/// @desc Pause all ui sounds
function AudioEngineUIPauseAll() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI);
	
	array_foreach(_filtered, __AEPause);
}
