#macro __AUDIOENGINE_MANAGER_DEPTH  16002

function __AudioEngineSystem() {
	static _system = undefined;
    
	if (_system != undefined) {
		return _system;
	}
	
	_system = {
		volumes: {
			music: 1,
			ui: 1,
			game: 1
		},
		listener: undefined,
		bus: {
			music: undefined,
			ui: undefined,
			game: undefined	
		},
		currentMusics: {},
		library: {
			music: {},
			ui: {},
			game: {},
		}
	};
	
	__AudioEngineConfig();
	
	__AudioEngineSystemInitManager();
	__AEBusSetListenerPosition(0, 0);
	
	return _system;
}



function __AudioEngineSystemInitManager() {
	
	var _exists = true;
	
	if(!instance_exists(__oAudioEngineManager)) {
		
		instance_activate_object(__oAudioEngineManager);
		
		if(!instance_exists(__oAudioEngineManager)) {
		
			instance_create_depth(0, -__AUDIOENGINE_MANAGER_DEPTH, __AUDIOENGINE_MANAGER_DEPTH, __oAudioEngineManager);
		
		}
	}
	
	if (!__oAudioEngineManager.persistent) {
		__oAudioEngineManager.persistent = true;
    }	
	
	if(!__oAudioEngineManager.depth != __AUDIOENGINE_MANAGER_DEPTH) {
		__oAudioEngineManager.depth = __AUDIOENGINE_MANAGER_DEPTH;
	}
}
