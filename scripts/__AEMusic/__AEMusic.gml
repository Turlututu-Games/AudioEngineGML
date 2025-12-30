/// @desc Get Current Music
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @return {Struct.__AEMusicCurrentMusic}
function __AEMusicGetCurrentMusic(_category) {
	static _system = __AudioEngineSystem();
	
	if(_system.currentMusics[$ _category] == undefined) {
		_system.currentMusics[$ _category] = new __AEMusicCurrentMusic();
	}	
	
	return _system.currentMusics[$ _category];
}

/// @desc Reset Current Music
/// @param {Enum.AUDIO_CATEGORIES} _category
function __AEMusicResetCurrentMusic(_category) {
	static _system = __AudioEngineSystem();
	
	_system.currentMusics[$ _category] = new __AEMusicCurrentMusic();

}

/// @desc Directly Stop Current Music
/// @param {Enum.AUDIO_CATEGORIES} _category
function __AEMusicStop(_category) {
	var _currentMusic = __AEMusicGetCurrentMusic(_category);
	
	if(_currentMusic.id != -1) {
			
		if(_currentMusic.multi) {				
			for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
				var _track = _currentMusic.tracks[_i];
				
				audio_stop_sound(_track.asset);
			
			}		
		} else {
			audio_stop_sound(_currentMusic.tracks[0].asset);

		}
	}
}

/// @desc Stop crossfaded sounds
/// @param {Array<Id.Sound>} _crossfadedSounds
function __AEMusicStopCrossfaded(_crossfadedSounds) {
	
	var _unfaded = []
	
	
	// Stop fading sound with volume 0, store unfaded sounds
	for(var _i = 0; _i < array_length(_crossfadedSounds); _i++) {
		var _item = _crossfadedSounds[_i];
		var _sound = _item.ref;
		
		var _volume = audio_sound_get_gain(_sound);
		
		if(_volume == 0) {
			audio_stop_sound(_sound);	
		} else {
			array_push(_unfaded);
		}
	}
	
	return _unfaded;
}

/// @desc Stop Current Music with fade-out
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @param {Real} _fade
function __AEMusicStopWithFade(_category, _fade) {
		
	var _currentMusic = __AEMusicGetCurrentMusic(_category);

	
	if(_currentMusic.id != -1) {
		with(__oAudioEngineManager) {
			
			if(_currentMusic.multi) {
				for(var _i = 0; _i < array_length(_currentMusic.tracks); _i++) {
					var _track = _currentMusic.tracks[_i];
				
					audio_sound_gain(_track.ref, 0, _fade);
					array_push(crossfadedMusic, {ref: _track.ref, category: _category});

				}	
			} else {
				audio_sound_gain(_currentMusic.tracks[0].ref, 0, _fade);
				array_push(crossfadedMusic, {ref: _currentMusic.tracks[0].ref, category: _category});
			}
		
			var _seconds = (_fade / 1000) * 5;
			var _fps = game_get_speed(gamespeed_fps);
			var _frames = _seconds * game_get_speed(gamespeed_fps);
			
			show_debug_message("Triggering alarm for {0} seconds (fps: {1}, frames: {2})", _seconds, _fps, _frames)
			
			// Trigger the alarm for cleanup 5s after fadeout finish
			alarm_set(0, _seconds * game_get_speed(gamespeed_fps));
		}		
	}
}

/// @desc Play music with fade-in
/// @param {Enum.AUDIO_MUSIC} _musicInstance
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @param {Real} _fade
/// @param {Array<Enum.AUDIO_MULTITRACK_MOOD>} _previousMoods
function __AEMusicPlayWithFade(_musicInstance, _category, _fade, _previousMoods) {
	
	static _system = __AudioEngineSystem();
	
	var _newMusic = __AEMusicLibraryGetSound(_musicInstance);
		
	if(!_newMusic) {
		// The music does not exists! Log it
		show_debug_message("Invalid music id: {0}", _musicInstance);
		return;	
	}	
	
	var _bus = __AEBusGet($"{__AUDIOENGINE_PREFIX_MUSIC}-{_category}");			
		
	if(_newMusic.multi) {
		__AEMusicPlayMultiTrackWithFade(_musicInstance, _category, _fade, _previousMoods, _newMusic, _bus);
	} else {
		__AEMusicPlaySingleTrackWithFade(_musicInstance, _category, _fade, _newMusic, _bus);
	}
}

