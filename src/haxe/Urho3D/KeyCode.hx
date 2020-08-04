package urho3d;



@:enum abstract SDL_SCANCODE(Int) to Int
{
    var SDL_SCANCODE_UNKNOWN = 0;

    var SDL_SCANCODE_A = 4;
    var SDL_SCANCODE_B = 5;
    var SDL_SCANCODE_C = 6;
    var SDL_SCANCODE_D = 7;
    var SDL_SCANCODE_E = 8;
    var SDL_SCANCODE_F = 9;
    var SDL_SCANCODE_G = 10;
    var SDL_SCANCODE_H = 11;
    var SDL_SCANCODE_I = 12;
    var SDL_SCANCODE_J = 13;
    var SDL_SCANCODE_K = 14;
    var SDL_SCANCODE_L = 15;
    var SDL_SCANCODE_M = 16;
    var SDL_SCANCODE_N = 17;
    var SDL_SCANCODE_O = 18;
    var SDL_SCANCODE_P = 19;
    var SDL_SCANCODE_Q = 20;
    var SDL_SCANCODE_R = 21;
    var SDL_SCANCODE_S = 22;
    var SDL_SCANCODE_T = 23;
    var SDL_SCANCODE_U = 24;
    var SDL_SCANCODE_V = 25;
    var SDL_SCANCODE_W = 26;
    var SDL_SCANCODE_X = 27;
    var SDL_SCANCODE_Y = 28;
    var SDL_SCANCODE_Z = 29;

    var SDL_SCANCODE_1 = 30;
    var SDL_SCANCODE_2 = 31;
    var SDL_SCANCODE_3 = 32;
    var SDL_SCANCODE_4 = 33;
    var SDL_SCANCODE_5 = 34;
    var SDL_SCANCODE_6 = 35;
    var SDL_SCANCODE_7 = 36;
    var SDL_SCANCODE_8 = 37;
    var SDL_SCANCODE_9 = 38;
    var SDL_SCANCODE_0 = 39;

    var SDL_SCANCODE_RETURN = 40;
    var SDL_SCANCODE_ESCAPE = 41;
    var SDL_SCANCODE_BACKSPACE = 42;
    var SDL_SCANCODE_TAB = 43;
    var SDL_SCANCODE_SPACE = 44;

    var SDL_SCANCODE_MINUS = 45;
    var SDL_SCANCODE_EQUALS = 46;
    var SDL_SCANCODE_LEFTBRACKET = 47;
    var SDL_SCANCODE_RIGHTBRACKET = 48;
    var SDL_SCANCODE_BACKSLASH = 49; /**< Located at the lower left of the return
                                  *   key on ISO keyboards and at the right end
                                  *   of the QWERTY row on ANSI keyboards.
                                  *   Produces REVERSE SOLIDUS (backslash) and
                                  *   VERTICAL LINE in a US layout; REVERSE
                                  *   SOLIDUS and VERTICAL LINE in a UK Mac
                                  *   layout; NUMBER SIGN and TILDE in a UK
                                  *   Windows layout; DOLLAR SIGN and POUND SIGN
                                  *   in a Swiss German layout; NUMBER SIGN and
                                  *   APOSTROPHE in a German layout; GRAVE
                                  *   ACCENT and POUND SIGN in a French Mac
                                  *   layout; and ASTERISK and MICRO SIGN in a
                                  *   French Windows layout.
                                  */
    var SDL_SCANCODE_NONUSHASH = 50; /**< ISO USB keyboards actually use this code
                                  *   instead of 49 for the same key; but all
                                  *   OSes I've seen treat the two codes
                                  *   identically. So; as an implementor; unless
                                  *   your keyboard generates both of those
                                  *   codes and your OS treats them differently;
                                  *   you should generate var SDL_SCANCODE_BACKSLASH
                                  *   instead of this code. As a user; you
                                  *   should not rely on this code because SDL
                                  *   will never generate it with most (all?)
                                  *   keyboards.
                                  */
    var SDL_SCANCODE_SEMICOLON = 51;
    var SDL_SCANCODE_APOSTROPHE = 52;
    var SDL_SCANCODE_GRAVE = 53; /**< Located in the top left corner (on both ANSI
                              *   and ISO keyboards). Produces GRAVE ACCENT and
                              *   TILDE in a US Windows layout and in US and UK
                              *   Mac layouts on ANSI keyboards; GRAVE ACCENT
                              *   and NOT SIGN in a UK Windows layout; SECTION
                              *   SIGN and PLUS-MINUS SIGN in US and UK Mac
                              *   layouts on ISO keyboards; SECTION SIGN and
                              *   DEGREE SIGN in a Swiss German layout (Mac:
                              *   only on ISO keyboards); CIRCUMFLEX ACCENT and
                              *   DEGREE SIGN in a German layout (Mac: only on
                              *   ISO keyboards); SUPERSCRIPT TWO and TILDE in a
                              *   French Windows layout; COMMERCIAL AT and
                              *   NUMBER SIGN in a French Mac layout on ISO
                              *   keyboards; and LESS-THAN SIGN and GREATER-THAN
                              *   SIGN in a Swiss German; German; or French Mac
                              *   layout on ANSI keyboards.
                              */
    var SDL_SCANCODE_COMMA = 54;
    var SDL_SCANCODE_PERIOD = 55;
    var SDL_SCANCODE_SLASH = 56;

    var SDL_SCANCODE_CAPSLOCK = 57;

    var SDL_SCANCODE_F1 = 58;
    var SDL_SCANCODE_F2 = 59;
    var SDL_SCANCODE_F3 = 60;
    var SDL_SCANCODE_F4 = 61;
    var SDL_SCANCODE_F5 = 62;
    var SDL_SCANCODE_F6 = 63;
    var SDL_SCANCODE_F7 = 64;
    var SDL_SCANCODE_F8 = 65;
    var SDL_SCANCODE_F9 = 66;
    var SDL_SCANCODE_F10 = 67;
    var SDL_SCANCODE_F11 = 68;
    var SDL_SCANCODE_F12 = 69;

    var SDL_SCANCODE_PRINTSCREEN = 70;
    var SDL_SCANCODE_SCROLLLOCK = 71;
    var SDL_SCANCODE_PAUSE = 72;
    var SDL_SCANCODE_INSERT = 73; /**< insert on PC; help on some Mac keyboards (but
                                   does send code 73; not 117) */
    var SDL_SCANCODE_HOME = 74;
    var SDL_SCANCODE_PAGEUP = 75;
    var SDL_SCANCODE_DELETE = 76;
    var SDL_SCANCODE_END = 77;
    var SDL_SCANCODE_PAGEDOWN = 78;
    var SDL_SCANCODE_RIGHT = 79;
    var SDL_SCANCODE_LEFT = 80;
    var SDL_SCANCODE_DOWN = 81;
    var SDL_SCANCODE_UP = 82;

    var SDL_SCANCODE_NUMLOCKCLEAR = 83; /**< num lock on PC; clear on Mac keyboards
                                     */
    var SDL_SCANCODE_KP_DIVIDE = 84;
    var SDL_SCANCODE_KP_MULTIPLY = 85;
    var SDL_SCANCODE_KP_MINUS = 86;
    var SDL_SCANCODE_KP_PLUS = 87;
    var SDL_SCANCODE_KP_ENTER = 88;
    var SDL_SCANCODE_KP_1 = 89;
    var SDL_SCANCODE_KP_2 = 90;
    var SDL_SCANCODE_KP_3 = 91;
    var SDL_SCANCODE_KP_4 = 92;
    var SDL_SCANCODE_KP_5 = 93;
    var SDL_SCANCODE_KP_6 = 94;
    var SDL_SCANCODE_KP_7 = 95;
    var SDL_SCANCODE_KP_8 = 96;
    var SDL_SCANCODE_KP_9 = 97;
    var SDL_SCANCODE_KP_0 = 98;
    var SDL_SCANCODE_KP_PERIOD = 99;

    var SDL_SCANCODE_NONUSBACKSLASH = 100; /**< This is the additional key that ISO
                                        *   keyboards have over ANSI ones;
                                        *   located between left shift and Y.
                                        *   Produces GRAVE ACCENT and TILDE in a
                                        *   US or UK Mac layout; REVERSE SOLIDUS
                                        *   (backslash) and VERTICAL LINE in a
                                        *   US or UK Windows layout; and
                                        *   LESS-THAN SIGN and GREATER-THAN SIGN
                                        *   in a Swiss German; German; or French
                                        *   layout. */
    var SDL_SCANCODE_APPLICATION = 101; /**< windows contextual menu; compose */
    var SDL_SCANCODE_POWER = 102; /**< The USB document says this is a status flag;
                               *   not a physical key - but some Mac keyboards
                               *   do have a power key. */
    var SDL_SCANCODE_KP_EQUALS = 103;
    var SDL_SCANCODE_F13 = 104;
    var SDL_SCANCODE_F14 = 105;
    var SDL_SCANCODE_F15 = 106;
    var SDL_SCANCODE_F16 = 107;
    var SDL_SCANCODE_F17 = 108;
    var SDL_SCANCODE_F18 = 109;
    var SDL_SCANCODE_F19 = 110;
    var SDL_SCANCODE_F20 = 111;
    var SDL_SCANCODE_F21 = 112;
    var SDL_SCANCODE_F22 = 113;
    var SDL_SCANCODE_F23 = 114;
    var SDL_SCANCODE_F24 = 115;
    var SDL_SCANCODE_EXECUTE = 116;
    var SDL_SCANCODE_HELP = 117;
    var SDL_SCANCODE_MENU = 118;
    var SDL_SCANCODE_SELECT = 119;
    var SDL_SCANCODE_STOP = 120;
    var SDL_SCANCODE_AGAIN = 121;   /**< redo */
    var SDL_SCANCODE_UNDO = 122;
    var SDL_SCANCODE_CUT = 123;
    var SDL_SCANCODE_COPY = 124;
    var SDL_SCANCODE_PASTE = 125;
    var SDL_SCANCODE_FIND = 126;
    var SDL_SCANCODE_MUTE = 127;
    var SDL_SCANCODE_VOLUMEUP = 128;
    var SDL_SCANCODE_VOLUMEDOWN = 129;
/* not sure whether there's a reason to enable these */
/*     var SDL_SCANCODE_LOCKINGCAPSLOCK = 130;  */
/*     var SDL_SCANCODE_LOCKINGNUMLOCK = 131; */
/*     var SDL_SCANCODE_LOCKINGSCROLLLOCK = 132; */
    var SDL_SCANCODE_KP_COMMA = 133;
    var SDL_SCANCODE_KP_EQUALSAS400 = 134;

    var SDL_SCANCODE_INTERNATIONAL1 = 135; /**< used on Asian keyboards; see
                                            footnotes in USB doc */
    var SDL_SCANCODE_INTERNATIONAL2 = 136;
    var SDL_SCANCODE_INTERNATIONAL3 = 137; /**< Yen */
    var SDL_SCANCODE_INTERNATIONAL4 = 138;
    var SDL_SCANCODE_INTERNATIONAL5 = 139;
    var SDL_SCANCODE_INTERNATIONAL6 = 140;
    var SDL_SCANCODE_INTERNATIONAL7 = 141;
    var SDL_SCANCODE_INTERNATIONAL8 = 142;
    var SDL_SCANCODE_INTERNATIONAL9 = 143;
    var SDL_SCANCODE_LANG1 = 144; /**< Hangul/English toggle */
    var SDL_SCANCODE_LANG2 = 145; /**< Hanja conversion */
    var SDL_SCANCODE_LANG3 = 146; /**< Katakana */
    var SDL_SCANCODE_LANG4 = 147; /**< Hiragana */
    var SDL_SCANCODE_LANG5 = 148; /**< Zenkaku/Hankaku */
    var SDL_SCANCODE_LANG6 = 149; /**< reserved */
    var SDL_SCANCODE_LANG7 = 150; /**< reserved */
    var SDL_SCANCODE_LANG8 = 151; /**< reserved */
    var SDL_SCANCODE_LANG9 = 152; /**< reserved */

    var SDL_SCANCODE_ALTERASE = 153; /**< Erase-Eaze */
    var SDL_SCANCODE_SYSREQ = 154;
    var SDL_SCANCODE_CANCEL = 155;
    var SDL_SCANCODE_CLEAR = 156;
    var SDL_SCANCODE_PRIOR = 157;
    var SDL_SCANCODE_RETURN2 = 158;
    var SDL_SCANCODE_SEPARATOR = 159;
    var SDL_SCANCODE_OUT = 160;
    var SDL_SCANCODE_OPER = 161;
    var SDL_SCANCODE_CLEARAGAIN = 162;
    var SDL_SCANCODE_CRSEL = 163;
    var SDL_SCANCODE_EXSEL = 164;

    var SDL_SCANCODE_KP_00 = 176;
    var SDL_SCANCODE_KP_000 = 177;
    var SDL_SCANCODE_THOUSANDSSEPARATOR = 178;
    var SDL_SCANCODE_DECIMALSEPARATOR = 179;
    var SDL_SCANCODE_CURRENCYUNIT = 180;
    var SDL_SCANCODE_CURRENCYSUBUNIT = 181;
    var SDL_SCANCODE_KP_LEFTPAREN = 182;
    var SDL_SCANCODE_KP_RIGHTPAREN = 183;
    var SDL_SCANCODE_KP_LEFTBRACE = 184;
    var SDL_SCANCODE_KP_RIGHTBRACE = 185;
    var SDL_SCANCODE_KP_TAB = 186;
    var SDL_SCANCODE_KP_BACKSPACE = 187;
    var SDL_SCANCODE_KP_A = 188;
    var SDL_SCANCODE_KP_B = 189;
    var SDL_SCANCODE_KP_C = 190;
    var SDL_SCANCODE_KP_D = 191;
    var SDL_SCANCODE_KP_E = 192;
    var SDL_SCANCODE_KP_F = 193;
    var SDL_SCANCODE_KP_XOR = 194;
    var SDL_SCANCODE_KP_POWER = 195;
    var SDL_SCANCODE_KP_PERCENT = 196;
    var SDL_SCANCODE_KP_LESS = 197;
    var SDL_SCANCODE_KP_GREATER = 198;
    var SDL_SCANCODE_KP_AMPERSAND = 199;
    var SDL_SCANCODE_KP_DBLAMPERSAND = 200;
    var SDL_SCANCODE_KP_VERTICALBAR = 201;
    var SDL_SCANCODE_KP_DBLVERTICALBAR = 202;
    var SDL_SCANCODE_KP_COLON = 203;
    var SDL_SCANCODE_KP_HASH = 204;
    var SDL_SCANCODE_KP_SPACE = 205;
    var SDL_SCANCODE_KP_AT = 206;
    var SDL_SCANCODE_KP_EXCLAM = 207;
    var SDL_SCANCODE_KP_MEMSTORE = 208;
    var SDL_SCANCODE_KP_MEMRECALL = 209;
    var SDL_SCANCODE_KP_MEMCLEAR = 210;
    var SDL_SCANCODE_KP_MEMADD = 211;
    var SDL_SCANCODE_KP_MEMSUBTRACT = 212;
    var SDL_SCANCODE_KP_MEMMULTIPLY = 213;
    var SDL_SCANCODE_KP_MEMDIVIDE = 214;
    var SDL_SCANCODE_KP_PLUSMINUS = 215;
    var SDL_SCANCODE_KP_CLEAR = 216;
    var SDL_SCANCODE_KP_CLEARENTRY = 217;
    var SDL_SCANCODE_KP_BINARY = 218;
    var SDL_SCANCODE_KP_OCTAL = 219;
    var SDL_SCANCODE_KP_DECIMAL = 220;
    var SDL_SCANCODE_KP_HEXADECIMAL = 221;

    var SDL_SCANCODE_LCTRL = 224;
    var SDL_SCANCODE_LSHIFT = 225;
    var SDL_SCANCODE_LALT = 226; /**< alt; option */
    var SDL_SCANCODE_LGUI = 227; /**< windows; command (apple); meta */
    var SDL_SCANCODE_RCTRL = 228;
    var SDL_SCANCODE_RSHIFT = 229;
    var SDL_SCANCODE_RALT = 230; /**< alt gr; option */
    var SDL_SCANCODE_RGUI = 231; /**< windows; command (apple); meta */

    var SDL_SCANCODE_MODE = 257;    /**< I'm not sure if this is really not covered
                                 *   by any of the above; but since there's a
                                 *   special KMOD_MODE for it I'm adding it here
                                 */

    /* @} *//* Usage page 0x07 */

    /**
     *  \name Usage page 0x0C
     *
     *  These values are mapped from usage page 0x0C (USB consumer page).
     */
    /* @{ */

    var SDL_SCANCODE_AUDIONEXT = 258;
    var SDL_SCANCODE_AUDIOPREV = 259;
    var SDL_SCANCODE_AUDIOSTOP = 260;
    var SDL_SCANCODE_AUDIOPLAY = 261;
    var SDL_SCANCODE_AUDIOMUTE = 262;
    var SDL_SCANCODE_MEDIASELECT = 263;
    var SDL_SCANCODE_WWW = 264;
    var SDL_SCANCODE_MAIL = 265;
    var SDL_SCANCODE_CALCULATOR = 266;
    var SDL_SCANCODE_COMPUTER = 267;
    var SDL_SCANCODE_AC_SEARCH = 268;
    var SDL_SCANCODE_AC_HOME = 269;
    var SDL_SCANCODE_AC_BACK = 270;
    var SDL_SCANCODE_AC_FORWARD = 271;
    var SDL_SCANCODE_AC_STOP = 272;
    var SDL_SCANCODE_AC_REFRESH = 273;
    var SDL_SCANCODE_AC_BOOKMARKS = 274;

    /* @} *//* Usage page 0x0C */

    /**
     *  \name Walther keys
     *
     *  These are values that Christian Walther added (for mac keyboard?).
     */
    /* @{ */

    var SDL_SCANCODE_BRIGHTNESSDOWN = 275;
    var SDL_SCANCODE_BRIGHTNESSUP = 276;
    var SDL_SCANCODE_DISPLAYSWITCH = 277; /**< display mirroring/dual display
                                           switch; video mode switch */
    var SDL_SCANCODE_KBDILLUMTOGGLE = 278;
    var SDL_SCANCODE_KBDILLUMDOWN = 279;
    var SDL_SCANCODE_KBDILLUMUP = 280;
    var SDL_SCANCODE_EJECT = 281;
    var SDL_SCANCODE_SLEEP = 282;

    var SDL_SCANCODE_APP1 = 283;
    var SDL_SCANCODE_APP2 = 284;

    /* @} *//* Walther keys */

    /**
     *  \name Usage page 0x0C (additional media keys)
     *
     *  These values are mapped from usage page 0x0C (USB consumer page).
     */
    /* @{ */

    var SDL_SCANCODE_AUDIOREWIND = 285;
    var SDL_SCANCODE_AUDIOFASTFORWARD = 286;

    /* @} *//* Usage page 0x0C (additional media keys) */

    /* Add any other keys here. */

    var SDL_NUM_SCANCODES = 512; /**< not a key; just marks the number of scancodes
                                 for array bounds */
}


