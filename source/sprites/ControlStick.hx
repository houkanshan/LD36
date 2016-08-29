package sprites;

import flixel.FlxG;
import flixel.FlxSprite;


class ControlStick extends FlxSprite {

  private static inline CENTER_FRAME = 0;
  private static inline LEFT_FRAME = 1;
  private static inline UP_FRAME = 2;
  private static inline RIGHT_FRAME = 3;
  private static inline DOWN_FRAME = 4;

  override function new() {
    super();
    setupGraphic();
  }

  override function update(elapsed:Float):Void {
    if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A) {
      animation.frameIndex = LEFT_FRAME;
    } else if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D) {
      animation.frameIndex = RIGHT_FRAME;
    } else if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W) {
      animation.frameIndex = UP_FRAME;
    } else if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S) {
      animation.frameIndex = DOWN_FRAME;
    } else {
      animation.frameIndex = CENTER_FRAME;
    }
    super.update(elapsed);
  }

  private function setupGraphic():Void {
  }
}
