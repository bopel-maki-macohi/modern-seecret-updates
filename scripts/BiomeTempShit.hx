package scripts;

import haxe.io.Path;
import sys.io.File;
import haxe.Json;
import sys.FileSystem;

class BiomeTempShit {
	static var path = 'D:/minecraft/source/minecraft-26.2.0/data/minecraft/worldgen/biome';

	static function main() {
		var warm:Array<String> = [];
		var cold:Array<String> = [];
		var hot:Array<String> = [];

		for (file in FileSystem.readDirectory(path).filter(f -> return StringTools.endsWith(f, 'json'))) {
			var parsed = Json.parse(File.getContent(path + '/' + file));
			var id = new Path(file).file;

			if (parsed.temperature < 0.6) cold.push(id);
			else if (parsed.temperature > 0.6) hot.push(id);
            else warm.push(id);
		}

        FileSystem.createDirectory('data/biomes');

        File.saveContent('data/biomes/warm.txt', warm.join('\n'));
        File.saveContent('data/biomes/hot.txt', hot.join('\n'));
        File.saveContent('data/biomes/cold.txt', cold.join('\n'));
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
