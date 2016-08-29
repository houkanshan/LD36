package ui;

import flixel.text.FlxText;

class PercentageText extends FlxText {

  private static inline var WIDTH = 300;

  private var tempText:FlxText;
  private var name:FlxText;

  public function new(X:Float = 0, Y:Float = 0):Void {
    super(X, Y, 0, "100%");
  }

  public function setPercentage(percentage:Float) {
    text = "" + Std.int(percentage * 100) + "." + (Std.int(percentage * 10000) % 100) + "%";
  }
}
