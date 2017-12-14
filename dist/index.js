"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var react_native_1 = require("react-native");
var RNImageColors = react_native_1.NativeModules.RNImageColors;
var ImageColors = /** @class */ (function () {
    function ImageColors() {
    }
    ImageColors.getColorFromImage = function (uri, options) {
        if (options === void 0) { options = {}; }
        return RNImageColors.getColorFromImage({
            path: uri,
            sectionsX: options.sectionsX || options.sections || 1,
            sectionsY: options.sectionsY || options.sections || 1
        });
    };
    return ImageColors;
}());
exports.default = ImageColors;
