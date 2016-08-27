package sprites;

import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxAssets;


class BaseItemSprite extends FlxExtendedSprite {

  private var originalX:Float;
  private var originalY:Float;


  public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset, isDraggable:Bool = true) {
    super(X, Y, SimpleGraphic);
    if (isDraggable) {
      enableMouseDrag();
    }
  }

  private function enableDrag() {
    mouseStartDragCallback = onDragStart;
    mouseStopDragCallback = onDragStart;
    enableMouseDrag();
  }

  private function onDragStart(sprite:FlxExtendedSprite, x:Float, y:Float):Void {
    originalX = x;
    originalY = y;
  }

  private function onDragStop(sprite:FlxExtendedSprite, x:Float, y:Float):Void {
    x = originalX;
    y = originalY;
  }

}
