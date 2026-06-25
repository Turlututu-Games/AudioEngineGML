/// @desc Stop a sound currently playing
/// @private
/// @param {Struct.__AESystemPlaying} _sound Sound playing
/// @return {Undefined}
function __AEStop(_sound) {
    audio_stop_sound(_sound.ref);
}

/// @desc Stop a sound by ref
/// @private
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function __AEStopByRef(_ref) {
    var _sound = __AESystemResolveSound(_ref);

    if(_sound != undefined) {
        __AEStop(_sound);
    }
}