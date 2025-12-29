/// @desc Return the sound asset
/// @param {Asset.GMSound,String} _asset
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
function __AEStreamCleanup(_assetName, _assetId) {

	static _system = __AudioEngineSystem();
	
	show_debug_message("destroying stream {0} for asset {1}", _assetId, _assetName);

	if(_system.streams[$ _assetName] != undefined) {
		_system.streams[$ _assetName] = undefined;
	}
	
	audio_destroy_stream(_assetId);

}