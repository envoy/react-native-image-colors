# react-native-image-colors

## Getting started

`$ yarn add @envoy/react-native-image-colors`

### Automatic installation

`$ react-native link @envoy/react-native-image-colors`

## Usage

```javascript
import ImageColors from '@envoy/react-native-image-colors';

const colors = await ImageColors.getColorFromImage('file-path', { sections: 2 })
```

`file-path`: the full file path to an image on disk.

`sections`: the number of sections to divide the width and height into.

#### Return value

`getColorFromImage` returns an array of hex strings. The array positions
correspond with the sections count. So for example if you had `sections: 2`:

```
--------
| 0, 1 |
| 2, 3 |
--------
```

## Seperate X & Y Sections

If you want to divide the image in different x & y sections, you can pass those in.

```javascript
const colors = await ImageColors.getColorFromImage('file-path', { sectionsX: 1, sectionsY: 5 })
```
