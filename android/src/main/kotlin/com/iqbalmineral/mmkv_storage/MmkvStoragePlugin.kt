package com.iqbalmineral.mmkv_storage

import androidx.annotation.NonNull
import com.tencent.mmkv.MMKV
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


/** MmkvStoragePlugin */
class MmkvStoragePlugin : FlutterPlugin, MethodCallHandler {

    private val channelName = "mmkv_storage"
    private var mmkv: MMKV? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val context = flutterPluginBinding.applicationContext
        MMKV.initialize(context)
        val channel = MethodChannel(flutterPluginBinding.binaryMessenger, channelName)
        channel.setMethodCallHandler(MmkvStoragePlugin());
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        private const val channelName = "mmkv_storage"
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            MMKV.initialize(registrar.activeContext())
            val methodChannel = MethodChannel(registrar.messenger(), channelName)
            methodChannel.setMethodCallHandler(MmkvStoragePlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        var mmkv = this.mmkv ?: MMKV.defaultMMKV()

        when (call.method) {
            "getRootDir" -> {
                result.success(MMKV.getRootDir())
            }
            "encodeBool" -> {
                val key: String = call.argument("key")!!
                val aBool: Boolean = call.argument("aBool")!!
                result.success(mmkv.encode(key, aBool))
            }
            "decodeBool" -> {
                val key: String = call.argument("key")!!
                result.success(mmkv.decodeBool(key))
            }
            "encodeInt" -> {
                val key: String = call.argument("key")!!
                val aInt: Int = call.argument("aInt")!!
                result.success(mmkv.encode(key, aInt))
            }
            "decodeInt" -> {
                val key: String = call.argument("key")!!
                result.success(mmkv.decodeInt(key))
            }
            "encodeLong" -> {
                val key: String = call.argument("key")!!
                val aLong: Long = call.argument("aLong")!!
                result.success(mmkv.encode(key, aLong))
            }
            "decodeLong" -> {
                val key: String = call.argument("key")!!
                result.success(mmkv.decodeLong(key))
            }
            "encodeDouble" -> {
                val key: String = call.argument("key")!!
                val aDouble: Double = call.argument("aDouble")!!
                result.success(mmkv.encode(key, aDouble))
            }
            "decodeDouble" -> {
                val key: String = call.argument("key")!!
                result.success(mmkv.decodeDouble(key))
            }
            "encodeString" -> {
                val key: String = call.argument("key")!!
                val aString: String = call.argument("aString")!!
                result.success(mmkv.encode(key, aString))
            }
            "decodeString" -> {
                val key: String = call.argument("key")!!
                result.success(mmkv.decodeString(key))
            }
            "encodeUint8List" -> {
                val key: String = call.argument("key")!!
                val aBytes: ByteArray = call.argument("aBytes")!!
                result.success(mmkv.encode(key, aBytes))
            }
            "decodeUint8List" -> {
                val key: String = call.argument("key")!!
                result.success(mmkv.decodeBytes(key))
            }
            "removeValueForKey" -> {
                val key: String = call.argument("key")!!
                mmkv.removeValueForKey(key)
            }
            "removeAll" -> {
                mmkv.clearAll()
            }
            "containsKey" -> {
                val key: String = call.argument("key")!!
                result.success(mmkv.containsKey(key))
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
