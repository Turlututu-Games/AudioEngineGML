/// @desc Set the moods for the current multi-track music
/// @param {Enum.AE_MULTITRACK_MOOD,Array<Enum.AE_MULTITRACK_MOOD>} _mood New mood. Can be an array to play multiple mood track on the same time
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @param {Real} [_crossfadeTime] Optional crossfade value. Default to __AUDIOENGINE_MUSIC_DEFAULT_FADE
// Feather ignore once GM1045
function AudioEngineMusicMoodSet(_mood, _category = 0, _crossfadeTime = __AUDIOENGINE_MUSIC_DEFAULT_FADE) {
	// Feather ignore once GM1041 The enum value is correct
	var _currentMusic = __AEMusicGetCurrentMusic(_category);
			
	if(is_array(_mood)) {
		_currentMusic.moods = _mood;
	} else {
		_currentMusic.moods = [_mood];
	}

	var _bus = __AEBusGet(__AUDIOENGINE_PREFIX_MUSIC, _category);
	
	if(_currentMusic.id != -1 && _currentMusic.multi) {
		for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
			var _track = _currentMusic.tracks[_i];
			var _volume = __AEMusicResolveVolume(_category, _track, _bus);
			
			if(array_get_index(_currentMusic.moods, _track.mood) == -1) {
				audio_sound_gain(_track.ref, 0, _crossfadeTime);
			} else {
				audio_sound_gain(_track.ref, _volume, _crossfadeTime);
			}			
			
		}	
	}
}
