import React, { Component } from 'react'
import { Text, View,NativeModules,
  TouchableOpacity,
  StyleSheet,
  TextInput,Platform ,
  NativeEventEmitter} from 'react-native'

 const myModuleEvt = new NativeEventEmitter(NativeModules.CalendarManager);
const styles = StyleSheet.create({
  container:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
    backgroundColor:'#fcfcff'
  }
})

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
        cardNumber: '',
        data:''
    }
    myModuleEvt.addListener('ScanCard', (data) => {this.setState({cardNumber:data.cardNumber})})
    
}
   startCardScan = async() => {
    console.log('call-native')
    if(Platform.OS === 'ios'){
           NativeModules.ChangeViewBridge.changeToNativeView('Bye :)');
    }
    else{
      this.changeToNativeAndroidView()
    }
   }

  render() { 
    return (
      <View style={styles.container}>
        <TouchableOpacity  onPress={this.startCardScan}>
            <Text>Start Card Scan!</Text>
          </TouchableOpacity> 
          <View style={{flexDirection:'row'}}>
            <Text style={{padding:20}}>CardNumber</Text>
            <Text style={{padding:20}}>{this.state.cardNumber}</Text>
          </View>
       </View>
    )
  }
}
