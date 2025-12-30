/// @desc Clear all effects from a game static category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineGameEffectClearAll(_category = 0) {
	__AEBusEffectClearAll($"{__AUDIOENGINE_PREFIX_STATIC_GAME}-{_category}")
}
