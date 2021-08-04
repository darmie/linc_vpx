package vpx;

import cpp.Pointer;
import cpp.RawConstPointer;
import cpp.RawPointer;
import cpp.UInt8;
import cpp.Callable;
import cpp.Int64;
import cpp.UInt64;
import cpp.UInt32;

final VPX_IMG_FMT_PLANAR = 0x100; /**< Image is a planar format. */

final VPX_IMG_FMT_UV_FLIP = 0x200; /**< V plane precedes U in memory. */

final VPX_IMG_FMT_HAS_ALPHA = 0x400; /**< Image has an alpha channel. */

final VPX_IMG_FMT_HIGHBITDEPTH = 0x800; /**< Image uses 16bit framebuffer. */

@:keep
@:include('linc_vpx.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('vpx'))
#end
extern class VPX {
	@:native("::vpx_codec_vp8_dx")
	public static function codec_vp8_dx():Pointer<CodecInterface>;

	@:native("::vpx_codec_vp9_dx")
	public static function codec_vp9_dx():Pointer<CodecInterface>;

	@:native("::vpx_codec_dec_init")
	public static function codec_dec_init(ctx:Pointer<CodecContext>, iface:Pointer<CodecInterface>, config:Pointer<CodecDecCfg>, flags:Int64):CodecError;

	@:native("::vpx_img_alloc")
	public static function img_alloc(img:Pointer<VpxImg>, fmt:Int, d_w:UInt32, d_h:UInt32, align:UInt32):Pointer<VpxImg>;

	@:native("::vpx_codec_decode")
	public static function codec_decode(ctx:Pointer<CodecContext>, data:RawPointer<UInt8>, data_sz:Int, user_priv:RawPointer<cpp.Void>,
		deadline:Int64):CodecError;

	@:native("::vpx_codec_get_frame")
	public static function codec_get_frame(ctx:Pointer<CodecContext>, iter:RawConstPointer<cpp.Void>):Pointer<VpxImg>;
} // Empty

@:keep
@:structAccess
@:include('linc_vpx.h') @:native("::vpx_codec_ctx")
extern class CodecContext {
	var name(default, never):String;
	var iface(default, never):CodecInterface;
	var err(default, never):CodecError;
	var err_detail(default, never):String;
	var init_flags(default, never):UInt64;
	var config(default, never):CodecConfig;
}

@:keep
@:structAccess
@:include('linc_vpx.h') @:native("::vpx_codec_iface")
extern class CodecInterface {
	var name:String;
	var abi_version:Int;
	var caps:Int64;
	var init:VpxInitFn;
}

@:keep
@:structAccess
@:include('linc_vpx.h') @:native("::vpx_codec_dec_cfg")
extern class CodecDecCfg {
	var threads:UInt32;
	var w:UInt32;
	var h:UInt32;

	public static inline function init():CodecDecCfg {
		return untyped __cpp__("::vpx_codec_dec_cfg{}");
	}
}

final VPX_IMG_FMT_NONE = 0;
final VPX_IMG_FMT_YV12 = VPX_IMG_FMT_PLANAR | VPX_IMG_FMT_UV_FLIP | 1; /**< planar YVU */

final VPX_IMG_FMT_I420 = VPX_IMG_FMT_PLANAR | 2;

final VPX_IMG_FMT_I422 = VPX_IMG_FMT_PLANAR | 5;
final VPX_IMG_FMT_I444 = VPX_IMG_FMT_PLANAR | 6;
final VPX_IMG_FMT_I440 = VPX_IMG_FMT_PLANAR | 7;
final VPX_IMG_FMT_NV12 = VPX_IMG_FMT_PLANAR | 9;
final VPX_IMG_FMT_I42016 = VPX_IMG_FMT_I420 | VPX_IMG_FMT_HIGHBITDEPTH;
final VPX_IMG_FMT_I42216 = VPX_IMG_FMT_I422 | VPX_IMG_FMT_HIGHBITDEPTH;
final VPX_IMG_FMT_I44416 = VPX_IMG_FMT_I444 | VPX_IMG_FMT_HIGHBITDEPTH;
final VPX_IMG_FMT_I44016 = VPX_IMG_FMT_I440 | VPX_IMG_FMT_HIGHBITDEPTH;

@:keep
@:include("linc_vpx.h")
@:native("::vpx_color_space")
extern enum abstract VpxColorSpace(Int) from Int to Int {
	final VPX_CS_UNKNOWN = 0; /**< Unknown */

	final VPX_CS_BT_601 = 1; /**< BT.601 */

	final VPX_CS_BT_709 = 2; /**< BT.709 */

	final VPX_CS_SMPTE_170 = 3; /**< SMPTE.170 */

	final VPX_CS_SMPTE_240 = 4; /**< SMPTE.240 */

	final VPX_CS_BT_2020 = 5; /**< BT.2020 */

	final VPX_CS_RESERVED = 6; /**< Reserved */

	final VPX_CS_SRGB = 7; /**< sRGB */

}

@:keep
@:include("linc_vpx.h")
@:native("::vpx_color_range")
extern enum abstract VpxColorRange(Int) from Int to Int {
	final VPX_CR_STUDIO_RANGE = 0; /**< Y [16..235], UV [16..240] */

	final VPX_CR_FULL_RANGE = 1; /**< YUV/RGB [0..255] */

}

@:keep
@:structAccess
@:include("linc_vpx.h")
@:native("::vpx_image_t")
extern class VpxImg {
	var fmt:Int;
	var cs:VpxColorSpace;
	var range:VpxColorRange;
	/* Image storage dimensions */
	var w:UInt32;
	var h:UInt32;
	var bit_depth:UInt32;
	/* Image display dimensions */
	var d_w:UInt32;
	var d_h:UInt32;

	/* Image render dimensions */
	var r_w:UInt32;
	var r_h:UInt32;

	/* Chroma subsampling info */
	var x_chroma_shift:UInt32;
	var y_chroma_shift:UInt32;

	var planes:Array<Pointer<UInt8>>;
	var stride:Array<Int>;

	/**< bits per sample (for packed formats) */
	var bps:Int;

	/* The following members should be treated as private. */
	var img_data:RawPointer<UInt8>;
	var img_data_owner:Int;
	var self_allocd:Int;

	var fb_priv:RawPointer<cpp.Void>;

	@:native("::vpx_img_free")
	public static function free(img:Pointer<VpxImg>):Void;
}

@:keep
@:structAccess
@:include("linc_vpx.h")
@:native("::vpx_image_rect")
extern class VpxImageRect {
	var x:Int;
	var y:Int;
	var w:Int;
	var h:Int;
}

typedef CodecConfig = {
	var dec:CodecDecCfg;
}

@:enum
abstract CodecError(Int) from Int to Int {
	/*!\brief Operation completed without error */
	var VPX_CODEC_OK = 0;
	/*!\brief Unspecified error */
	var VPX_CODEC_ERROR = 1;
	/*!\brief Memory operation failed */
	var VPX_CODEC_MEM_ERROR = 2;
	/*!\brief ABI version mismatch */
	var VPX_CODEC_ABI_MISMATCH = 3;
	/*!\brief Algorithm does not have required capability */
	var VPX_CODEC_INCAPABLE = 4;
	/*!\brief The given bitstream is not supported.
	 *
	 * The bitstream was unable to be parsed at the highest level. The decoder
	 * is unable to proceed. This error \ref SHOULD be treated as fatal to the
	 * stream. */
	var VPX_CODEC_UNSUP_BITSTREAM = 5;
	/*!\brief Encoded bitstream uses an unsupported feature
	 *
	 * The decoder does not implement a feature required by the encoder. This
	 * return code should only be used for features that prevent future
	 * pictures from being properly decoded. This error \ref MAY be treated as
	 * fatal to the stream or \ref MAY be treated as fatal to the current GOP.
	 */
	var VPX_CODEC_UNSUP_FEATURE = 6;
	/*!\brief The coded data for this stream is corrupt or incomplete
	 *
	 * There was a problem decoding the current frame.  This return code
	 * should only be used for failures that prevent future pictures from
	 * being properly decoded. This error \ref MAY be treated as fatal to the
	 * stream or \ref MAY be treated as fatal to the current GOP. If decoding
	 * is continued for the current GOP, artifacts may be present.
	 */
	var VPX_CODEC_CORRUPT_FRAME = 7;
	/*!\brief An application-supplied parameter is not valid.
	 *
	 */
	var VPX_CODEC_INVALID_PARAM = 8;
	/*!\brief An iterator reached the end of list.
	 *
	 */
	var VPX_CODEC_LIST_END = 9;
}

@:keep
@:structAccess
@:native("::vpx_codec_priv_enc_mr_cfg")
extern class VpxCodecPrivEncMrCfg {
	var mr_total_resolutions:UInt32;
	var mr_encoder_id:UInt32;
	var mr_down_sampling_factor:VpxRational;
	var mr_low_res_mode_info:RawPointer<cpp.Void>;
}

@:keep
@:structAccess
@:native("::vpx_rational")
extern class VpxRational {
	var num:Int;
	var den:Int;
}

typedef VpxInitFn = Callable<(ctx:Pointer<CodecContext>, data:Pointer<VpxCodecPrivEncMrCfg>) -> CodecError>;
