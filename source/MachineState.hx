package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

import procedures.CoolingProcedure;
import procedures.CleaningProcedure;
import ui.ScreenMenu;
import ui.TimerBar;

class MachineState extends FlxState {
  public static inline var SCREEN_X = 100;
  public static inline var SCREEN_Y = 50;
  public static inline var SCREEN_WIDTH = 600;
  public static inline var SCREEN_HEIGHT = 300;
  public static inline var SCREEN_MENU_X = 448;
  public static inline var SCREEN_MENU_Y = 2;


  public var screen:FlxSpriteGroup;
  public var screenMenu:ScreenMenu;

  private var timerBar:TimerBar;

  private var currentProc:FlxSpriteGroup;

  override public function create():Void {
    super.create();
    bgColor = FlxColor.WHITE;
    createScreen();
    // createTimerBar();
    startProc();
  }

  public function startProc():Void {
    if (currentProc != null) {
      remove(currentProc);
    }
    currentProc = new CoolingProcedure();
    screen.add(currentProc);
  }

  override public function update(elapsed:Float):Void {
    if (currentProc != null) {
      currentProc.update(elapsed);
    }
    super.update(elapsed);
  }

  private function createTimerBar():Void {
    timerBar = new TimerBar(10, 10);
    add(timerBar);
    timerBar.start();
  }

  private function createScreen():Void {
    screen = new FlxSpriteGroup(SCREEN_X, SCREEN_Y);
    add(screen);
    var screenBg = new FlxSprite(0, 0);
    screenBg.makeGraphic(SCREEN_WIDTH, SCREEN_HEIGHT, FlxColor.BLACK, true);
    screen.add(screenBg);
    createScreenMenu();
  }

  private function createScreenMenu():Void {
    screenMenu = new ScreenMenu();
    screenMenu.x = SCREEN_MENU_X;
    screenMenu.y = SCREEN_MENU_Y;
    screen.add(screenMenu);
  }


}
