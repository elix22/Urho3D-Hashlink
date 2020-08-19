
package urho3d;

@:access(String)
@:forward
abstract HString(String) from String to String {
	@:from static public inline function fromBytes(b:hl.Bytes):HString
		return switch b {
					case null: null;
					default: String.fromUCS2(b);
			}
	
	@:to public inline function toBytes():hl.Bytes
		return switch this {
					case null: null;
					default: this.bytes;
			}
}