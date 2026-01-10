/// @desc Clear all effects from a ui category
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
// Feather ignore once GM1045
function AudioEngineUIEffectClearAll(_category = 0) {
	__AEBusEffectClearAll($"{__AUDIOENGINE_PREFIX_UI}-{_category}")
}
