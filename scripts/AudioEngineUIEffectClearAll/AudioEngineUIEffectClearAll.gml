/// @desc Clear all effects from a ui category
/// @module UI
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-UI?id=AudioEngineUIEffectClearAll
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineUIEffectClearAll(_category = 0) {
    __AEBusEffectClearAll($"{__AUDIOENGINE_PREFIX_UI}-{_category}")
}
