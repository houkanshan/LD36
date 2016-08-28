package sprites;

import haxe.Log;
import flixel.tweens.FlxTween;
import sprites.TechThing.TechThingState;
import openfl.geom.Point;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.util.FlxColor;


class Machine extends FlxTypedGroup<FlxSprite> {

  var x:Float;
  var y:Float;

  var buttonsPoint = new Point(150, 150);
  var buttonMargin = 50;

  public var entrance:Dropable<TechThing>;
  public var exit:FlxSprite;

  public var currentTechThing:TechThing;

  var body:FlxSprite;

  public function new(_x:Float = 0.0, _y:Float = 0.0) {
    super();
    x = _x;
    y = _y;

    body = new FlxSprite(x, y);
    body.makeGraphic(300, 200, FlxColor.YELLOW);
    add(body);

    loadEntrance();
    loadExit();
    loadButtons();
  }

  override public function update(elasped:Float):Void {
    super.update(elasped);
  }

  function loadEntrance():Void {
    entrance = new Dropable(x + 100, y + 50, "TODO", "TODO");
    add(entrance);
    haxe.Log.trace("entrace loaded");
    entrance.handleDrop = handleEntranceDrop;

  }
  function handleEntranceDrop(techThing:TechThing) {
    currentTechThing = techThing;
    entrance.setHover(false, techThing);
    entrance.isItemPlaced = true;
  }


  function loadExit():Void {
    exit = new FlxSprite(x + 10, y + 50);
    exit.makeGraphic(80, 80, FlxColor.BLUE);
    add(exit);
  }

  function loadButtons():Void {
    for (i in 0...5) {
      var button = new FlxButton(x + buttonsPoint.x + i*buttonMargin, y + buttonsPoint.y);
      button.makeGraphic(30, 10, FlxColor.BROWN);
      add(button);
      button.onUp.callback = startFinishProcess;
    }
  }

  function startFinishProcess():Void {
    Log.trace("start");

    if (currentTechThing == null) { return; }
    FlxTween.linearMotion(currentTechThing,
      currentTechThing.x, currentTechThing.y,
      exit.getMidpoint().x - currentTechThing.width/2, exit.getMidpoint().y - currentTechThing.height/2,
      0.2, true, { onComplete: onFinishedProcess }
    );
  }
  function onFinishedProcess(tween:FlxTween):Void {
    entrance.setHover(false);
    entrance.isItemPlaced = false;
    currentTechThing.setState(TechThingState.ProcessFinished);
  }


}

