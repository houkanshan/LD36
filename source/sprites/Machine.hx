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
  var onBeginProcedures:TechThing->Void;

  public var entrance:Dropable<TechThing>;
  public var exit:FlxSprite;

  public var currentTechThing:TechThing;

  var body:FlxSprite;

  public function new(_x:Float = 0.0, _y:Float = 0.0, _onBeginProcedures:TechThing->Void) {
    super();
    x = _x;
    y = _y;
    onBeginProcedures = _onBeginProcedures;

    body = new FlxSprite(x, y);
    body.makeGraphic(300, 200, FlxColor.YELLOW);
    add(body);

    loadEntrance();
    loadExit();
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
    onBeginProcedures(techThing);
  }


  function loadExit():Void {
    exit = new FlxSprite(x + 10, y + 50);
    exit.makeGraphic(80, 80, FlxColor.BLUE);
    add(exit);
  }

  public function startFinishProcess():Void {
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

