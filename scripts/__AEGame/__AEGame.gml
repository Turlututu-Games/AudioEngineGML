/// @desc Play a game sound
/// @param {Enum.AUDIO_GAME_SOUND} _gameSoundInstance Sound key
/// @param {Enum.AUDIO_CATEGORIES,Real} _id Id for the category or position
/// @param {Real} _x
/// @param {Real} _y
/// @param {Real} _z
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Array<Struct.AudioEffect>} _effects
/// @return {Struct.__AESystemPlaying} Sound reference
function __AEGamePlay(_gameSoundInstance, _id, _x, _y, _z, _volumeOffset, _pitchOffset, _effects) {
	static _system = __AudioEngineSystem();
	
	var _newSound = __AEGameLibraryGetSound(_gameSoundInstance);
	
	if(!_newSound) {
		// The sound does not exists! Log it
		show_debug_message("Invalid game sound id: {0}", _gameSoundInstance);
		return;	
	}	
	
	var _busName = $"{__AUDIOENGINE_PREFIX_STATIC_GAME}-{_id}";
	
	if(_newSound.spatialized) {
		_busName = $"{__AUDIOENGINE_PREFIX_SPATIALIZED_GAME}-{_id}"
	} 
	
	var _bus = __AEBusGet(_busName);
	
	if(_newSound.spatialized) {
		audio_emitter_position(_bus.emitter, _x, _y, _z);
	} 
	
	if(array_length(_effects) > 0) {
		__AEBusEffectsSet(_effects, _busName);
	}
	
	if(_newSound.multi) {
		return __AEGamePlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus, _busName);
	}
	
	return __AEGamePlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus, _busName);
	
}

/// @desc Play a game sound from an array
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Struct.__AESystemLibrarySoundArray} _newSound
/// @param {Struct.__AEBus} _bus
/// @param {String} _prefix
/// @return {Struct.__AESystemPlaying} Sound reference
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


/// @desc Play a game sound from an single track
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Struct.__AESystemLibrarySound} _newSound
/// @param {Struct.__AEBus} _bus
/// @param {String} _prefix
/// @return {Struct.__AESystemPlaying} Sound reference
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
/// @return {Id.Sound}
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

/// @desc Set the position for an object
/// @param {Struct.__AESystemPlaying} _sound Sound playing
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} _z Z position
function __AEGamePositionFound(_sound, _x, _y, _z) {
		if(!_sound.spatialized) {
			// The sound is not spatialized
			return
		}

		var _bus = __AEBusGet(_sound.busName);

		audio_emitter_position(_bus.emitter, _x, _y, _z);

}

/// @desc Get a game sound library item
/// @param {Enum.AUDIO_GAME_SOUND} _gameSoundInstance
/// @return {Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray}
function __AEGameLibraryGetSound(_gameSoundInstance) {
	static _system = __AudioEngineSystem();
	
	return _system.library.game[$ _gameSoundInstance];
}