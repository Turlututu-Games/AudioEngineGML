function __AEUIGamePlay(_gameSoundInstance, _category, _id, _x, _y, _z, _volumeOffset, _pitchOffset) {
	static _system = __AudioEngineSystem();
	
	var _newSound = __AudioEngineLibraryGameSoundGet(_gameSoundInstance);
	
	if(!_newSound) {
		// The sound does not exists! Log it
		show_debug_message("Invalid game sound id: {0}", _gameSoundInstance);
		return;	
	}	
	
	var _busName = $"static-{_category}";
	
	if(_newSound.spatialized) {
		_busName = $"spatial-{_id}-{_category}"
	} 
	
	var _bus = __AEBusGet(_busName);
	
	if(_newSound.spatialized) {
		audio_emitter_position(_bus.emitter, _x, _y, _z);
	} 
	
	if(_newSound.multi) {
		return __AEGamePlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus, _busName);
	}
	
	return __AEGamePlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus, _busName);
	
}

/// @desc Play a new game sound from an array
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Struct.__AESystemLibrarySoundArray} _newSound
/// @param {Struct.__AEBus} _bus
/// @param {String} _prefix
function __AEGamePlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus, _prefix) {
	static _system = __AudioEngineSystem();
	
		
	var _index = irandom_range(0, array_length(_newSound.assets) - 1);
	var _selectedAsset = _newSound.assets[_index];
	var _sound = __AEStreamReturnAsset(_selectedAsset);
		
	var _ref = __AEGamePlaySound(_sound, _bus, _newSound.loop, _newSound.volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

	var _playing = new __AESystemPlaying(_selectedAsset.asset, _ref, _prefix, _newSound.spatialized);

	array_push(_system.playing, _playing);
	
	return _playing;

}


/// @desc Play a new game sound from an single track
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Struct.__AESystemLibrarySound} _newSound
/// @param {Struct.__AEBus} _bus
/// @param {String} _prefix
function __AEGamePlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus, _prefix) {
	static _system = __AudioEngineSystem();
			
	var _sound = __AEStreamReturnAsset(_newSound);
		
	var _ref = __AEGamePlaySound(_sound, _bus, _newSound.loop, _newSound.volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

	var _playing = new __AESystemPlaying(_newSound.asset, _ref, _prefix, _newSound.spatialized);

	array_push(_system.playing, _playing);

	return _playing;
}

/// @desc Play the prepared sound
/// @param {Asset.GMSound} _sound
/// @param {Struct.__AEBus} _bus
/// @param {Bool} _loop
/// @param {Real} _volume
/// @param {Real} _pitch
/// @param {Real} _volumeVariance
/// @param {Real} _pitchVariance
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Real} _priority
function __AEGamePlaySound(_sound, _bus, _loop, _volume, _pitch, _volumeVariance, _pitchVariance, _volumeOffset, _pitchOffset, _priority) {
		
		var _baseVolume = _volume;
		var _basePitch = _pitch;
		
		if(_volumeVariance > 0) {
			_baseVolume += random_range(-_volumeVariance, _volumeVariance);
		}
		
		if(_pitchVariance > 0) {
			_basePitch += random_range(-_pitchVariance, _pitchVariance);
		}
		
		_baseVolume += _volumeOffset;
		_basePitch += _pitchOffset;
		
		return audio_play_sound_on(_bus.emitter, _sound, _loop, _priority, _baseVolume, 0, _basePitch);	
}

/// @desc Play a new game sound from an single track
/// @param {Id.Sound} _ref
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @return {Struct.__AESystemPlaying,Undefined}
function __AEGameFindSound(_ref, _category) {
	static _system = __AudioEngineSystem();
			
	var _playingLength = array_length(_system.playing);
	
	var _found = undefined;
	
	for(var _i = 0; _i < _playingLength; _i++) {
		_playing = _system.playing[_i];
		
		if(_playing.ref == _ref) {
			_found = _playing;
			break;
		}
	}
	
	return _found
}
