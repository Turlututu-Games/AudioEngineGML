/// @desc Stop a sound currently playing
/// @param {Struct.__AESystemPlaying} _sound Sound playing
/// @return {Undefined}
function __AEStop(_sound) {
    audio_stop_sound(_sound.ref);
}

/// @desc Stop a sound by ref
/// @param {Id.Sound,Struct.__AESystemPlaying} _ref Sound reference
/// @return {Undefined}
function __AEStopByRef(_ref) {

    // If it's a real value, it means we receive the Id.Sound instead of Played reference
    if(is_real(_ref)) {
        var _sound = __AESystemFindSound(_ref);

        if(_sound != undefined) {
            __AEStop(_sound)
        }
    } else {
        __AEStop(_ref)
    }

}