//typedef SDLK_SCANCODE_MASK = (1<<30);
//typedef var 1<<30 | X) = (X | SDLK_SCANCODE_MASK);

enum abstract SDLKeyCodes(Int) to Int  from Int{
    var SDLK_UNKNOWN = ' '.code;
    var SDLK_RETURN = '\r'.code;
    var SDLK_ESCAPE = '\033'.code;
    var SDLK_BACKSPACE = 8;
    var SDLK_TAB = '\t'.code;
    var SDLK_SPACE = ' '.code;
    var SDLK_EXCLAIM = '!'.code;
    var SDLK_QUOTEDBL = '"'.code;
    var SDLK_HASH = '#'.code;
    var SDLK_PERCENT = '%'.code;
    var SDLK_DOLLAR = '$'.code;
    var SDLK_AMPERSAND = '&'.code;
    var SDLK_QUOTE = '\''.code;
    var SDLK_LEFTPAREN = '('.code;
    var SDLK_RIGHTPAREN = ')'.code;
    var SDLK_ASTERISK = '*'.code;
    var SDLK_PLUS = '+'.code;
    var SDLK_COMMA = ';'.code;
    var SDLK_MINUS = '-'.code;
    var SDLK_PERIOD = '.'.code;
    var SDLK_SLASH = '/'.code;
    var SDLK_0 = '0'.code;
    var SDLK_1 = '1'.code;
    var SDLK_2 = '2'.code;
    var SDLK_3 = '3'.code;
    var SDLK_4 = '4'.code;
    var SDLK_5 = '5'.code;
    var SDLK_6 = '6'.code;
    var SDLK_7 = '7'.code;
    var SDLK_8 = '8'.code;
    var SDLK_9 = '9'.code;
    var SDLK_COLON = ':'.code;
    var SDLK_SEMICOLON = ';'.code;
    var SDLK_LESS = '<'.code;
    var SDLK_EQUALS = '='.code;
    var SDLK_GREATER = '>'.code;
    var SDLK_QUESTION = '?'.code;
    var SDLK_AT = '@'.code;

