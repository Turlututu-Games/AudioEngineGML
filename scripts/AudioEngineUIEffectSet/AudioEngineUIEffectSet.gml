/// @desc Set an effect to a ui category
/// @module UI
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-UI?id=AudioEngineUIEffectSet
/// @param {Struct.AudioEffect} _effect Effect to apply
/// @param {Real} [_effectIndex] Optional canal to apply the effect. Must be a number between 0 and 7. 0 by default
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineUIEffectSet(_effect, _effectIndex = 0, _category = 0) {
    __AEBusEffectSet(_effect, _effectIndex, $"{__AUDIOENGINE_PREFIX_UI}-{_category}")
}
