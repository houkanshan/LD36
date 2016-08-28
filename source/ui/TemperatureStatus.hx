package ui;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;


class TemperatureStatus extends FlxSpriteGroup {

  private static inline var WIDTH = 300;
  private static inline var TEMP_TEXT_X = 20;
  private static inline var TEMP_TEXT_Y = 20;

  private var tempText:FlxText;

  public function new(X:Float = 0, Y:Float = 0, MaxSize:Int = 0, InitialTemp:Float = 30.5):Void {
    super(X, Y, MaxSize);

    var name = new FlxText(0, 0, WIDTH, "Temperature");
    name.setFormat(null, 14, GameConfig.SCREEN_COLOR_YELLOW0);
    tempText = new FlxText(TEMP_TEXT_X, TEMP_TEXT_Y, WIDTH, tempToText(InitialTemp));
    tempText.setFormat(null, 20, GameConfig.SCREEN_COLOR_YELLOW0);
    add(name);
    add(tempText);
  }

  public function setTemperature(temp:Float) {
    tempText.text = tempToText(temp);
  }

  private function tempToText(temp:Float) {
    return "" + Std.int(temp) + "." + Std.int(temp * 10) % 10 + "℃";
  }
}
