# react-native-amap-foundation

rn amap

## Installation

```sh
npm install rn-amap
```

## Usage


```js
import { View, StyleSheet } from 'react-native';
import { AMapView } from 'rn-amap';
import { amapProps } from './config';

export default function App() {
  return (
    <View style={styles.container}>
      <AMapView amap={amapProps} style={styles.amapFoundation} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  amapFoundation: {
    width: '100%',
    height: 320,
  },
});
```


## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
