package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class PaperSubstate extends FlxSubState {
  var paper:FlxSprite;
  public function new(_paper:FlxSprite):Void {
    super();
    paper = _paper;

  }

  override public function create():Void {
    super.create();

    var background:FlxSprite = new FlxSprite(0, 0);
    background.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    background.alpha = 0.3;
    add(background);

    add(paper);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    if (
      FlxG.mouse.justPressed &&
      (
        FlxG.mouse.x < paper.x ||
        FlxG.mouse.x > paper.x + paper.width
      )
    ) {
      close();
    }
  }
}
