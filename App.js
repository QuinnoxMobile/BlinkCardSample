import React, { Component } from 'react'
import { Text, View ,StyleSheet} from 'react-native'
import ScanCardScreen from './src/ScanCardScreen'

export default class App extends Component {
  render() {
    return (
      <View style={styles.container}>
        <ScanCardScreen/> 
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container:{
    flex:1,
    justifyContent:'center'
  }
})
