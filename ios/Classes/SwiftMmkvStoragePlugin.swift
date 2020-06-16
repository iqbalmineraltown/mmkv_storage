import Flutter
import UIKit
import MMKV
    
public class SwiftMmkvStoragePlugin: NSObject, FlutterPlugin {
    private var channel:FlutterMethodChannel;
    private var mmkv:MMKV;
    
    init(channel:FlutterMethodChannel) {
        self.channel = channel
      mmkv = MMKV.default()!
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mmkv_storage", binaryMessenger: registrar.messenger())
    let instance = SwiftMmkvStoragePlugin(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "getRootDir":
            // TODO do nothing?
            result("unable to get root dir on iOS?")
            break
        case "encodeBool":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            let aBool = args["aBool"]! as! Bool
            result(mmkv.set(aBool, forKey: key))
            break
        case "decodeBool":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            result(mmkv.bool(forKey: key))
            break
        case "encodeInt":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            let aInt = args["aInt"]! as! Int32
            result(mmkv.set(aInt, forKey: key))
            break
        case "decodeInt":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            result(mmkv.int32(forKey: key))
            break
        case "encodeLong":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            let aLong = args["aLong"]! as! Int64
            result(mmkv.set(aLong, forKey: key))
            break
        case "decodeLong":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            result(mmkv.int64(forKey: key))
            break
        case "encodeDouble":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            let aDouble = args["aDouble"]! as! Double
            result(mmkv.set(aDouble, forKey: key))
            break
        case "decodeDouble":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            result(mmkv.double(forKey: key))
            break
        case "encodeString":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            let aString = args["aString"]! as! String
            result(mmkv.set(aString, forKey: key))
            break
        case "decodeString":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            result(mmkv.string(forKey: key))
            break
        case "encodeUint8List":
            // TODO handle bytes type
//            let args = call.arguments as! [String:Any]
//            let key = args["key"]! as! String
//            let aUInt8 = args["aBytes"]! as! FlutterStandardTypedData
//            result(mmkv.set(aUInt8, forKey: key))
            break
        case "decodeUint8List":
//            let args = call.arguments as! [String:Any]
//            let key = args["key"]! as! String
//            let retrievedValue = mmkv.object(of: FlutterStandardTypedData.self ,forKey: key)
//            result(retrievedValue)
            break
        case "containsKey":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            result(mmkv.contains(key: key))
            break
        case "removeValueForKey":
            let args = call.arguments as! [String:Any]
            let key = args["key"]! as! String
            mmkv.removeValue(forKey: key)
            break
        case "removeAll":
            mmkv.clearAll()
            break
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