        /*
       Skip uppercase letters
     */
     var SDLK_LEFTBRACKET = '['.code;
     var SDLK_BACKSLASH = '\\'.code;
     var SDLK_RIGHTBRACKET = ']'.code;
     var SDLK_CARET = '^'.code;
     var SDLK_UNDERSCORE = '_'.code;
     var SDLK_BACKQUOTE = '`'.code;
     var SDLK_a = 'a'.code;
     var SDLK_b = 'b'.code;
     var SDLK_c = 'c'.code;
     var SDLK_d = 'd'.code;
     var SDLK_e = 'e'.code;
     var SDLK_f = 'f'.code;
     var SDLK_g = 'g'.code;
     var SDLK_h = 'h'.code;
     var SDLK_i = 'i'.code;
     var SDLK_j = 'j'.code;
     var SDLK_k = 'k'.code;
     var SDLK_l = 'l'.code;
     var SDLK_m = 'm'.code;
     var SDLK_n = 'n'.code;
     var SDLK_o = 'o'.code;
     var SDLK_p = 'p'.code;
     var SDLK_q = 'q'.code;
     var SDLK_r = 'r'.code;
     var SDLK_s = 's'.code;
     var SDLK_t = 't'.code;
     var SDLK_u = 'u'.code;
     var SDLK_v = 'v'.code;
     var SDLK_w = 'w'.code;
     var SDLK_x = 'x'.code;
     var SDLK_y = 'y'.code;
     var SDLK_z = 'z'.code;

