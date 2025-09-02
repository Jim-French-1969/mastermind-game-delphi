unit UfrmPlayingBoard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UTypes, ExtCtrls, MPlayer;

type
  TfrmPlayingBoard = class(TForm)
    sbxGrid: TScrollBox;
    btnGuess: TButton;
    sbrInfo: TStatusBar;
    btnReset: TButton;
    pnlCode: TPanel;
    shp4: TShape;
    shp3: TShape;
    shp2: TShape;
    shp1: TShape;
    Label1: TLabel;
    btnShowCode: TButton;
    lblshp1: TLabel;
    lblshp2: TLabel;
    lblshp3: TLabel;
    lblshp4: TLabel;
    btnHelp: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnGuessClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnShowCodeClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    fGuessRow : integer;
    fCode : TCode;
    AllRowsUsed : boolean; // Whether all rows have been used

    procedure Initialise;
    procedure SetActiveRow;
    procedure DrawBoard;
    procedure ClearGrid;
    procedure CreateCode;
    procedure CheckGuess(Guess, Answer : TCode; var CorrectCount, NearlyCount : integer);
    {$HINTS OFF}
    procedure AutoComplete;  // Not yet implemented
    {$HINTS ON}

  public
    procedure ColourWasChosen;
  end;

var
  frmPlayingBoard: TfrmPlayingBoard;

implementation

{$R *.dfm}

uses
  UConsts, UUtils, UfraRow, UfrmHelp;

procedure TfrmPlayingBoard.DrawBoard;
var
  i : integer;
  fra : TFrame;
begin
  sbxGrid.Visible := false;
  for i := GUESS_ROWS downto 1 do
  begin
    fra := TfraRow.Create(self);
    fra.Name := 'fraRow' + IntToStr(i); // Frame names from 1..GUESS_ROWS L->R on screen
    fra.Parent := sbxGrid;
    fra.Align := alLeft;
    fra.Enabled := false;
    (fra.FindComponent('lblName') as TLabel).Caption := InttoStr(i);
  end;
  sbxGrid.Visible := true;  
end;

procedure TfrmPlayingBoard.SetActiveRow;
var
  i : integer;
begin
  // Disable all rows other than the current one
  for i := 1 to GUESS_ROWS do
  begin
    (sbxGrid.FindChildControl('fraRow' + IntToStr(i)) as TFrame).Color := NO_COLOUR;
    sbxGrid.FindChildControl('fraRow' + IntToStr(i)).Enabled := false;
  end;

  (sbxGrid.FindChildControl('fraRow' + IntToStr(fGuessRow)) as TFrame).Color := HIGHLIGHT_COLOUR;
  sbxGrid.FindChildControl('fraRow' + IntToStr(fGuessRow)).Enabled := true;
end;

procedure TfrmPlayingBoard.FormShow(Sender: TObject);
begin
  DrawBoard;
  Initialise;
end;

procedure TfrmPlayingBoard.Initialise;
begin
  fGuessRow := 1;
  CreateCode;
  pnlCode.Visible := false;
  SetActiveRow;
  AllRowsUsed := false;
end;

procedure TfrmPlayingBoard.btnGuessClick(Sender: TObject);
var
  i : integer;
  CurGuess : TCode;
  CorrectCount,
  NearlyCount : integer;
  AllGuessed : boolean;
begin
  AllGuessed := true;
  for i := 1 to CODE_LENGTH do
  begin
    AllGuessed := AllGuessed and
      ((sbxGrid.FindChildControl('fraRow' + IntToStr(fGuessRow)) as TfraRow).GetShapeColourNum(i) <> 0);
  end;

  if not AllGuessed then
    sbrInfo.SimpleText := 'You haven''t guessed all of the code!'
  else
  begin
    for i := 1 to CODE_LENGTH do
      CurGuess[i] := (sbxGrid.FindChildControl('fraRow' + IntToStr(fGuessRow)) as TfraRow).GetShapeColourNum(i);

    CheckGuess(CurGuess, fCode, CorrectCount, NearlyCount);

    for i := 1 to CorrectCount do
      (sbxGrid.FindChildControl('fraRow' + IntToStr(fGuessRow)) as TFraRow).AddCorrectMarker;

    for i := 1 to NearlyCount do
      (sbxGrid.FindChildControl('fraRow' + IntToStr(fGuessRow)) as TFraRow).AddNearlyMarker;

    if CorrectCount = CODE_LENGTH then
    begin
      pnlCode.Visible := true;
      if UUtils.ShowMessage('You got it!' + CRLF + 'Another go?', mtConfirmation) then
      begin
        ClearGrid;
        Initialise;
      end
      else
      begin
        UUtils.ShowMessage('Thanks for playing', mtInformation);
        Close;
      end;
    end
    else
    begin
      if fGuessRow < GUESS_ROWS then
      begin
        Inc(fGuessRow);
        sbrInfo.SimpleText := EmptyStr;
        SetActiveRow;
      end
      else
      begin
        UUtils.ShowMessage('You ran out of guesses!');
        pnlCode.Visible := true;
        AllRowsUsed := true;
      end;
    end;
  end;
