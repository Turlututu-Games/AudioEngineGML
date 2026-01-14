/// @desc Clear all effects from a game static category
/// @module Game
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineGameEffectClearAll(_category = 0) {
    __AEBusEffectClearAll($"{__AUDIOENGINE_PREFIX_STATIC_GAME}-{_category}")
}
