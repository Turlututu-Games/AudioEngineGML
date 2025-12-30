/// @desc Play a new ui sound
/// @param {Enum.AUDIO_UI_SOUND} _uiSoundInstance
/// @param {Enum.AUDIO_CATEGORIES} _category
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
function __AEUIPlay(_uiSoundInstance, _category, _volumeOffset, _pitchOffset) {
	static _system = __AudioEngineSystem();
	
	var _newSound = __AudioEngineLibraryUISoundGet(_uiSoundInstance);
	
	if(!_newSound) {
		// The sound does not exists! Log it
		show_debug_message("Invalid ui sound id: {0}", _uiSoundInstance);
		return;	
	}	
	
	var _bus = __AEBusGet($"ui-{_category}");
	
	if(_newSound.multi) {
		__AEUIPlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus);
	} else {
		__AEUIPlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus);
	}
}

/// @desc Play a new ui sound from an array
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Struct.__AESystemLibrarySoundArray} _newSound
/// @param {Struct.__AEBus} _bus
function __AEUIPlayMulti(_volumeOffset, _pitchOffset, _newSound, _bus) {
	static _system = __AudioEngineSystem();
	
		
	var _index = irandom_range(0, array_length(_newSound.assets) - 1);
	var _selectedAsset = _newSound.assets[_index];
	var _sound = __AEStreamReturnAsset(_selectedAsset);
		
	var _ref = __AEUIPlaySound(_sound, _bus, _newSound.volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

	array_push(_system.playing, new __AESystemPlaying(_selectedAsset.asset, _ref, "ui"));

}

/// @desc Play a new ui sound from an single track
/// @param {Real} _volumeOffset
/// @param {Real} _pitchOffset
/// @param {Struct.__AESystemLibrarySound} _newSound
/// @param {Struct.__AEBus} _bus
function __AEUIPlaySingle(_volumeOffset, _pitchOffset, _newSound, _bus) {
	static _system = __AudioEngineSystem();
			
	var _sound = __AEStreamReturnAsset(_newSound);
		
	var _ref = __AEUIPlaySound(_sound, _bus, _newSound.volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

	array_push(_system.playing, new __AESystemPlaying(_newSound.asset, _ref, "ui"));

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