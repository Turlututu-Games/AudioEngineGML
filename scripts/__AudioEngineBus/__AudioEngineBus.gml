
/// @desc AudioEngine Bus Instance
/// @param {Id.AudioEmitter} _emitter Emitter
/// @param {Struct.AudioBus} _bus Audio Bus
/// @param {Real} _volume Volume offset
/// @param {Real} _category Bus category. Used for reverse search
function __AEBus(_emitter, _bus, _volume, _category) constructor {
	emitter = _emitter;
	bus = _bus;
	volume = _volume;
	category = _category;
}

/// @desc Set Main Listener position. All emitter from categories music, ui and static will move too
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} [_z] Z position. Optional
/// @return {Undefined}
function __AEBusSetListenerPosition(_x, _y, _z = 0) {
	static _system = __AudioEngineSystem();
	
	audio_listener_position(_x, _y, _z);
	
	_system.position.x = _x;
	_system.position.y = _y;
	_system.position.z = _z;
	
	var _busNames = struct_get_names(_system.bus);
	
	for(var _i = 0; _i < array_length(_busNames); _i++) {
		var _busName = _busNames[_i];
		
		if(
			string_starts_with(_busName, $"{__AUDIOENGINE_PREFIX_MUSIC}-") || 
			string_starts_with(_busName, $"{__AUDIOENGINE_PREFIX_UI}-") || 
			string_starts_with(_busName, $"{__AUDIOENGINE_PREFIX_STATIC_GAME}-"
		)) {
			var _bus = 	_system.bus[$ _busName];
			
			audio_emitter_position(_bus.emitter, _x, _y, _z);
		}
	}
	
}

/// @desc Get or create Bus
/// @param {String} _busType Bus type or Bus name
/// @param {Real} _busCategory Bus category/id
/// @return {Struct.__AEBus}
function __AEBusGet(_busType, _busCategory = undefined) {
	static _system = __AudioEngineSystem();
	
	var _busName = _busCategory != undefined ? $"{_busType}-{_busCategory}" : _busType;
	var _busVolumeCategory = _busName;
	
	if(_system.bus[$ _busName] != undefined) {
		return _system.bus[$ _busName];
	}
	
	if(
		string_starts_with(_busName, $"{__AUDIOENGINE_PREFIX_SPATIALIZED_GAME}-"
	)) {
		_busVolumeCategory = __AUDIOENGINE_PREFIX_SPATIALIZED_GAME;
	}
	
	var _defaultVolume = _system.defaultBusVolumes[$ _busVolumeCategory] ?? 1;
	
	var _newEmitter = audio_emitter_create();
	var _newBus = audio_bus_create();
	
	_system.bus[$ _busName] = new __AEBus(_newEmitter, _newBus, _defaultVolume, _busCategory);
	
	audio_emitter_bus(_system.bus[$ _busName].emitter, _system.bus[$ _busName].bus);
	
	if(
		string_starts_with(_busName, $"{__AUDIOENGINE_PREFIX_MUSIC}-") || 
		string_starts_with(_busName, $"{__AUDIOENGINE_PREFIX_UI}-") || 
		string_starts_with(_busName, $"{__AUDIOENGINE_PREFIX_STATIC_GAME}-"
	)) {
		audio_emitter_position(_system.bus[$ _busName].emitter, _system.position.x, _system.position.y, _system.position.z);
	}	
	
	return _system.bus[$ _busName];
}

/// @desc Get all the buses for a type
/// @param {String} _busType Bus type
/// @return {Array<Struct.__AEBus>}
function __AEBusGetAll(_busType) {
	static _system = __AudioEngineSystem();
	
	var _busNames = struct_get_names(_system.bus);

	var _busArray = [];
	
	for(var _i = 0; _i < array_length(_busNames); _i++) {
		var _busName = _busNames[_i];
		
		if(string_starts_with(_busName, _busType)) {
			array_push(_busArray, _system.bus[$ _busName])
		}
	}
	
	// Feather ignore once GM1045
	return _busArray;

}

/// @desc Clear a bus
/// @param {String} _busName Bus name
/// @return {Undefined}
function __AEBusClear(_busName) {
	static _system = __AudioEngineSystem();
		
	if(_system.bus[$ _busName] == undefined) {
		return;
	}
	
	// Feather ignore once GM1019 Ignore invalid type error
	__AELogVerbose($"cleaning bus {_busName}");
	
	audio_emitter_free(_system.bus[$ _busName].emitter);
	audio_bus_clear_emitters(_system.bus[$ _busName].bus);
	
	struct_remove(_system.bus, _busName);
}