end;

procedure TfrmPlayingBoard.CreateCode;
var
  i : integer;
  lbl : TLabel;
begin
  Randomize;
  for i := 1 to CODE_LENGTH do
  begin
    fCode[i] := Random(NUM_COLOURS) + 1;
    (FindComponent('shp' + IntToStr(i)) as TShape).Brush.Color :=
      ColourNumToColour(fCode[i]);
    if SHOW_NUM_ON_SHAPE then
    begin
      lbl := TLabel(FindComponent('lblshp' + IntToStr(i)));
      lbl.Caption := IntToStr(fCode[i]);
      lbl.Visible := true;
    end;
  end;
end;

procedure TfrmPlayingBoard.CheckGuess(Guess, Answer : TCode; var CorrectCount, NearlyCount : integer);
var
  i, j : integer;
  Done : boolean;
begin
  CorrectCount := 0;
  NearlyCount := 0;

  for i := 1 to CODE_LENGTH do
    // Correct count
    if Guess[i] = Answer[i] then
    begin
      // Remove this correct match so that it isn't also a nearly
      Guess[i] := -1;
      Answer[i] := -1;
      inc(CorrectCount);
    end;

  for i := 1 to CODE_LENGTH do
    // Nearly count
    if Guess[i] <> -1 then
    begin
      j := 1;
      Done := false;
      while (j <= CODE_LENGTH) and not Done do
      begin
        if Guess[i] = Answer[j] then
        begin
          Guess[i] := -1;
          Answer[j] := -1;
          inc(NearlyCount);
          Done := true;
        end;
        inc(j);
      end;
    end;
end;

procedure TfrmPlayingBoard.ClearGrid;
var
  i : integer;
begin
  for i := 1 to GUESS_ROWS do
    (sbxGrid.FindChildControl('fraRow' + IntToStr(i)) as TfraRow).ClearRow;
end;

procedure TfrmPlayingBoard.btnResetClick(Sender: TObject);
begin
  if UUtils.ShowMessage('Are you sure?', mtConfirmation) then
  begin
    ClearGrid;
    Initialise;
  end;
end;

procedure TfrmPlayingBoard.ColourWasChosen;
begin
  sbrInfo.SimpleText := EmptyStr;
end;

procedure TfrmPlayingBoard.AutoComplete;
// Potential addition: the user has an 'auto complete' functiom
// where it takes the current guesses and results and then uses
// an algorithm such as that by Knuth
// https://en.wikipedia.org/wiki/Mastermind_(board_game)
// to complete the guesses
// Original source:
// Journal of Recreational Mathematics Volume 9(1) 1976-77
// Donald E. Knuth The Computer as Mastermind
begin
end;

procedure TfrmPlayingBoard.btnShowCodeClick(Sender: TObject);
begin
  if fGuessRow < GUESS_ROWS then
    if UUtils.ShowMessage('Are you sure?', mtConfirmation) then
      pnlCode.Visible := true;
end;

procedure TfrmPlayingBoard.btnHelpClick(Sender: TObject);
begin
  with TfrmHelp.Create(self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmPlayingBoard.FormKeyPress(Sender: TObject; var Key: Char);
var
  Num : TAllowedNums;
begin
  if not AllRowsUsed and ((Key >= '1') and (Key <= IntToStr(NUM_COLOURS)[1])) then
  begin
    Num := StrToInt(Key); // Already checked its a single digit in range
    (sbxGrid.FindChildControl('fraRow' + IntToStr(fGuessRow)) as TFraRow).SetOneColour(Num);
  end;
end;

end.
