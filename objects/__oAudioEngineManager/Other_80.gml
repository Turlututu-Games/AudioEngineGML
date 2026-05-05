/// @description Stops a sound that has finished playing
var _ref = async_load[? "sound_id"];
var _assetId = async_load[? "asset_id"];

// Feather ignore once GM1019 Ignore invalid type error
__AELogVerbose($"asset {_assetId} stop playing");

var _system = __AudioEngineSystem();

var _arraySize = array_length(_system.playing);
/// @type {Struct.__AESystemPlaying}
var _found = undefined;

for(var _i = 0; _i < _arraySize; _i++) {
    if(_system.playing[_i].ref == _ref) {

        _found = _system.playing[_i];
        struct_remove(_system.playingMap, _ref);
        array_delete(_system.playing, _i, 1);
        break;
    }
}

if(_found == undefined) {
 // The sound has not been found!
    return;
}

var _filtered = [];
_arraySize = array_length(_system.playing);

for(var _i = 0; _i < _arraySize; _i++) {
    if(_system.playing[_i].asset == _found.asset) {
        array_push(_filtered, _system.playing[_i])
        break;
    }
}

if(string_starts_with(_found.busName, $"{__AUDIOENGINE_PREFIX_SPATIALIZED_GAME}-")) {
    // Sounds played via AudioEngineGamePlayAtObject share a bus per instance.id —
    // only clear the bus once no other playing sound is still routed through it.
    var _busStillInUse = false;
    var _remaining = array_length(_system.playing);
    for(var _j = 0; _j < _remaining; _j++) {
        if(_system.playing[_j].busName == _found.busName) {
            _busStillInUse = true;
            break;
        }
    }

    if(!_busStillInUse) {
        __AEBusClear(_found.busName);
    }
}

if(array_length(_filtered) == 0) {
    if(is_string(_found.asset)) {
        // This is the last playback for this stream. We can remove the stream
        __AEStreamCleanup(_found.asset, _assetId);
    }
}
