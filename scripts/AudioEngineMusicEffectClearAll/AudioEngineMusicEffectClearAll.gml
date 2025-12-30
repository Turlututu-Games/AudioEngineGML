/// @desc Clear all effects from a music category
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineMusicEffectClearAll(_category = 0) {
	__AEBusEffectClearAll($"{__AUDIOENGINE_PREFIX_MUSIC}-{_category}")
}
