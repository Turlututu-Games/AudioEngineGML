/// @desc Set a music effect to a category
/// @param {Struct.AudioEffect} _effect Effect to apply
/// @param {Real} [_effectIndex] Optional canal to apply the effect. Must be a number between 0 and 7. 0 by default
/// @param {Enum.AUDIO_CATEGORIES} [_category] Optional category. 0 by default
function AudioEngineMusicEffectSet(_effect, _effectIndex = 0, _category = 0) {
	__AEBusEffectSet(_effect, _effectIndex, $"music-{_category}")
}
