
package urho3d;
import haxe.Int64;

class Time
{

    public static var systemTime(get,never):Float;


    static function get_systemTime() {
        return getSystemtime(Context.context);
    }

    @:hlNative("Urho3D", "_core_time_get_system_time")
	private static function getSystemtime(context:Context):Float {
		return 0;
	}
}