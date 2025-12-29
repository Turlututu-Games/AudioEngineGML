
/// @desc AudioEngine Bus Instance
/// @param {Id.AudioEmitter} _emitter
/// @param {Struct.AudioBus} _bus
function __AEBus(_emitter, _bus) constructor {
	emitter = _emitter;
	bus = _bus;
}

function __AEBusSetListenerPosition(_x, _y, _z = 0) {
	static _system = __AudioEngineSystem();
	
	audio_listener_position(_x, _y, _z);
	
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
/// @param {String} _name
/// @return {Struct.__AEBus}
function __AEBusGet(_name) {
	static _system = __AudioEngineSystem();
	
	if(_system.bus[$ _name] != undefined) {
		return _system.bus[$ _name];
	}
	
	_system.bus[$ _name] = {};
	
	_system.bus[$ _name].emitter = audio_emitter_create();
	_system.bus[$ _name].bus = audio_bus_create();
	
	audio_emitter_bus(_system.bus[$ _name].emitter, _system.bus[$ _name].bus);
	
	return _system.bus[$ _name];
}

function __AEBusClear(_name) {
	static _system = __AudioEngineSystem();
	
	if(_system.bus[$ _name] == undefined) {
		return;
	}
	
	audio_emitter_free(_system.bus[$ _name].emitter);
	audio_bus_clear_emitters(_system.bus[$ _name].bus);
	
	_system.bus[$ _name] = undefined;
}

function __AEBusClearAll() {
	static _system = __AudioEngineSystem();
	
	var _busNames = struct_get_names(_system.bus);
	
	for(var _i = 0; _i < array_length(_busNames); _i++) {
		var _busName = _busNames[_i];
		
		audio_emitter_free(_system.bus[$ _busName].emitter);
		audio_bus_clear_emitters(_system.bus[$ _busName].bus);
	
		_system.bus[$ _busName] = undefined;
	}
}

function __AEBusEffectSet(_effect, _effectIndex, _category) {
	if(_effectIndex >= 0 && _effectIndex <=7) {
		var _bus = __AEBusGet(_category);	
	
		_bus.bus.effects[_effectIndex] = _effect;
	}
}

function __AEBusEffectClear(_effectIndex, _category) {
	if(_effectIndex >= 0 && _effectIndex <=7) {
		var _bus = __AEBusGet(_category);	
	
		_bus.bus.effects[_effectIndex] = undefined;
	}
}

function __AEBusEffectClearAll(_category) {
	var _bus = __AEBusGet(_category);	
	
	for(var _effectIndex = 0; __effectIndex < 8; _effectIndex++) {
		_bus.bus.effects[_effectIndex] = undefined;
	}
}
