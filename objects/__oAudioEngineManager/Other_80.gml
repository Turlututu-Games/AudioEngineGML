var _ref = async_load[? "sound_id"];
var _assetId = async_load[? "asset_id"];

var _system = __AudioEngineSystem();

var _arraySize = array_length(_system.playing);
var _found = undefined;

for(var _i = 0; _i < _arraySize; _i++) {
	if(_system.playing[_i].ref == _ref) {
		
		_found = _system.playing[_i];
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

if(array_length(_filtered) == 0) {
	if(is_string(_found.asset)) {
		// This is the last playback for this stream. We can remove the stream
		__AEStreamCleanup(_found.asset, _assetId);
	}
}