     var SDLK_DELETE = '\177'.code;
    var SDLK_CAPSLOCK = SDL_SCANCODE_CAPSLOCK | 1<<30 ;
    var SDLK_F1 = 1<<30 | SDL_SCANCODE_F1;
    var SDLK_F2 = 1<<30 | SDL_SCANCODE_F2;
    var SDLK_F3 = 1<<30 | SDL_SCANCODE_F3;
    var SDLK_F4 = 1<<30 | SDL_SCANCODE_F4;
    var SDLK_F5 = 1<<30 | SDL_SCANCODE_F5;
    var SDLK_F6 = 1<<30 | SDL_SCANCODE_F6;
    var SDLK_F7 = 1<<30 | SDL_SCANCODE_F7;
    var SDLK_F8 = 1<<30 | SDL_SCANCODE_F8;
    var SDLK_F9 = 1<<30 | SDL_SCANCODE_F9;
    var SDLK_F10 = 1<<30 | SDL_SCANCODE_F10;
    var SDLK_F11 = 1<<30 | SDL_SCANCODE_F11;
    var SDLK_F12 = 1<<30 | SDL_SCANCODE_F12;

    var SDLK_PRINTSCREEN = 1<<30 | SDL_SCANCODE_PRINTSCREEN;
    var SDLK_SCROLLLOCK = 1<<30 | SDL_SCANCODE_SCROLLLOCK;
    var SDLK_PAUSE = 1<<30 | SDL_SCANCODE_PAUSE;
    var SDLK_INSERT = 1<<30 | SDL_SCANCODE_INSERT;
    var SDLK_HOME = 1<<30 | SDL_SCANCODE_HOME;
    var SDLK_PAGEUP = 1<<30 | SDL_SCANCODE_PAGEUP;
 
    var SDLK_END = 1<<30 | SDL_SCANCODE_END;
    var SDLK_PAGEDOWN = 1<<30 | SDL_SCANCODE_PAGEDOWN;
    var SDLK_RIGHT = 1<<30 | SDL_SCANCODE_RIGHT;
    var SDLK_LEFT = 1<<30 | SDL_SCANCODE_LEFT;
    var SDLK_DOWN = 1<<30 | SDL_SCANCODE_DOWN;
    var SDLK_UP = 1<<30 | SDL_SCANCODE_UP;

    var SDLK_NUMLOCKCLEAR = 1<<30 | SDL_SCANCODE_NUMLOCKCLEAR;
    var SDLK_KP_DIVIDE = 1<<30 | SDL_SCANCODE_KP_DIVIDE;
    var SDLK_KP_MULTIPLY = 1<<30 | SDL_SCANCODE_KP_MULTIPLY;
    var SDLK_KP_MINUS = 1<<30 | SDL_SCANCODE_KP_MINUS;
    var SDLK_KP_PLUS = 1<<30 | SDL_SCANCODE_KP_PLUS;
    var SDLK_KP_ENTER = 1<<30 | SDL_SCANCODE_KP_ENTER;
    var SDLK_KP_1 = 1<<30 | SDL_SCANCODE_KP_1;
    var SDLK_KP_2 = 1<<30 | SDL_SCANCODE_KP_2;
    var SDLK_KP_3 = 1<<30 | SDL_SCANCODE_KP_3;
    var SDLK_KP_4 = 1<<30 | SDL_SCANCODE_KP_4;
    var SDLK_KP_5 = 1<<30 | SDL_SCANCODE_KP_5;
    var SDLK_KP_6 = 1<<30 | SDL_SCANCODE_KP_6;
    var SDLK_KP_7 = 1<<30 | SDL_SCANCODE_KP_7;
    var SDLK_KP_8 = 1<<30 | SDL_SCANCODE_KP_8;
    var SDLK_KP_9 = 1<<30 | SDL_SCANCODE_KP_9;
    var SDLK_KP_0 = 1<<30 | SDL_SCANCODE_KP_0;
    var SDLK_KP_PERIOD = 1<<30 | SDL_SCANCODE_KP_PERIOD;

