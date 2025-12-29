/// @desc Play a music, replacing existing one
/// @param {Enum.AUDIO_MUSIC} _musicInstance Music key
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_crossfadeTime] Optional crossfade value. Default to __AUDIOENGINE_MUSIC_DEFAULT_FADE
function AudioEngineMusicPlay(_musicInstance, _category = 0, _crossfadeTime = __AUDIOENGINE_MUSIC_DEFAULT_FADE) {
	var _currentMusic = __AEMusicGetCurrentMusic(_category);
	
	// If the new track is the same than the old, do nothing
	if(_currentMusic.id == _musicInstance) {
		return;	
	}
	
	var _previousMoods = _currentMusic.moods;
	
	if(!_currentMusic.id != -1) {
		if(_crossfadeTime <= 0) {
			__AEMusicStop( _category);
		} else {
			__AEMusicStopWithFade(_category, _crossfadeTime);
		}
	}
	
	__AEMusicPlayWithFade(_musicInstance, _category, _crossfadeTime, _previousMoods);
}
