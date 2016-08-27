package ui;

import flixel.addons.ui.FlxUIText;
import flixel.util.FlxTimer;

import GameConfig;


class TimerBar extends FlxUIText {

  public function new(x:Float = 0, y:Float = 0, fieldWidth:Float = 0,
                      ?text:String, size:Int = 8, embeddedFont:Bool = true) {
    super(x, y, fieldWidth, "72:00", size, embeddedFont);
    timer = new FlxTimer();
  }

  public function start():Void {
    isStarted = true;
    timer.start(GameConfig.GAME_TIME, onComplete);
  }

  private function onComplete(timer:FlxTimer):Void {
    isStarted = false;
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    if (isStarted) {
      text = timeToString(timer.timeLeft);
    }
  }

  private function timeToString(time:Float):String {
    var min:Int = Std.int(time) % 60;
    var hour:Int = Std.int(time / 60);
    return "" + hour + ":" + min;
  }

  private var timer:FlxTimer;
  private var isStarted:Bool = false;
}
