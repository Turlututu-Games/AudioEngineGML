/// @desc Pause a game sound
/// @module Game
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function AudioEngineGamePause(_ref) {
    //Simply call the generic method
    __AEPauseByRef(_ref);
}

/// @desc Pause all game static sounds from a category
/// @module Game
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045 The enum name cannot be known here
function AudioEngineGamePauseCategory(_category = 0) {
    // Feather ignore once GM1041 The enum value is correct
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME, _category);

    array_foreach(_filtered, __AEPause);

}

/// @desc Pause all game static sounds
/// @module Game
/// @return {Undefined}
function AudioEngineGamePauseAllStatic() {
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_STATIC_GAME);

    array_foreach(_filtered, __AEPause);

}

/// @desc Pause all game spatialized sounds
/// @module Game
/// @return {Undefined}
function AudioEngineGamePauseAllSpatialized() {
    var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME);

    array_foreach(_filtered, __AEPause);

}

/// @desc Pause all game sounds
/// @module Game
/// @return {Undefined}
function AudioEngineGamePauseAll() {
    AudioEngineGamePauseAllStatic();
    AudioEngineGamePauseAllSpatialized();
}
