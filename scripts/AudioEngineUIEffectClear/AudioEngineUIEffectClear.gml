/// @desc Clear a music effect from a ui category
/// @module UI
/// @param {Real} [_effectIndex] Optional canal to clear the effect. Must be a number between 0 and 7. 0 by default
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineUIEffectClear(_effectIndex = 0, _category = 0) {
    __AEBusEffectClear(_effectIndex, $"{__AUDIOENGINE_PREFIX_UI}-{_category}")
}
