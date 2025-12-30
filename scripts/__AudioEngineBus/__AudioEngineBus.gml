
/// @desc AudioEngine Bus Instance
/// @param {Id.AudioEmitter} _emitter
/// @param {Struct.AudioBus} _bus
function __AEBus(_emitter, _bus) constructor {
	emitter = _emitter;
	bus = _bus;
}

/// @desc Set Main Listener position. All emitter from categories music, ui and static will move too
/// @param {Real} _x
/// @param {Real} _y
/// @param {Real} [_z]
function __AEBusSetListenerPosition(_x, _y, _z = 0) {
	static _system = __AudioEngineSystem();
	
	audio_listener_position(_x, _y, _z);
	
	_system.position.x = _x;
	_system.position.y = _y;
	_system.position.z = _z;
	
	var _busNames = struct_get_names(_system.bus);
	
	for(var _i = 0; _i < array_length(_busNames); _i++) {
		var _busName = _busNames[_i];
		
		if(string_starts_with(_busName, "music-") || string_starts_with(_busName, "ui-") || string_starts_with(_busName, "static-")) {
			var _bus = 	_system.bus[$ _busName];
			
			audio_emitter_position(_bus.emitter, _x, _y, _z);
		}
	}
	
}

/// @desc Get or create Bus
/// @param {String} _busName Bus name
/// @return {Struct.__AEBus}
function __AEBusGet(_busName) {
	static _system = __AudioEngineSystem();
	
	if(_system.bus[$ _busName] != undefined) {
		return _system.bus[$ _busName];
	}
	
	_system.bus[$ _busName] = {};
	
	_system.bus[$ _busName].emitter = audio_emitter_create();
	_system.bus[$ _busName].bus = audio_bus_create();
	
	audio_emitter_bus(_system.bus[$ _busName].emitter, _system.bus[$ _busName].bus);
	
	if(string_starts_with(_busName, "music-") || string_starts_with(_busName, "ui-") || string_starts_with(_busName, "static-")) {
			
		audio_emitter_position(_system.bus[$ _busName].emitter, _system.position.x, _system.position.y, _system.position.z);
	}	
	
	return _system.bus[$ _busName];
}

/// @desc Clear a bus
/// @param {String} _busName Bus name
function __AEBusClear(_busName) {
	static _system = __AudioEngineSystem();
	
	show_debug_message("check cleaning bus {0}", _busName);
	
	if(_system.bus[$ _busName] == undefined) {
		return;
	}
	
	show_debug_message("cleaning bus {0}", _busName);
	
	audio_emitter_free(_system.bus[$ _busName].emitter);
	audio_bus_clear_emitters(_system.bus[$ _busName].bus);
	
	struct_remove(_system.bus, _busName);
}

/// @desc Clear all Buses
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
function __AEBusEffectSet(_effect, _effectIndex, _busName) {
	if(_effectIndex >= 0 && _effectIndex <=7) {
		var _bus = __AEBusGet(_busName);	
	
		_bus.bus.effects[_effectIndex] = _effect;
	}
}

/// @desc Clear an effect from a bus
/// @param {Real} _effectIndex Canal to apply the effect. Must be a number between 0 and 7
/// @param {String} _busName Bus name
function __AEBusEffectClear(_effectIndex, _busName) {
	if(_effectIndex >= 0 && _effectIndex <=7) {
		var _bus = __AEBusGet(_busName);	
	
		_bus.bus.effects[_effectIndex] = undefined;
	}
}

/// @desc Clear all effects from a bus
/// @param {String} _busName Bus name
function __AEBusEffectClearAll(_busName) {
	var _bus = __AEBusGet(_busName);	
	
	for(var _effectIndex = 0; __effectIndex < 8; _effectIndex++) {
		_bus.bus.effects[_effectIndex] = undefined;
	}
}
