/// @desc Stop the current music
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_crossfadeTime] Optional crossfade value. Default to __AUDIOENGINE_MUSIC_DEFAULT_FADE
function AudioEngineMusicStop(_category = 0, _crossfadeTime = __AUDIOENGINE_MUSIC_DEFAULT_FADE) {
	
	__AEMusicGetCurrentMusic(_category);
	
	if(_crossfadeTime <= 0) {
		__AEMusicStop(_category);
		
		// Erase data from currentMusics store
		__AEMusicResetCurrentMusic(_category)
	
		// Clear the audio bus
		__AEBusClear($"{__AUDIOENGINE_PREFIX_MUSIC}-{_category}");		
	} else {
		__AEMusicStopWithFade(_category, _crossfadeTime);
	}
	

}
