unit UUtils;

interface

uses
  Graphics, Dialogs, Controls;

function ColourNumToColour(Num : integer) : TColor;
function IncColourNum(ColourNum : integer) : integer;
function ShowMessage(Msg : string; DlgType : TMsgDlgType = mtInformation) : boolean;

implementation

uses
  UConsts, SysUtils, Windows, System.UITypes;

function ColourNumToColour(Num : integer) : TColor;
begin
  if (Num < 1) or (Num > NUM_COLOURS) then
    raise Exception.CreateFmt('The colour number reference "%d" is out of range', [Num]);

  Result := COL1; // Avoid warning - undefined function result
  case Num of
    2: Result := COL2;
    3: Result := COL3;
    4: Result := COL4;
    5: Result := COL5;
    6: Result := COL6;
  end;
end;

function IncColourNum(ColourNum : integer) : integer;
begin
  Result := succ(ColourNum);
  if Result > NUM_COLOURS then
    Result := 1;
end;

function ShowMessage(Msg : string; DlgType : TMsgDlgType = mtInformation) : boolean;
// Post : Returns mrOK for mbYes, false otherwise
var
  Buttons : TMsgDlgButtons;
begin
  if DlgType = mtConfirmation then
    Buttons := [mbYes, mbNo]
  else
  begin
    Buttons := [mbOK];
    DlgType := mtInformation;
  end;

  Result := MessageDlg(Msg, DlgType, Buttons, 0) = mrYes;
end;

end.
