/// @desc Clear all effects from a ui category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineUIEffectClearAll(_category = 0) {
	__AEBusEffectClearAll($"{__AUDIOENGINE_PREFIX_UI}-{_category}")
}
