/// @desc Clear an effect from a game static category
/// @param {Real} [_effectIndex] Optional canal to clear the effect. Must be a number between 0 and 7. 0 by default
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineGameEffectClear(_effectIndex = 0, _category = 0) {
	__AEBusEffectClear(_effectIndex, $"{__AUDIOENGINE_PREFIX_STATIC_GAME}-{_category}")
}
