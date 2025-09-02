unit UConsts;

interface

uses
  Graphics;

const
  CRLF = #13#10;
  GUESS_ROWS = 12;
  NUM_COLOURS = 6;
  CODE_LENGTH = 4;
  INFO_URL = 'https://en.wikipedia.org/wiki/Mastermind_(board_game)';

  // Depending on compiler directives typed constants can be simply
  // initialised variables
  {$WRITEABLECONST ON}
  SHOW_NUM_ON_SHAPE : boolean = true;
  {$WRITEABLECONST OFF}

  {$WRITEABLECONST OFF}
  // The original game uses white but this is not very clear on screen
  NO_COLOUR = clBtnFace;
  HIGHLIGHT_COLOUR = clActiveBorder;
  COL1 : TColor = clBlue;
  COL2 : TColor = clGreen;
  COL3 : TColor = clRed;
  COL4 : TColor = clAqua; // clWhite;
  COL5 : TColor = $00008CFF; // CSS Dark orange TColor is B-G-R lowest 3 bytes
  COL6 : TColor = clYellow;

  COL_CORRECT : TColor = clBlack;
  COL_NEARLY : TColor = clRed; // clWhite in original game - not particularly visible

  COL_ACTIVE_ROW : TColor = clActiveCaption;

  TAG_CORRECT = 2;
  TAG_NEARLY = 1;
  {$WRITEABLECONST ON}

implementation

end.
