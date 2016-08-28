package sprites;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Dropable<T> extends FlxSprite {
  public var relatedItem:T;
  public var isItemPlaced:Bool = false;
  public var handleDrop:T->Void;

  var isHover:Bool = false;

  var normalImage:String;
  var onDropImage:String;

  public function new(X:Float = 0, Y:Float = 0, _normalImage:String, _onDropImage:String) {
    super(X, Y);

    normalImage = _normalImage;
    onDropImage = _onDropImage;

    setHover(isHover);
  }

  override public function update(elasped:Float):Void {
    super.update(elasped);
  }

  public function setHover(_isHover:Bool = true, ?_item:T):Void {
    isHover = _isHover;
    relatedItem = _item;
//    loadGraphic(isHover ? onDropImage : normalImage); // TODO
    if (isHover) {
      makeGraphic(60, 70, FlxColor.RED);
    } else {
      makeGraphic(60, 70, FlxColor.ORANGE);
    }
  }
}

