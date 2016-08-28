package sprites;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Dropable extends FlxSprite {
  public var relatedItem:FlxSprite;
  public var isItemPlaced:Bool = false;

  var isOnDrop:Bool= false;

  var normalImage:String;
  var onDropImage:String;

  public function new(X:Float = 0, Y:Float = 0, _normalImage:String, _onDropImage:String) {
    super(X, Y);

    normalImage = _normalImage;
    onDropImage = _onDropImage;

    setOnDrop(isOnDrop);
  }

  override public function update(elasped:Float):Void {
    super.update(elasped);
  }

  public function setOnDrop(_isOnDrop:Bool = true, ?_item:FlxSprite):Void {
    isOnDrop = _isOnDrop;
    relatedItem = _item;
//    loadGraphic(isOnDrop ? onDropImage : normalImage); // TODO
    if (isOnDrop) {
      makeGraphic(60, 70, FlxColor.RED);
    } else {
      makeGraphic(60, 70, FlxColor.ORANGE);
    }
  }
}

