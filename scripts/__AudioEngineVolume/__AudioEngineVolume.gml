/// @param {String} _type
/// @param {String} _volumeType
/// @param {Enum.AE_CATEGORIES} _category
/// @param {Struct.__AESystemPlaying} _sound
/// @param {Struct.__AEBus} [_busParam]
/// @return {Real} Calculated volume
function __AEVolumeResolve(_type, _volumeType, _category, _sound, _busParam = undefined) {
	static _system = __AudioEngineSystem();
	var _bus = _busParam ?? __AEBusGet(_type, _category);	
	
	var _baseVolume = _system.volumes[$ _volumeType];
	
	// Feather ignore once GM1019 Ignore invalid type error
	__AELogVerbose("Base volume", _system.volumes[$ _volumeType]);
	// Feather ignore once GM1019 Ignore invalid type error
	__AELogVerbose("Category volume", _bus.volume);
	// Feather ignore once GM1019 Ignore invalid type error
	__AELogVerbose("Sound volume", _sound.volume);
		
	_baseVolume *= _bus.volume;
	_baseVolume *= _sound.volume;	
	
	// Feather ignore once GM1019 Ignore invalid type error
	__AELogVerbose("Result volume", _baseVolume);
	
	return _baseVolume;
}

/// @param {String} _type
/// @param {String} _volumeType
/// @param {Enum.AE_CATEGORIES} _category
/// @param {Real} _newVolume
/// @return {Struct.__AEBus} Updated bus
function __AEVolumeUpdate(_type, _volumeType, _category, _newVolume) {
		static _system = __AudioEngineSystem();
		
		var _busName = $"{_type}-{_category}"
		var _bus = __AEBusGet(_busName);	

	
		_bus.volume = _newVolume;		
		_system.defaultBusVolumes[$ _busName] = _newVolume;
}