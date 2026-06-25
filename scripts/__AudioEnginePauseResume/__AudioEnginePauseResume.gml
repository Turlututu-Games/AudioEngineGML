/// @desc Pause a sound currently playing
/// @private
/// @param {Struct.__AESystemPlaying} _sound Sound playing
/// @return {Undefined}
function __AEPause(_sound) {
    if(!audio_is_paused(_sound.ref)) {
        audio_pause_sound(_sound.ref);
    }
}

/// @desc Pause a sound currently playing by ref
/// @private
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function __AEPauseByRef(_ref) {
    var _sound = __AESystemResolveSound(_ref);

    if(_sound != undefined) {
        __AEPause(_sound);
    }
}

/// @desc Resume a sound
/// @private
/// @param {Struct.__AESystemPlaying} _sound Sound playing
/// @return {Undefined}
function __AEResume(_sound) {
    if(audio_is_paused(_sound.ref)) {
        audio_resume_sound(_sound.ref);
    }
}

/// @desc Resume a sound by ref
/// @private
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function __AEResumeByRef(_ref) {
    var _sound = __AESystemResolveSound(_ref);

    if(_sound != undefined) {
        __AEResume(_sound);
    }
}