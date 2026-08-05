package scripts;

import haxe.io.Path;
import sys.io.File;
import haxe.Json;
import sys.FileSystem;

class BiomeTempShit {
	static var input = 'D:/minecraft/source/minecraft-26.2.0/data/minecraft/worldgen/biome';
	static var output = 'C:/Users/porti/MCreatorWorkspaces/seecret_updates/src/main/resources/data/seecret_updates/tags/worldgen/biome';

	static function main() {
		var warm:Array<String> = [];
		var cold:Array<String> = [];
		var hot:Array<String> = [];

		for (file in FileSystem.readDirectory(input).filter(f -> return StringTools.endsWith(f, 'json'))) {
			var parsed = Json.parse(File.getContent(input + '/' + file));
			var id = new Path(file).file;

			if (parsed.temperature < 0.6)
				cold.push(id);
			else if (parsed.temperature > 0.6)
				hot.push(id);
			else
				warm.push(id);
		}

		File.saveContent('${output}/warm.json', Json.stringify({
			values: warm
		}, '\t'));
		File.saveContent('${output}/cold.json', Json.stringify({
			values: cold
		}, '\t'));
		File.saveContent('${output}/hot.json', Json.stringify({
			values: hot
		}, '\t'));
	}

	/**
	 * You can use this function as a backend to write a custom sorting function (see byY() for an example).
	 */
	public static inline function byValues(Order:Int, Value1:Float, Value2:Float):Int {
		var result:Int = 0;

		if (Value1 < Value2) {
			result = Order;
		} else if (Value1 > Value2) {
			result = -Order;
		}

		return result;
	}
}
