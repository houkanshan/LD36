package;

import flixel.util.FlxColor;


class GameConfig {
  public static inline var GAME_TIME = 72 * 60;
  public static inline var SCREEN_COLOR_YELLOW0 = 0xFFFAEF38;
  public static inline var SCREEN_COLOR_YELLOW1 = 0xFF7F7C15;

  public static inline var SCREEN_COLOR_GREEN = FlxColor.GREEN;

  public static inline var COOLING_PROC_INITIAL_TEMP = 30.5;
  public static inline var COOLING_PROC_TEMP_DEC = 2.0;
  public static inline var COOLING_PROC_TIMEOUT = 10;
  public static inline var COOLING_PROC_LOWER_TEMP = -40;
  public static inline var COOLING_PROC_UPPER_TEMP = -30;
  public static inline var COOLING_PROC_TEMP_INC_SPEED = 5;

  public static inline var ELECTROP_PROC_CURSOR_INC_SPEED= 60;
  public static inline var ELECTROP_PROC_CURSOR_DEC_SPEED= 90;
  public static inline var ELECTROP_PROC_VALID_AREA_SPEED= 10;
}
