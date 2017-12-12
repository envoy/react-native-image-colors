# react-native-image-colors

## Getting started

`$ npm install react-native-image-colors --save`

### Automatic installation

`$ react-native link react-native-image-colors`

## Usage

```javascript
import ImageColors from 'react-native-image-colors';

const colors = await ImageColors.getColorFromImage({
	path: '...',
	sections: 2
})
```

`path`: the full file path to an image on disk.

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
