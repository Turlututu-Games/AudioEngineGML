/// @desc Play a new ui sound
/// @param {Enum.AE_UI_SOUND} _uiSoundInstance
/// @param {Enum.AE_CATEGORIES} _category
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @return {Struct.__AESystemPlaying,Undefined} Sound reference
function __AEUIPlay(_uiSoundInstance, _category, _volumeOffset, _pitchOffset) {
	static _system = __AudioEngineSystem();
	
	// Feather ignore once GM1041 The enum value is correct
	var _newSound = __AEUILibraryGetSound(_uiSoundInstance);
	
	if(!_newSound) {
		// The sound does not exists! Log it
		// Feather ignore once GM1019 Ignore invalid type error
		__AELogError($"Invalid ui sound id: {_uiSoundInstance}");
		return;	
	}	
	
	var _bus = __AEBusGet(__AUDIOENGINE_PREFIX_UI, _category);
	
	if(_newSound.multi) {
		return __AEUIPlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus);
	} 
	
	return __AEUIPlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus);
}

/// @desc Play a new ui sound from an array
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Struct.__AESystemLibrarySoundArray} _newSound
/// @param {Struct.__AEBus} _bus
/// @return {Struct.__AESystemPlaying} Sound reference
function __AEUIPlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus) {
	static _system = __AudioEngineSystem();
	
		
	var _index = irandom_range(0, array_length(_newSound.assets) - 1);
	var _selectedAsset = _newSound.assets[_index];
	var _sound = __AEStreamReturnAsset(_selectedAsset);
	
	// Feather ignore once GM1041 The enum value is correct
	var _volume = __AEUIResolveVolume(_bus.category, _newSound, _bus)
		
	var _ref = __AEUIPlaySound(_sound, _bus, _volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

	var _playing = new __AESystemPlaying(_selectedAsset.asset, _ref, $"{__AUDIOENGINE_PREFIX_UI}-{_bus.category}", false, _newSound.volume);

	_system.playingMap[$ _ref] = _playing;
	array_push(_system.playing, _playing);
	
	return _playing;
}

/// @desc Play a new ui sound from an single track
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Struct.__AESystemLibrarySound} _newSound
/// @param {Struct.__AEBus} _bus
/// @return {Struct.__AESystemPlaying} Sound reference
function __AEUIPlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus) {
	static _system = __AudioEngineSystem();
			
	var _sound = __AEStreamReturnAsset(_newSound);
		
	// Feather ignore once GM1041 The enum value is correct
	var _volume = __AEUIResolveVolume(_bus.category, _newSound, _bus)		
		
	var _ref = __AEUIPlaySound(_sound, _bus, _volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

	var _playing = new __AESystemPlaying(_newSound.asset, _ref, $"{__AUDIOENGINE_PREFIX_UI}-{_bus.category}", false, _newSound.volume);

	_system.playingMap[$ _ref] = _playing;
	array_push(_system.playing, _playing);
	
	return _playing;
}

/// @desc Play the prepared sound
/// @param {Asset.GMSound} _sound
/// @param {Struct.__AEBus} _bus
/// @param {Real} _volume
/// @param {Real} _pitch
/// @param {Real} _volumeVariance
/// @param {Real} _pitchVariance
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Real} _priority
/// @return {Id.Sound}
function __AEUIPlaySound(_sound, _bus, _volume, _pitch, _volumeVariance, _pitchVariance, _volumeOffset, _pitchOffset, _priority) {
		
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
		
	return audio_play_sound_on(_bus.emitter, _sound, false, _priority, _baseVolume, 0, _basePitch);	
}

/// @desc Get a ui sound library item
/// @param {Enum.AE_UI_SOUND} _uiSoundInstance
/// @return {Struct.__AESystemLibrarySound,Struct.__AESystemLibrarySoundArray}
function __AEUILibraryGetSound(_uiSoundInstance) {
	static _system = __AudioEngineSystem();
	
	// Feather ignore once GM1045
	return _system.library.ui[$ _uiSoundInstance];
}

/// @param {Enum.AE_CATEGORIES} _category
/// @param {Struct.__AEBus} _bus
function __AEUIUpdateVolume(_category, _bus) {	
	// Feather ignore once GM1041 The enum value is correct
	var _filtered = __AESystemFilterSoundByTypeAndCategory(__AUDIOENGINE_PREFIX_UI, _category);
	
	
	for(var _i = 0; _i < array_length(_filtered); _i++) {
		var _currentSound = _filtered[_i];
		// Feather ignore once GM1041 The enum value is correct
		var _volume = __AEUIResolveVolume(_category, _currentSound, _bus);
			
	
		audio_sound_gain(_currentSound.ref, _volume, 0);
				
			
	}		
}

/// @param {Enum.AE_CATEGORIES} _category
/// @param {Struct.__AESystemPlaying} _sound
/// @param {Struct.__AEBus} [_busParam]
function __AEUIResolveVolume(_category, _sound, _busParam = undefined) {
	// Feather ignore once GM1041 The enum value is correct
	return __AEVolumeResolve(__AUDIOENGINE_PREFIX_UI, "ui", _category, _sound, _busParam);
}
