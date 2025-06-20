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
