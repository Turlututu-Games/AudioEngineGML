/// @desc Clear all effects from a category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineMusicEffectClearAll(_category = 0) {
	__AEBusEffectClearAll($"music-{_category}")
}
