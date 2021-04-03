import vpx.WebmReader;
import haxe.io.Path;
import sys.FileSystem;
#if linc_stb
import stb.ImageWrite;
#end

class Test {
	static function main() {

		var file = '${Sys.getCwd()}${Sys.args()[0]}';
		if (!FileSystem.exists(file)) {
			throw 'File ${file} doesn\'t exists!';
		}
		webm(file);
	}

	static function webm(file) {
		trace('Opening file: $file');
		var path = new Path(file);
		var handle = WebmReader.load(file);

		var out_folder = '${path.dir}/out';
		trace('Creating out folder in: $out_folder');
		FileSystem.createDirectory(out_folder);

		var out;
		for (i in 0...100) {
			out = WebmReader.read_frame(cast handle);
			trace('Reading image #${i}: ${out.width}x${out.height}');
			#if linc_stb
			ImageWrite.write_png('${path.dir}/out/${path.file}_img_${i}.png', out.width, out.height, out.comp, out.data, 0, 0, 0);
			#end
		}

		WebmReader.close(cast handle);
	}
}
