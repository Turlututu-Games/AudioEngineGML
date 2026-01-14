/// @desc Pause a ui sound
/// @module UI
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function AudioEngineUIPause(_ref) {
    //Simply call the generic method
    __AEPauseByRef(_ref);
}

/// @desc Pause all ui sounds from a category
/// @module UI
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineUIPauseCategory(_category = 0) {
    // Feather ignore once GM1041 The enum value is correct
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI, _category);

    array_foreach(_filtered, __AEPause);

}

/// @desc Pause all ui sounds
/// @module UI
/// @return {Undefined}
function AudioEngineUIPauseAll() {
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI);

    array_foreach(_filtered, __AEPause);
}
