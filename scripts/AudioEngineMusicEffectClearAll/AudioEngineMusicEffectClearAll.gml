/// @desc Clear all effects from a music category
/// @module Music
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineMusicEffectClearAll(_category = 0) {
    __AEBusEffectClearAll($"{__AUDIOENGINE_PREFIX_MUSIC}-{_category}")
}
