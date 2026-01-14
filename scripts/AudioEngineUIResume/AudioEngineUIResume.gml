/// @desc Resume a ui sound
/// @module UI
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function AudioEngineUIResume(_ref) {
    //Simply call the generic method
    __AEResumeByRef(_ref);
}

/// @desc Resume all ui sounds from a category
/// @module UI
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineUIResumeCategory(_category = 0) {
    // Feather ignore once GM1041 The enum value is correct
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI, _category);

    array_foreach(_filtered, __AEResume);
}

/// @desc Pause all ui sounds
/// @module UI
/// @return {Undefined}
function AudioEngineUIResumeAll() {
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI);

    array_foreach(_filtered, __AEResume);

}
