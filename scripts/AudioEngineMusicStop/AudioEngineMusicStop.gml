/// @desc Stop the current music
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_crossfadeTime] Optional crossfade value. Default to __AUDIOENGINE_MUSIC_DEFAULT_FADE
// Feather ignore once GM1045
function AudioEngineMusicStop(_category = 0, _crossfadeTime = __AUDIOENGINE_MUSIC_DEFAULT_FADE) {
	
	// Feather ignore once GM1041 The enum value is correct
	__AEMusicGetCurrentMusic(_category);
	
	if(_crossfadeTime <= 0) {
		// Feather ignore once GM1041 The enum value is correct
		__AEMusicStop(_category);
		
		// Erase data from currentMusics store
		// Feather ignore once GM1041 The enum value is correct
		__AEMusicResetCurrentMusic(_category)
	
		// Clear the audio bus
		__AEBusClear($"{__AUDIOENGINE_PREFIX_MUSIC}-{_category}");		
	} else {
		// Feather ignore once GM1041 The enum value is correct
		__AEMusicStopWithFade(_category, _crossfadeTime);
	}
	

}
