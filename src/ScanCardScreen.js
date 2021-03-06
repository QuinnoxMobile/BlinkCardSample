import React, { Component } from 'react'
import { Text, View,NativeModules,
  TouchableOpacity,
  StyleSheet,
  TextInput,Platform ,
  NativeEventEmitter} from 'react-native'
 const myModuleEvt = new NativeEventEmitter(NativeModules.CalendarManager);

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
        cardNumber: '',
        validThru:'',
        cvv:'',
        data:''
    }
//This line of code will be called from the native iOS using RCTEventEmitter and sends the data.
  myModuleEvt.addListener('ScanCard', (data) => {this.setState({cvv:data.cvv,cardNumber:data.cardNumber,validThru:data.validThru})})
}

//This function will be called when the Start Scan Card Button is clicked in React Native
//And if the platform is IOS, then it will be call the function changeToViewBridge which is in Native iOS and opens the native Screen.
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
       <View style={{flexDirection:'row'}}>
            <Text style={styles.textStyle}>CardNumber</Text>
            <Text style={{
              color: 'black',
              fontWeight: 'bold',
              fontSize: 16,
              padding:20
   }}>{this.state.cardNumber}</Text>
          </View>
          <View style={{flexDirection:'row'}}> 
            <Text style={styles.textStyle}>Valid Thru</Text>
            <Text style={{
              color: 'black',
              fontWeight: 'bold',
              fontSize: 16,
              marginLeft:21,
              padding:20}}>
              {this.state.validThru}</Text>
          </View>
          <View style={{flexDirection:'row'}}>
            <Text style={styles.textStyle}>CVV</Text>
            <Text style={{
              color: 'black',
              fontWeight: 'bold',
              fontSize: 16,
              marginLeft:66,
              padding:20}}>
              {this.state.cvv}</Text>
          </View>
       <View style={{paddingHorizontal:100,paddingTop:20}}>
      <TouchableOpacity style={styles.buttonStyle}  onPress={this.startCardScan}>
            <Text style={styles.buttonTextStyle}>Start Card Scan!</Text>
          </TouchableOpacity>
      </View> 
       </View>
    )
  }
}

const styles = StyleSheet.create({
  container:{
    flex:1,
    justifyContent:'center',
    alignItems:'flex-start',
    backgroundColor:'#fcfcff'
  },
  buttonStyle: {
    padding: 14,
    backgroundColor: 'red',
    borderRadius: 6,
  },

  buttonTextStyle:{
    color: 'white',
    textAlign: 'center',
    fontWeight: 'bold',
    fontSize: 16,
  },

  textStyle: {
    color: 'black',
    justifyContent:'flex-start',
    fontWeight: 'bold',
    fontSize: 16,
    padding:20,
  }
})