/// @desc Clear all Buses
/// @return {Undefined}
function __AEBusClearAll() {
	static _system = __AudioEngineSystem();
	
	var _busNames = struct_get_names(_system.bus);
	
	for(var _i = 0; _i < array_length(_busNames); _i++) {
		var _busName = _busNames[_i];
		
		audio_emitter_free(_system.bus[$ _busName].emitter);
		audio_bus_clear_emitters(_system.bus[$ _busName].bus);
	
		struct_remove(_system.bus, _busName);
	}
}

/// @desc Set an effect to a bus
/// @param {Struct.AudioEffect} _effect Effect to apply
/// @param {Real} _effectIndex Canal to apply the effect. Must be a number between 0 and 7
/// @param {String} _busName Bus name
/// @return {Undefined}
function __AEBusEffectSet(_effect, _effectIndex, _busName) {
	
	if(!__AEBusCheckEffectValid(_effect)) {
		// Feather ignore once GM1019 Ignore invalid type error
		__AELogError(_effect, "is not valid");
		return;	
	}
	
	if(_effectIndex < 0 || _effectIndex > 7) {
		// Feather ignore once GM1019 Ignore invalid type error
		__AELogError(_effectIndex, "is out of bound");
		return;	
	}
		
	var _bus = __AEBusGet(_busName);	
	
	_bus.bus.effects[_effectIndex] = _effect;
	
}

/// @desc Set multiple effects to a bus
/// @param {Array<Struct.AudioEffect>} _effects Array of effect to apply
/// @param {String} _busName Bus name
function __AEBusEffectsSet(_effects, _busName) {
	
	var _effectsLength = min(8, array_length(_effects));
	
	for(var _effectIndex = 0; _effectIndex < _effectsLength; _effectIndex++) {
		var _bus = __AEBusGet(_busName);	
		var _effect = _effects[_effectIndex];
		
		if(!__AEBusCheckEffectValid(_effect)) {
			// Feather ignore once GM1019 Ignore invalid type error
			__AELogError(_effect, "is not valid");
			continue;	
		}		
	
		_bus.bus.effects[_effectIndex] = _effect;
	}

}

/// @desc Clear an effect from a bus
/// @param {Real} _effectIndex Canal to apply the effect. Must be a number between 0 and 7
/// @param {String} _busName Bus name
function __AEBusEffectClear(_effectIndex, _busName) {
	if(_effectIndex < 0 || _effectIndex > 7) {
		// Feather ignore once GM1019 Ignore invalid type error
		__AELogError(_effectIndex, "is out of bound");
		return;	
	}	

	var _bus = __AEBusGet(_busName);	
	
	_bus.bus.effects[_effectIndex] = undefined;
	
}

/// @desc Clear all effects from a bus
/// @param {String} _busName Bus name
function __AEBusEffectClearAll(_busName) {
	var _bus = __AEBusGet(_busName);	
	
	for(var _effectIndex = 0; _effectIndex < 8; _effectIndex++) {
		_bus.bus.effects[_effectIndex] = undefined;
	}
}

/// @desc Check if an effect is valid. Only executed in "run" mode (development)
/// @param {Struct.AudioEffect} _effect Effect to apply
/// @return {Bool}
function __AEBusCheckEffectValid(_effect) {
	if(GM_build_type == "exe") {
		// No check on production
		return true;
	}
	
	try {

		if(is_undefined(_effect)) {
			// Feather ignore once GM1019 Ignore invalid type error
			__AELogWarning(_effect, "is undefined");
			return false;
		}

		if(!is_struct(_effect)) {
			// Feather ignore once GM1019 Ignore invalid type error
			__AELogWarning(_effect, "is not a struct");
			return false;	
		}
	
		if(!struct_exists(_effect, "type")) {
			// Feather ignore once GM1019 Ignore invalid type error
			__AELogWarning(_effect, "has no type property");
			return false;	
		}
		
		// Effect are stored as int32, but documentation indicate int64 for enum
		// It safer to check for every numeric type here
		if(!is_numeric(_effect.type)) {
			// Feather ignore once GM1019 Ignore invalid type error
			__AELogWarning(_effect, "type property is invalid");
			return false;	
		}
	
		if(!struct_exists(_effect, "bypass")) {
			// Feather ignore once GM1019 Ignore invalid type error
			__AELogWarning(_effect, "has no bypass property");
			return false;	
		}	
		
		if(!is_bool(_effect.bypass)) {
			// Feather ignore once GM1019 Ignore invalid type error
			__AELogWarning(_effect, "bypass property is invalid");
			return false;	
		}			

	
		return true;
	} catch(_exception) {
		// Feather ignore once GM1019 Ignore invalid type error
		__AELogWarning(_effect, "throw exception", _exception);

		return false;	
	}
}