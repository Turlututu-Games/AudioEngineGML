/// @desc Stop a ui sound
/// @module UI
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-UI?id=AudioEngineUIStop
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function AudioEngineUIStop(_ref) {
    //Simply call the generic method
    __AEStopByRef(_ref);
}

/// @desc Stop ui sounds from a category
/// @module UI
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-UI?id=AudioEngineUIStopCategory
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineUIStopCategory(_category = 0) {
    // Feather ignore once GM1041 The enum value is correct
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI, _category);

    array_foreach(_filtered, __AEStop);
}

/// @desc Stop all ui sounds
/// @module UI
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-UI?id=AudioEngineUIStopAll
/// @return {Undefined}
function AudioEngineUIStopAll() {
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI);

    array_foreach(_filtered, __AEStop);
}
