import { LinearGradient } from "expo-linear-gradient";
import React, { useEffect, useState } from "react";
import { Animated, Dimensions, StyleSheet } from "react-native";

const { width, height } = Dimensions.get("window");

export default function SplashScreen({ onFinish }) {
  const [opacity] = useState(new Animated.Value(1));
  const [rotateAnim] = useState(new Animated.Value(0));
  const [scaleAnim] = useState(new Animated.Value(1));

  useEffect(() => {
    Animated.loop(
      Animated.timing(rotateAnim, {
        toValue: 1,
        duration: 3000,
        useNativeDriver: true,
      })
    ).start();

    Animated.loop(
      Animated.sequence([
        Animated.timing(scaleAnim, {
          toValue: 1.1,
          duration: 1200,
          useNativeDriver: true,
        }),
        Animated.timing(scaleAnim, {
          toValue: 1,
          duration: 1200,
          useNativeDriver: true,
        }),
      ])
    ).start();
  }, []);

  const rotate = rotateAnim.interpolate({
    inputRange: [0, 1],
    outputRange: ["0deg", "360deg"],
  });

  return (
    <Animated.View style={[styles.container, { opacity }]}> 
      <Animated.View
        style={{
          ...StyleSheet.absoluteFillObject,
          transform: [{ rotate }],
        }}
      >
        <LinearGradient
          colors={["#0000E2", "#00C1A2", "#00C900"]}
          start={{ x: 0, y: 0 }}
          end={{ x: 0.75, y: 0.75 }}
          style={styles.gradient}
        />
      </Animated.View>
      <Animated.Text style={[styles.title, { transform: [{ scale: scaleAnim }] }]}>Rp Limpezas</Animated.Text>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    justifyContent: 'center',
    alignItems: 'center',
  },
  gradient: {
    width: width * 3.5,
    height: height * 3.5,
    borderRadius: width * 1.5,
    alignSelf: 'center',
    top: -(height / 2),
    left: -(width / 2),
  },
  title: {
    color: 'white',
    fontSize: 32,
    fontWeight: 'bold',
    textAlign: 'center',
  },
});
