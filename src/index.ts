import { NativeModules } from 'react-native'
const { RNImageColors } = NativeModules

export interface Options {
  sections?: number
  sectionsX?: number
  sectionsY?: number
}

export default class ImageColors {
  static getColorFromImage(uri: string, options: Options = {}) {
    return RNImageColors.getColorFromImage({
      path: uri,
      sectionsX: options.sectionsX || options.sections || 1,
      sectionsY: options.sectionsY || options.sections || 1
    })
  }
}