    var SDLK_APPLICATION = 1<<30 | SDL_SCANCODE_APPLICATION;
    var SDLK_POWER = 1<<30 | SDL_SCANCODE_POWER;
    var SDLK_KP_EQUALS = 1<<30 | SDL_SCANCODE_KP_EQUALS;
    var SDLK_F13 = 1<<30 | SDL_SCANCODE_F13;
    var SDLK_F14 = 1<<30 | SDL_SCANCODE_F14;
    var SDLK_F15 = 1<<30 | SDL_SCANCODE_F15;
    var SDLK_F16 = 1<<30 | SDL_SCANCODE_F16;
    var SDLK_F17 = 1<<30 | SDL_SCANCODE_F17;
    var SDLK_F18 = 1<<30 | SDL_SCANCODE_F18;
    var SDLK_F19 = 1<<30 | SDL_SCANCODE_F19;
    var SDLK_F20 = 1<<30 | SDL_SCANCODE_F20;
    var SDLK_F21 = 1<<30 | SDL_SCANCODE_F21;
    var SDLK_F22 = 1<<30 | SDL_SCANCODE_F22;
    var SDLK_F23 = 1<<30 | SDL_SCANCODE_F23;
    var SDLK_F24 = 1<<30 | SDL_SCANCODE_F24;
    var SDLK_EXECUTE = 1<<30 | SDL_SCANCODE_EXECUTE;
    var SDLK_HELP = 1<<30 | SDL_SCANCODE_HELP;
    var SDLK_MENU = 1<<30 | SDL_SCANCODE_MENU;
    var SDLK_SELECT = 1<<30 | SDL_SCANCODE_SELECT;
    var SDLK_STOP = 1<<30 | SDL_SCANCODE_STOP;
    var SDLK_AGAIN = 1<<30 | SDL_SCANCODE_AGAIN;
    var SDLK_UNDO = 1<<30 | SDL_SCANCODE_UNDO;
    var SDLK_CUT = 1<<30 | SDL_SCANCODE_CUT;
    var SDLK_COPY = 1<<30 | SDL_SCANCODE_COPY;
    var SDLK_PASTE = 1<<30 | SDL_SCANCODE_PASTE;
    var SDLK_FIND = 1<<30 | SDL_SCANCODE_FIND;
    var SDLK_MUTE = 1<<30 | SDL_SCANCODE_MUTE;
    var SDLK_VOLUMEUP = 1<<30 | SDL_SCANCODE_VOLUMEUP;
    var SDLK_VOLUMEDOWN = 1<<30 | SDL_SCANCODE_VOLUMEDOWN;
    var SDLK_KP_COMMA = 1<<30 | SDL_SCANCODE_KP_COMMA;
    var SDLK_KP_EQUALSAS400 =
        1<<30 | SDL_SCANCODE_KP_EQUALSAS400;

    var SDLK_ALTERASE = 1<<30 | SDL_SCANCODE_ALTERASE;
    var SDLK_SYSREQ = 1<<30 | SDL_SCANCODE_SYSREQ;
    var SDLK_CANCEL = 1<<30 | SDL_SCANCODE_CANCEL;
    var SDLK_CLEAR = 1<<30 | SDL_SCANCODE_CLEAR;
    var SDLK_PRIOR = 1<<30 | SDL_SCANCODE_PRIOR;
    var SDLK_RETURN2 = 1<<30 | SDL_SCANCODE_RETURN2;
    var SDLK_SEPARATOR = 1<<30 | SDL_SCANCODE_SEPARATOR;
    var SDLK_OUT = 1<<30 | SDL_SCANCODE_OUT;
    var SDLK_OPER = 1<<30 | SDL_SCANCODE_OPER;
    var SDLK_CLEARAGAIN = 1<<30 | SDL_SCANCODE_CLEARAGAIN;
    var SDLK_CRSEL = 1<<30 | SDL_SCANCODE_CRSEL;
    var SDLK_EXSEL = 1<<30 | SDL_SCANCODE_EXSEL;

    var SDLK_KP_00 = 1<<30 | SDL_SCANCODE_KP_00;
    var SDLK_KP_000 = 1<<30 | SDL_SCANCODE_KP_000;
    var SDLK_THOUSANDSSEPARATOR =
        1<<30 | SDL_SCANCODE_THOUSANDSSEPARATOR;
    var SDLK_DECIMALSEPARATOR =
        1<<30 | SDL_SCANCODE_DECIMALSEPARATOR;
    var SDLK_CURRENCYUNIT = 1<<30 | SDL_SCANCODE_CURRENCYUNIT;
    var SDLK_CURRENCYSUBUNIT =
        1<<30 | SDL_SCANCODE_CURRENCYSUBUNIT;
    var SDLK_KP_LEFTPAREN = 1<<30 | SDL_SCANCODE_KP_LEFTPAREN;
    var SDLK_KP_RIGHTPAREN = 1<<30 | SDL_SCANCODE_KP_RIGHTPAREN;
    var SDLK_KP_LEFTBRACE = 1<<30 | SDL_SCANCODE_KP_LEFTBRACE;
    var SDLK_KP_RIGHTBRACE = 1<<30 | SDL_SCANCODE_KP_RIGHTBRACE;
    var SDLK_KP_TAB = 1<<30 | SDL_SCANCODE_KP_TAB;
    var SDLK_KP_BACKSPACE = 1<<30 | SDL_SCANCODE_KP_BACKSPACE;
    var SDLK_KP_A = 1<<30 | SDL_SCANCODE_KP_A;
    var SDLK_KP_B = 1<<30 | SDL_SCANCODE_KP_B;
    var SDLK_KP_C = 1<<30 | SDL_SCANCODE_KP_C;
    var SDLK_KP_D = 1<<30 | SDL_SCANCODE_KP_D;
    var SDLK_KP_E = 1<<30 | SDL_SCANCODE_KP_E;
    var SDLK_KP_F = 1<<30 | SDL_SCANCODE_KP_F;
    var SDLK_KP_XOR = 1<<30 | SDL_SCANCODE_KP_XOR;
    var SDLK_KP_POWER = 1<<30 | SDL_SCANCODE_KP_POWER;
    var SDLK_KP_PERCENT = 1<<30 | SDL_SCANCODE_KP_PERCENT;
    var SDLK_KP_LESS = 1<<30 | SDL_SCANCODE_KP_LESS;
    var SDLK_KP_GREATER = 1<<30 | SDL_SCANCODE_KP_GREATER;
    var SDLK_KP_AMPERSAND = 1<<30 | SDL_SCANCODE_KP_AMPERSAND;
    var SDLK_KP_DBLAMPERSAND =
        1<<30 | SDL_SCANCODE_KP_DBLAMPERSAND;
    var SDLK_KP_VERTICALBAR =
        1<<30 | SDL_SCANCODE_KP_VERTICALBAR;
    var SDLK_KP_DBLVERTICALBAR =
        1<<30 | SDL_SCANCODE_KP_DBLVERTICALBAR;
    var SDLK_KP_COLON = 1<<30 | SDL_SCANCODE_KP_COLON;
    var SDLK_KP_HASH = 1<<30 | SDL_SCANCODE_KP_HASH;
    var SDLK_KP_SPACE = 1<<30 | SDL_SCANCODE_KP_SPACE;
    var SDLK_KP_AT = 1<<30 | SDL_SCANCODE_KP_AT;
    var SDLK_KP_EXCLAM = 1<<30 | SDL_SCANCODE_KP_EXCLAM;
    var SDLK_KP_MEMSTORE = 1<<30 | SDL_SCANCODE_KP_MEMSTORE;
    var SDLK_KP_MEMRECALL = 1<<30 | SDL_SCANCODE_KP_MEMRECALL;
    var SDLK_KP_MEMCLEAR = 1<<30 | SDL_SCANCODE_KP_MEMCLEAR;
    var SDLK_KP_MEMADD = 1<<30 | SDL_SCANCODE_KP_MEMADD;
    var SDLK_KP_MEMSUBTRACT =
        1<<30 | SDL_SCANCODE_KP_MEMSUBTRACT;
    var SDLK_KP_MEMMULTIPLY =
        1<<30 | SDL_SCANCODE_KP_MEMMULTIPLY;
    var SDLK_KP_MEMDIVIDE = 1<<30 | SDL_SCANCODE_KP_MEMDIVIDE;
    var SDLK_KP_PLUSMINUS = 1<<30 | SDL_SCANCODE_KP_PLUSMINUS;
    var SDLK_KP_CLEAR = 1<<30 | SDL_SCANCODE_KP_CLEAR;
    var SDLK_KP_CLEARENTRY = 1<<30 | SDL_SCANCODE_KP_CLEARENTRY;
    var SDLK_KP_BINARY = 1<<30 | SDL_SCANCODE_KP_BINARY;
    var SDLK_KP_OCTAL = 1<<30 | SDL_SCANCODE_KP_OCTAL;
    var SDLK_KP_DECIMAL = 1<<30 | SDL_SCANCODE_KP_DECIMAL;
    var SDLK_KP_HEXADECIMAL =
        1<<30 | SDL_SCANCODE_KP_HEXADECIMAL;