/// @desc Play multi-track music with fade-in
/// @param {Enum.AUDIO_MUSIC} _musicInstance
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @param {Real} _fade
/// @param {Array<Enum.AUDIO_MULTITRACK_MOOD>} _previousMoods
/// @param {Struct.__AESystemLibraryMusicMulti} _newMusic
/// @param {Struct.__AEBus} _bus
function __AEMusicPlayMultiTrackWithFade(_musicInstance, _category, _fade, _previousMoods, _newMusic, _bus) {
	static _system = __AudioEngineSystem();
	
	var _currentMusic = new __AEMusicCurrentMusic(_musicInstance, [], true, _previousMoods);		
			
	for(var _i = 0; _i < array_length(_newMusic.assets); _i++) {
		var _music = _newMusic.assets[_i];
				
		var _musicAsset = __AEStreamReturnAsset(_music);

		var _ref = audio_play_sound_on(_bus.emitter, _musicAsset, true, _newMusic.priority);
			
		array_push(_system.playing, new __AESystemPlaying(_music.asset, _ref, __AUDIOENGINE_PREFIX_MUSIC));
			
		array_push(_currentMusic.tracks, new __AEMusicCurrentMusicTrack(_musicAsset, _music.isStream, _music.mood, _music.volume, _ref) );

		if(array_get_index(_currentMusic.moods, _music.mood) == -1) {
			audio_sound_gain(_ref, 0, 0);
		} else {
			if(_fade > 0) {
				// Immediate start at volume 0 then go to wanted volume on fade time
				audio_sound_gain(_ref, 0, 0);
				audio_sound_gain(_ref, _music.volume, _fade);				
			} else {
				audio_sound_gain(_ref, _music.volume, 0);	
			}
		}
	}
							
	_system.currentMusics[$ _category] = _currentMusic;			
}

/// @desc Play single-track music with fade-in
/// @param {Enum.AUDIO_MUSIC} _musicInstance
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @param {Real} _fade
/// @param {Struct.__AESystemLibraryMusicSingle} _newMusic
/// @param {Struct.__AEBus} _bus
function __AEMusicPlaySingleTrackWithFade(_musicInstance, _category, _fade, _newMusic, _bus) {
	static _system = __AudioEngineSystem();

	var _music = __AEStreamReturnAsset(_newMusic);

	var _ref = audio_play_sound_on(_bus.emitter, _music, true, _newMusic.priority);
		
	if(_fade > 0) {
		audio_sound_gain(_ref, 0, 0);
		audio_sound_gain(_ref, _newMusic.volume, _fade);
	} else {
		audio_sound_gain(_ref, _newMusic.volume, 0);
	}
		
	array_push(_system.playing, new __AESystemPlaying(_newMusic.asset, _ref, __AUDIOENGINE_PREFIX_MUSIC));
			
	var _currentMusic = new __AEMusicCurrentMusic(_musicInstance);
	_currentMusic.tracks = [new __AEMusicCurrentMusicTrack(_music, _newMusic.isStream, 0, _newMusic.volume, _ref)];
	_currentMusic.multi = false;
			
	_system.currentMusics[$ _category] = _currentMusic;
			
	
}

/// @desc Current Music Track
/// @param {Asset.GMSound,String} _asset
/// @param {Bool} _isStream
/// @param {Enum.AUDIO_MULTITRACK_MOOD} _mood
/// @param {Real} _volume
/// @param {Id.Sound} _ref
function __AEMusicCurrentMusicTrack(_asset = noone, _isStream = false, _mood = 0, _volume = 1, _ref = noone) constructor {
	asset = _asset;
	isStream = _isStream;
	mood = _mood;
	volume = _volume;
	ref = _ref;
}

/// @desc Current Music
/// @param {Enum.AUDIO_MUSIC} _id
/// @param {Array<Struct.__AEMusicCurrentMusicTrack>} _tracks
/// @param {Bool} _multi
/// @param {Array<Enum.AUDIO_MULTITRACK_MOOD>} _moods
function __AEMusicCurrentMusic(_id = -1, _tracks = [], _multi = false, _moods = [0]) constructor {
	id = _id;
	tracks = _tracks
	multi = _multi;	
	moods = _moods;
	
	// Ensure mood 0 is set if moods are empty
	if(array_length(moods) == 0) {
		array_push(moods, 0)	
	}
}

/// @desc Get a music library item
/// @param {Enum.AUDIO_MUSIC} _musicInstance
/// @return {Struct.__AESystemLibraryMusicSingle,Struct.__AESystemLibraryMusicMulti}
function __AEMusicLibraryGetSound(_musicInstance) {
	static _system = __AudioEngineSystem();
	
	return _system.library.music[$ _musicInstance];
}