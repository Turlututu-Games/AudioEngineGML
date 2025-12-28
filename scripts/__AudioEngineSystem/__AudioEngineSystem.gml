function __AudioEngineSystem(){
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
		currentMusic: undefined,
		currentState: [0],
		library: {
			music: [],
			ui: [],
			game: [],
		}
	};
	
	__AudioEngineConfig();
	
	if(!instance_exists(oAudioEngineManager)) {
		
		if (!layer_exists("Instances")) {
			layer_create(0, "Instances");
		}
		
		instance_create_layer(0, 0, "Instances"	, oAudioEngineManager);
	}
	
	return _system;
}

