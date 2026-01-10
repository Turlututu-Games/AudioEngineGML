/// @desc Return the sound asset
/// @param {Struct.__AESystemLibraryMusicTrack,Struct.__AESystemLibraryMusicSingle,Struct.__AESystemLibraryMusicSingle,Struct.__AESystemLibrarySound} _asset
/// @return {Asset.GMSound}
function __AEStreamReturnAsset(_asset) {
	if(_asset.isStream) {
		
		static _system = __AudioEngineSystem();
		
		if(_system.streams[$ _asset.asset] != undefined) {
			return _system.streams[$ _asset.asset]	
		}
		
		var _audio = audio_create_stream(_asset.asset);
		
		// Store the stream for the moment
		_system.streams[$ _asset.asset] = _audio;
		
		return _audio;
	}
	
	return _asset.asset;
	
}

/// @desc Destroy the sound stream and clean the cache
/// @param {String} _assetName
/// @param {Asset.GMSound} _assetId
/// @return {Real} 1 if successfull, -1 otherwise
function __AEStreamCleanup(_assetName, _assetId) {

	static _system = __AudioEngineSystem();
	
	// Feather ignore once GM1019 Ignore invalid type error
	__AELogVerbose($"destroying stream {_assetId} for asset {_assetName}");

	if(_system.streams[$ _assetName] != undefined) {
		struct_remove(_system.streams, _assetName);
	}
	
	return audio_destroy_stream(_assetId);

}

/// @desc Destroy all the streams
function __AEStreamCleanupAll() {
    static _system = __AudioEngineSystem();
	
    var _streamNames = struct_get_names(_system.streams);
	
    for(var _i = 0; _i < array_length(_streamNames); _i++) {
        var _name = _streamNames[_i];
		
        audio_destroy_stream(_system.streams[$ _name]);
    }
	
    _system.streams = {};
}