    var SDLK_LCTRL = 1<<30 | SDL_SCANCODE_LCTRL;
    var SDLK_LSHIFT = 1<<30 | SDL_SCANCODE_LSHIFT;
    var SDLK_LALT = 1<<30 | SDL_SCANCODE_LALT;
    var SDLK_LGUI = 1<<30 | SDL_SCANCODE_LGUI;
    var SDLK_RCTRL = 1<<30 | SDL_SCANCODE_RCTRL;
    var SDLK_RSHIFT = 1<<30 | SDL_SCANCODE_RSHIFT;
    var SDLK_RALT = 1<<30 | SDL_SCANCODE_RALT;
    var SDLK_RGUI = 1<<30 | SDL_SCANCODE_RGUI;

    var SDLK_MODE = 1<<30 | SDL_SCANCODE_MODE;

    var SDLK_AUDIONEXT = 1<<30 | SDL_SCANCODE_AUDIONEXT;
    var SDLK_AUDIOPREV = 1<<30 | SDL_SCANCODE_AUDIOPREV;
    var SDLK_AUDIOSTOP = 1<<30 | SDL_SCANCODE_AUDIOSTOP;
    var SDLK_AUDIOPLAY = 1<<30 | SDL_SCANCODE_AUDIOPLAY;
    var SDLK_AUDIOMUTE = 1<<30 | SDL_SCANCODE_AUDIOMUTE;
    var SDLK_MEDIASELECT = 1<<30 | SDL_SCANCODE_MEDIASELECT;
    var SDLK_WWW = 1<<30 | SDL_SCANCODE_WWW;
    var SDLK_MAIL = 1<<30 | SDL_SCANCODE_MAIL;
    var SDLK_CALCULATOR = 1<<30 | SDL_SCANCODE_CALCULATOR;
    var SDLK_COMPUTER = 1<<30 | SDL_SCANCODE_COMPUTER;
    var SDLK_AC_SEARCH = 1<<30 | SDL_SCANCODE_AC_SEARCH;
    var SDLK_AC_HOME = 1<<30 | SDL_SCANCODE_AC_HOME;
    var SDLK_AC_BACK = 1<<30 | SDL_SCANCODE_AC_BACK;
    var SDLK_AC_FORWARD = 1<<30 | SDL_SCANCODE_AC_FORWARD;
    var SDLK_AC_STOP = 1<<30 | SDL_SCANCODE_AC_STOP;
    var SDLK_AC_REFRESH = 1<<30 | SDL_SCANCODE_AC_REFRESH;
    var SDLK_AC_BOOKMARKS = 1<<30 | SDL_SCANCODE_AC_BOOKMARKS;

    var SDLK_BRIGHTNESSDOWN =
        1<<30 | SDL_SCANCODE_BRIGHTNESSDOWN;
    var SDLK_BRIGHTNESSUP = 1<<30 | SDL_SCANCODE_BRIGHTNESSUP;
    var SDLK_DISPLAYSWITCH = 1<<30 | SDL_SCANCODE_DISPLAYSWITCH;
    var SDLK_KBDILLUMTOGGLE =
        1<<30 | SDL_SCANCODE_KBDILLUMTOGGLE;
    var SDLK_KBDILLUMDOWN = 1<<30 | SDL_SCANCODE_KBDILLUMDOWN;
    var SDLK_KBDILLUMUP = 1<<30 | SDL_SCANCODE_KBDILLUMUP;
    var SDLK_EJECT = 1<<30 | SDL_SCANCODE_EJECT;
    var SDLK_SLEEP = 1<<30 | SDL_SCANCODE_SLEEP;
    var SDLK_APP1 = 1<<30 | SDL_SCANCODE_APP1;
    var SDLK_APP2 = 1<<30 | SDL_SCANCODE_APP2;

    var SDLK_AUDIOREWIND = 1<<30 | SDL_SCANCODE_AUDIOREWIND;
    var SDLK_AUDIOFASTFORWARD = 1<<30 | SDL_SCANCODE_AUDIOFASTFORWARD;
}

