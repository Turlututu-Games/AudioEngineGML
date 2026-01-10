/// @desc Resume a ui sound
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
function AudioEngineUIResume(_ref) {
	//Simply call the generic method
	__AEResumeByRef(_ref);
}

/// @desc Resume all ui sounds from a category
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
// Feather ignore once GM1045
function AudioEngineUIResumeCategory(_category = 0) {
	// Feather ignore once GM1041 The enum value is correct
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI, _category);
	
	array_foreach(_filtered, __AEResume);
}

/// @desc Pause all ui sounds
function AudioEngineUIResumeAll() {
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI);
	
	array_foreach(_filtered, __AEResume);

}
