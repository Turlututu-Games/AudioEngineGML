function __AEUIPlay(_uiSoundInstance, _category, _volumeOffset, _pitchOffset) {
	static _system = __AudioEngineSystem();
	
	var _newSound = _system.library.ui[$ _uiSoundInstance];
	
	if(!_newSound) {
		// The sound does not exists! Log it
		show_debug_message("Invalid ui sound id: {0}", _uiSoundInstance);
		return;	
	}	
	
	var _bus = __AEBusGet($"ui-{_category}");
	
	if(_newSound.multi) {
		
		var _index = irandom_range(0, array_length(_newSound.assets) - 1);
		var _selectedAsset = _newSound.assets[_index];
		var _sound = __AEStreamReturnAsset(_selectedAsset);
		
		var _ref = __AEUIPlaySound(_sound, _bus, _newSound.volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

		array_push(_system.playing, new __AESystemPlaying(_selectedAsset.asset, _ref, "ui"));

	} else {
		
		var _sound = __AEStreamReturnAsset(_newSound);
		
		var _ref = __AEUIPlaySound(_sound, _bus, _newSound.volume, _newSound.pitch, _newSound.volumeVariance, _newSound.pitchVariance, _volumeOffset, _pitchOffset, _newSound.priority);

		array_push(_system.playing, new __AESystemPlaying(_newSound.asset, _ref, "ui"));
	}
}

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