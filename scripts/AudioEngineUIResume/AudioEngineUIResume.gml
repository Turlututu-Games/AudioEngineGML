/// @desc Resume a ui sound
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
function AudioEngineUIResume(_ref) {
	//Simply call the generic method
	__AEResumeByRef(_ref);
}

/// @desc Resume all ui sounds from a category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineUIResumeCategory(_category = 0) {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI, _category);
	
	array_foreach(_filtered, __AEResume);
}

/// @desc Pause all ui sounds
function AudioEngineUIResumeAll() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI);
	
	array_foreach(_filtered, __AEResume);

}
