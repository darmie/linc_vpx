package vpx;

import haxe.io.BytesData;

typedef FrameData = {

  var status:Int;

  var width:Int;
  var height:Int;
  var comp:Int;
  var data:BytesData;

}

@:keep
@:include('linc_vpx.h')
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('vpx'))
extern class WebmReader {

  @:native('linc::vpx::load')
  static function load(filename:String):DecInputContext;

  @:native('linc::vpx::read_frame')
  static function read_frame(ctx:DecInputContextRef):FrameData;

  @:native('linc::vpx::close')
  static function close(ctx:DecInputContextRef):Void;

} //Empty

@:include('linc_vpx.h')
@:native('linc::vpx::DecInputContext')
private extern class DecInputContext {}

typedef DecInputContextPtr = cpp.Pointer<DecInputContext>;

@:native('::cpp::Struct<linc::vpx::DecInputContext>')
private extern class DecInputContextStruct extends DecInputContext {}

@:native('::cpp::Reference<linc::vpx::DecInputContext>')
private extern class DecInputContextRef extends DecInputContext {}