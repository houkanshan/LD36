package sprites;

import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.FlxSprite;

class Erasable extends FlxTypedGroup<FlxSprite> {
  public var brush:FlxSprite;
  public var eraseEnabled = false;

  var imageBack = "assets/images/test_cd.png";
  var imageFront = "assets/images/test_cd2.png";

  var x:Int;
  var y:Int;

  var origin:FlxSprite;
  var dirt:FlxSprite;

  var brushRadius = 10;

  var dirtTotalsPxCount:Int;
  var dirtCurrPxCount:Int;
  var percentage:Float = 1.0;

  var lastMouseX:Float = 0.0;
  var lastMouseY:Float = 0.0;

  public function new(_x:Int, _y:Int, _imageBack:String, _imageFront:String, _brushRaidus:Int):Void {
    super();

    x = _x;
    y = _y;
    imageBack = _imageBack;
    imageFront = _imageFront;
    brushRadius = _brushRaidus;


    origin = new FlxSprite();
    origin.loadGraphic(imageBack, false, 400, 400);

    dirt = new FlxSprite();
    dirt.loadGraphic(imageFront, false, 400, 400);

    brush = new FlxSprite();
    brush.makeGraphic(brushRadius*2, brushRadius*2, FlxColor.TRANSPARENT, true);
    FlxSpriteUtil.drawCircle(brush, brushRadius, brushRadius, brushRadius, FlxColor.YELLOW);

    add(origin);
    add(dirt);
//    add(brush); // for TEST
    dirtTotalsPxCount = getSolidPixelsCount(dirt.pixels);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    handleErase();
  }

  private function handleErase():Void {
    if (
      eraseEnabled &&
      brush.getPosition().inCoords(origin.x, origin.y, origin.width, origin.height)
    ) {
//      origin.pixels.copyPixels(source.pixels, new Rectangle(brush.x, brush.y, brush.pixels.rect.width, brush.pixels.rect.height), new Point(brush.x, brush.y), brush.pixels);
      for (innerY in 0...brushRadius*2) {
        var start = -1;
        var end = -1;
        for(innerX in 0...brushRadius*2) {
          if (start == -1) {
            if (brush.pixels.getPixel(innerX, innerY) != FlxColor.TRANSPARENT) {
              start = innerX;
            }
          } else if (end == -1) {
            if (brush.pixels.getPixel(innerX, innerY) == FlxColor.TRANSPARENT) {
              end = innerX;
              break;
            }
          }
        }
        if (end == -1) { end = brushRadius*2; }

//        origin.pixels.copyPixels(dirt.pixels, new Rectangle(brush.x + start, brush.y + y, end - start, 1), new Point(brush.x + start, brush.y + y));
        dirt.pixels.colorTransform(new Rectangle(brush.x + start - x, brush.y + innerY - y, end - start, 1), new ColorTransform(0, 0, 0, 0));
      }

      dirt.framePixels = dirt.pixels;

      // Reduce the frequence of counting.
      if (Math.abs(lastMouseX - FlxG.mouse.x) > 3 || Math.abs(lastMouseY - FlxG.mouse.y) > 3) {
        countPercentage();
      }
      lastMouseX = FlxG.mouse.x;
      lastMouseY = FlxG.mouse.y;
    }
  }

  private function getSolidPixelsCount(bitmap:BitmapData):Int {
    var count = 0;
    for (y in 0...bitmap.height) {
      for (x in 0...bitmap.width) {
        if (bitmap.getPixel(x, y) != FlxColor.TRANSPARENT) {
          count += 1;
        }
      }
    }
    return count;
  }

  private function countPercentage() {
    percentage = getSolidPixelsCount(dirt.pixels) / dirtTotalsPxCount;
  }
}
