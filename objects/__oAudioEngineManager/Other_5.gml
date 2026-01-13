/// @description Stops all sounds that are set to be cleaned up on room end

var _system = __AudioEngineSystem();

//var _busesStatic = __AEBusGetAll(__AUDIOENGINE_PREFIX_STATIC_GAME);
//var _busesSpatialized = __AEBusGetAll(__AUDIOENGINE_PREFIX_SPATIALIZED_GAME);

var _arraySize = array_length(_system.playing);

for(var _i = 0; _i < _arraySize; _i++) {
    var _playing = _system.playing[_i];
    var _bus = __AEBusGetByName(_playing.busName);

    if(_bus && _bus.cleanOnRoomEnd) {
        __AEStopByRef(_playing.ref);
    }

}