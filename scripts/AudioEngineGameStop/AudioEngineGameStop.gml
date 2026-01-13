/// @desc Stop a game sound
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function AudioEngineGameStop(_ref) {
    //Simply call the generic method
    __AEStopByRef(_ref);
}

/// @desc Stop game static sounds from a category
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineGameStopCategory(_category = 0) {
    // Feather ignore once GM1041 The enum value is correct
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME, _category);

    array_foreach(_filtered, __AEStop);
}

/// @desc Stop all game static sounds
/// @return {Undefined}
function AudioEngineGameStopAllStatic() {
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME);

    array_foreach(_filtered, __AEStop);
}

/// @desc Stop all game spatialized sounds
/// @return {Undefined}
function AudioEngineGameStopAllSpatialized() {
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME);

    array_foreach(_filtered, __AEStop);
}

/// @desc Stop all game sounds
/// @return {Undefined}
function AudioEngineGameStopAll() {
    AudioEngineGameStopAllStatic();
    AudioEngineGameStopAllSpatialized();
}
