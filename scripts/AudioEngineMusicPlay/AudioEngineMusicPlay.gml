/// @desc Play a music, replacing existing one
/// @module Music
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Music?id=AudioEngineMusicPlay
/// @param {Enum.AE_MUSIC} _musicInstance Music key
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real,Undefined} [_volume] Initial volume. If not set, will use previous music volume, or 1
/// @param {Real} [_crossfadeTime] Optional crossfade value. Default to __AUDIOENGINE_MUSIC_DEFAULT_FADE
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineMusicPlay(_musicInstance, _category = 0, _volume = undefined, _crossfadeTime = __AUDIOENGINE_MUSIC_DEFAULT_FADE) {
    // Feather ignore once GM1041 The enum value is correct
    var _currentMusic = __AEMusicGetCurrentMusic(_category);

    // If the new track is the same than the old, do nothing
    if(_currentMusic.id == _musicInstance) {
        return;
    }

    var _previousMoods = _currentMusic.moods;

    if(_currentMusic.id != -1) {
        if(_crossfadeTime <= 0) {
            // Feather ignore once GM1041 The enum value is correct
            __AEMusicStop( _category);
        } else {
            // Feather ignore once GM1041 The enum value is correct
            __AEMusicStopWithFade(_category, _crossfadeTime);
        }
    }

    // Feather ignore once GM1041 The enum value is correct
    __AEMusicPlayWithFade(_musicInstance, _category, _crossfadeTime, _previousMoods, _volume);
}