enum abstract KeyCode(Int) to Int  from Int{
    var KEY_UNKNOWN = SDLK_UNKNOWN;
    var KEY_A = SDLK_a;
    var KEY_B = SDLK_b;
    var KEY_C = SDLK_c;
    var KEY_D = SDLK_d;
    var KEY_E = SDLK_e;
    var KEY_F = SDLK_f;
    var KEY_G = SDLK_g;
    var KEY_H = SDLK_h;
    var KEY_I = SDLK_i;
    var KEY_J = SDLK_j;
    var KEY_K = SDLK_k;
    var KEY_L = SDLK_l;
    var KEY_M = SDLK_m;
    var KEY_N = SDLK_n;
    var KEY_O = SDLK_o;
    var KEY_P = SDLK_p;
    var KEY_Q = SDLK_q;
    var KEY_R = SDLK_r;
    var KEY_S = SDLK_s;
    var KEY_T = SDLK_t;
    var KEY_U = SDLK_u;
    var KEY_V = SDLK_v;
    var KEY_W = SDLK_w;
    var KEY_X = SDLK_x;
    var KEY_Y = SDLK_y;
    var KEY_Z = SDLK_z;
    var KEY_0 = SDLK_0;
    var KEY_1 = SDLK_1;
    var KEY_2 = SDLK_2;
    var KEY_3 = SDLK_3;
    var KEY_4 = SDLK_4;
    var KEY_5 = SDLK_5;
    var KEY_6 = SDLK_6;
    var KEY_7 = SDLK_7;
    var KEY_8 = SDLK_8;
    var KEY_9 = SDLK_9;
    var KEY_BACKSPACE = SDLK_BACKSPACE;
    var KEY_TAB = SDLK_TAB;
    var KEY_RETURN = SDLK_RETURN;
    var KEY_RETURN2 = SDLK_RETURN2;
    var KEY_KP_ENTER = SDLK_KP_ENTER;
    var KEY_SHIFT = SDLK_LSHIFT;
    var KEY_CTRL = SDLK_LCTRL;
    var KEY_ALT = SDLK_LALT;
    var KEY_GUI = SDLK_LGUI;
    var KEY_PAUSE = SDLK_PAUSE;
    var KEY_CAPSLOCK = SDLK_CAPSLOCK;
    var KEY_ESCAPE = SDLK_ESCAPE;
    var KEY_SPACE = SDLK_SPACE;
    var KEY_PAGEUP = SDLK_PAGEUP;
    var KEY_PAGEDOWN = SDLK_PAGEDOWN;
    var KEY_END = SDLK_END;
    var KEY_HOME = SDLK_HOME;
    var KEY_LEFT = SDLK_LEFT;
    var KEY_UP = SDLK_UP;
    var KEY_RIGHT = SDLK_RIGHT;
    var KEY_DOWN = SDLK_DOWN;
    var KEY_SELECT = SDLK_SELECT;
    var KEY_PRINTSCREEN = SDLK_PRINTSCREEN;
    var KEY_INSERT = SDLK_INSERT;
    var KEY_DELETE = SDLK_DELETE;
    var KEY_LGUI = SDLK_LGUI;
    var KEY_RGUI = SDLK_RGUI;
    var KEY_APPLICATION = SDLK_APPLICATION;
    var KEY_KP_0 = SDLK_KP_0;
    var KEY_KP_1 = SDLK_KP_1;
    var KEY_KP_2 = SDLK_KP_2;
    var KEY_KP_3 = SDLK_KP_3;
    var KEY_KP_4 = SDLK_KP_4;
    var KEY_KP_5 = SDLK_KP_5;
    var KEY_KP_6 = SDLK_KP_6;
    var KEY_KP_7 = SDLK_KP_7;
    var KEY_KP_8 = SDLK_KP_8;
    var KEY_KP_9 = SDLK_KP_9;
    var KEY_KP_MULTIPLY = SDLK_KP_MULTIPLY;
    var KEY_KP_PLUS = SDLK_KP_PLUS;
    var KEY_KP_MINUS = SDLK_KP_MINUS;
    var KEY_KP_PERIOD = SDLK_KP_PERIOD;
    var KEY_KP_DIVIDE = SDLK_KP_DIVIDE;
    var KEY_F1 = SDLK_F1;
    var KEY_F2 = SDLK_F2;
    var KEY_F3 = SDLK_F3;
    var KEY_F4 = SDLK_F4;
    var KEY_F5 = SDLK_F5;
    var KEY_F6 = SDLK_F6;
    var KEY_F7 = SDLK_F7;
    var KEY_F8 = SDLK_F8;
    var KEY_F9 = SDLK_F9;
    var KEY_F10 = SDLK_F10;
    var KEY_F11 = SDLK_F11;
    var KEY_F12 = SDLK_F12;
    var KEY_F13 = SDLK_F13;
    var KEY_F14 = SDLK_F14;
    var KEY_F15 = SDLK_F15;
    var KEY_F16 = SDLK_F16;
    var KEY_F17 = SDLK_F17;
    var KEY_F18 = SDLK_F18;
    var KEY_F19 = SDLK_F19;
    var KEY_F20 = SDLK_F20;
    var KEY_F21 = SDLK_F21;
    var KEY_F22 = SDLK_F22;
    var KEY_F23 = SDLK_F23;
    var KEY_F24 = SDLK_F24;
    var KEY_NUMLOCKCLEAR = SDLK_NUMLOCKCLEAR;
    var KEY_SCROLLLOCK = SDLK_SCROLLLOCK;
    var KEY_LSHIFT = SDLK_LSHIFT;
    var KEY_RSHIFT = SDLK_RSHIFT;
    var KEY_LCTRL = SDLK_LCTRL;
    var KEY_RCTRL = SDLK_RCTRL;
    var KEY_LALT = SDLK_LALT;
    var KEY_RALT = SDLK_RALT;
    var KEY_AC_BACK = SDLK_AC_BACK;
    var KEY_AC_BOOKMARKS = SDLK_AC_BOOKMARKS;
    var KEY_AC_FORWARD = SDLK_AC_FORWARD;
    var KEY_AC_HOME = SDLK_AC_HOME;
    var KEY_AC_REFRESH = SDLK_AC_REFRESH;
    var KEY_AC_SEARCH = SDLK_AC_SEARCH;
    var KEY_AC_STOP = SDLK_AC_STOP;
    var KEY_AGAIN = SDLK_AGAIN;
    var KEY_ALTERASE = SDLK_ALTERASE;
    var KEY_AMPERSAND = SDLK_AMPERSAND;
    var KEY_ASTERISK = SDLK_ASTERISK;
    var KEY_AT = SDLK_AT;
    var KEY_AUDIOMUTE = SDLK_AUDIOMUTE;
    var KEY_AUDIONEXT = SDLK_AUDIONEXT;
    var KEY_AUDIOPLAY = SDLK_AUDIOPLAY;
    var KEY_AUDIOPREV = SDLK_AUDIOPREV;
    var KEY_AUDIOSTOP = SDLK_AUDIOSTOP;
    var KEY_BACKQUOTE = SDLK_BACKQUOTE;
    var KEY_BACKSLASH = SDLK_BACKSLASH;
    var KEY_BRIGHTNESSDOWN = SDLK_BRIGHTNESSDOWN;
    var KEY_BRIGHTNESSUP = SDLK_BRIGHTNESSUP;
    var KEY_CALCULATOR = SDLK_CALCULATOR;
    var KEY_CANCEL = SDLK_CANCEL;
    var KEY_CARET = SDLK_CARET;
    var KEY_CLEAR = SDLK_CLEAR;
    var KEY_CLEARAGAIN = SDLK_CLEARAGAIN;
    var KEY_COLON = SDLK_COLON;
    var KEY_COMMA = SDLK_COMMA;
    var KEY_COMPUTER = SDLK_COMPUTER;
    var KEY_COPY = SDLK_COPY;
    var KEY_CRSEL = SDLK_CRSEL;
    var KEY_CURRENCYSUBUNIT = SDLK_CURRENCYSUBUNIT;
    var KEY_CURRENCYUNIT = SDLK_CURRENCYUNIT;
    var KEY_CUT = SDLK_CUT;
    var KEY_DECIMALSEPARATOR = SDLK_DECIMALSEPARATOR;
    var KEY_DISPLAYSWITCH = SDLK_DISPLAYSWITCH;
    var KEY_DOLLAR = SDLK_DOLLAR;
    var KEY_EJECT = SDLK_EJECT;
    var KEY_EQUALS = SDLK_EQUALS;
    var KEY_EXCLAIM = SDLK_EXCLAIM;
    var KEY_EXSEL = SDLK_EXSEL;
    var KEY_FIND = SDLK_FIND;
    var KEY_GREATER = SDLK_GREATER;
    var KEY_HASH = SDLK_HASH;
    var KEY_HELP = SDLK_HELP;
    var KEY_KBDILLUMDOWN = SDLK_KBDILLUMDOWN;
    var KEY_KBDILLUMTOGGLE = SDLK_KBDILLUMTOGGLE;
    var KEY_KBDILLUMUP = SDLK_KBDILLUMUP;
    var KEY_KP_00 = SDLK_KP_00;
    var KEY_KP_000 = SDLK_KP_000;
    var KEY_KP_A = SDLK_KP_A;
    var KEY_KP_AMPERSAND = SDLK_KP_AMPERSAND;
    var KEY_KP_AT = SDLK_KP_AT;
    var KEY_KP_B = SDLK_KP_B;
    var KEY_KP_BACKSPACE = SDLK_KP_BACKSPACE;
    var KEY_KP_BINARY = SDLK_KP_BINARY;
    var KEY_KP_C = SDLK_KP_C;
    var KEY_KP_CLEAR = SDLK_KP_CLEAR;
    var KEY_KP_CLEARENTRY = SDLK_KP_CLEARENTRY;
    var KEY_KP_COLON = SDLK_KP_COLON;
    var KEY_KP_COMMA = SDLK_KP_COMMA;
    var KEY_KP_D = SDLK_KP_D;
    var KEY_KP_DBLAMPERSAND = SDLK_KP_DBLAMPERSAND;
    var KEY_KP_DBLVERTICALBAR = SDLK_KP_DBLVERTICALBAR;
    var KEY_KP_DECIMAL = SDLK_KP_DECIMAL;
    var KEY_KP_E = SDLK_KP_E;
    var KEY_KP_EQUALS = SDLK_KP_EQUALS;
    var KEY_KP_EQUALSAS400 = SDLK_KP_EQUALSAS400;
    var KEY_KP_EXCLAM = SDLK_KP_EXCLAM;
    var KEY_KP_F = SDLK_KP_F;
    var KEY_KP_GREATER = SDLK_KP_GREATER;
    var KEY_KP_HASH = SDLK_KP_HASH;
    var KEY_KP_HEXADECIMAL = SDLK_KP_HEXADECIMAL;
    var KEY_KP_LEFTBRACE = SDLK_KP_LEFTBRACE;
    var KEY_KP_LEFTPAREN = SDLK_KP_LEFTPAREN;
    var KEY_KP_LESS = SDLK_KP_LESS;
    var KEY_KP_MEMADD = SDLK_KP_MEMADD;
    var KEY_KP_MEMCLEAR = SDLK_KP_MEMCLEAR;
    var KEY_KP_MEMDIVIDE = SDLK_KP_MEMDIVIDE;
    var KEY_KP_MEMMULTIPLY = SDLK_KP_MEMMULTIPLY;
    var KEY_KP_MEMRECALL = SDLK_KP_MEMRECALL;
    var KEY_KP_MEMSTORE = SDLK_KP_MEMSTORE;
    var KEY_KP_MEMSUBTRACT = SDLK_KP_MEMSUBTRACT;
    var KEY_KP_OCTAL = SDLK_KP_OCTAL;
    var KEY_KP_PERCENT = SDLK_KP_PERCENT;
    var KEY_KP_PLUSMINUS = SDLK_KP_PLUSMINUS;
    var KEY_KP_POWER = SDLK_KP_POWER;
    var KEY_KP_RIGHTBRACE = SDLK_KP_RIGHTBRACE;
    var KEY_KP_RIGHTPAREN = SDLK_KP_RIGHTPAREN;
    var KEY_KP_SPACE = SDLK_KP_SPACE;
    var KEY_KP_TAB = SDLK_KP_TAB;
    var KEY_KP_VERTICALBAR = SDLK_KP_VERTICALBAR;
    var KEY_KP_XOR = SDLK_KP_XOR;
    var KEY_LEFTBRACKET = SDLK_LEFTBRACKET;
    var KEY_LEFTPAREN = SDLK_LEFTPAREN;
    var KEY_LESS = SDLK_LESS;
    var KEY_MAIL = SDLK_MAIL;
    var KEY_MEDIASELECT = SDLK_MEDIASELECT;
    var KEY_MENU = SDLK_MENU;
    var KEY_MINUS = SDLK_MINUS;
    var KEY_MODE = SDLK_MODE;
    var KEY_MUTE = SDLK_MUTE;
    var KEY_OPER = SDLK_OPER;
    var KEY_OUT = SDLK_OUT;
    var KEY_PASTE = SDLK_PASTE;
    var KEY_PERCENT = SDLK_PERCENT;
    var KEY_PERIOD = SDLK_PERIOD;
    var KEY_PLUS = SDLK_PLUS;
    var KEY_POWER = SDLK_POWER;
    var KEY_PRIOR = SDLK_PRIOR;
    var KEY_QUESTION = SDLK_QUESTION;
    var KEY_QUOTE = SDLK_QUOTE;
    var KEY_QUOTEDBL = SDLK_QUOTEDBL;
    var KEY_RIGHTBRACKET = SDLK_RIGHTBRACKET;
    var KEY_RIGHTPAREN = SDLK_RIGHTPAREN;
    var KEY_SEMICOLON = SDLK_SEMICOLON;
    var KEY_SEPARATOR = SDLK_SEPARATOR;
    var KEY_SLASH = SDLK_SLASH;
    var KEY_SLEEP = SDLK_SLEEP;
    var KEY_STOP = SDLK_STOP;
    var KEY_SYSREQ = SDLK_SYSREQ;
    var KEY_THOUSANDSSEPARATOR = SDLK_THOUSANDSSEPARATOR;
    var KEY_UNDERSCORE = SDLK_UNDERSCORE;
    var KEY_UNDO = SDLK_UNDO;
    var KEY_VOLUMEDOWN = SDLK_VOLUMEDOWN;
    var KEY_VOLUMEUP = SDLK_VOLUMEUP;
    var KEY_WWW = SDLK_WWW;
}



