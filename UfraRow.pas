unit UfraRow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UTypes;

type
  TfraRow = class(TFrame)
    shp1: TShape;
    shp2: TShape;
    shp3: TShape;
    shp4: TShape;
    lblName: TLabel;
    shpCorrect1: TShape;
    shpCorrect2: TShape;
    shpCorrect3: TShape;
    shpCorrect4: TShape;
    shpNearly1: TShape;
    shpNearly2: TShape;
    shpNearly3: TShape;
    shpNearly4: TShape;
    lblshp1: TLabel;
    lblshp2: TLabel;
    lblshp3: TLabel;
    lblshp4: TLabel;
    procedure ShapeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetShapeColour(Shape : TShape; ColourNum: integer);
    function GetShapeColourNum(ShapeNum : integer; ShapeName : string = 'shp'): integer;
    procedure ClearRow;
    procedure SetRowColours(Colors : TCode);
    procedure SetOneColour(Num : TAllowedNums);
    procedure AddCorrectMarker;
    procedure AddNearlyMarker;
  end;

implementation

{$R *.dfm}

uses
  StrUtils, UConsts, UUtils, UfrmPlayingBoard;

constructor TfraRow.Create(AOwner: TComponent);
begin
  inherited;
  Width := 60;
  ClearRow;
end;

procedure TfraRow.ClearRow;
var
  i : integer;
  CurComponent : TComponent;
  lbl : TLabel;
begin
  for i := 0 to ComponentCount -1 do
  begin
    CurComponent := Components[i];
    if (CurComponent is TShape) then
    begin
      (CurComponent as TShape).Brush.Color := NO_COLOUR;
      (CurComponent as TShape).Tag := 0;
    end;
  end;

  for i := 1 to CODE_LENGTH do
  begin
    lbl := TLabel(FindComponent('lblshp' + IntToStr(i)));
    lbl.Visible := false;
  end;
end;

function TfraRow.GetShapeColourNum(ShapeNum: integer; ShapeName : string = 'shp'): integer;
begin
  if (ShapeNum < 1) or (ShapeNum > CODE_LENGTH) then
    raise Exception.CreateFmt('The requested shape "%d" is out of range', [ShapeNum]);

  Result := FindComponent(ShapeName + IntToStr(ShapeNum)).Tag;
end;

procedure TfraRow.SetShapeColour(Shape : TShape; ColourNum: integer);
var
  lbl : TLabel;
begin
  Shape.Tag := ColourNum;
  Shape.Brush.Color := ColourNumToColour(ColourNum);
  if SHOW_NUM_ON_SHAPE then
  begin
    lbl := TLabel(FindComponent('lbl' + Shape.Name));
    lbl.Caption := IntToStr(ColourNum);
    lbl.Visible := true;
  end;
  // When a colour has been set inform the owning form
  (Owner as TfrmPlayingBoard).ColourWasChosen;
end;

procedure TfraRow.ShapeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    // Each guess shape now has a label on it e.g. for the colour blind
    // The user may click on the shape OR the label
    // The label has its owner and parent property set to the frame
    // So we need to associate a label mousedown (click) with the shape mousedown
    if SameText(TComponent(Sender).Name, 'lblshp1') then
      Sender := shp1;
    if SameText(TComponent(Sender).Name, 'lblshp2') then
      Sender := shp2;
    if SameText(TComponent(Sender).Name, 'lblshp3') then
      Sender := shp3;
    if SameText(TComponent(Sender).Name, 'lblshp4') then
      Sender := shp4;

    SetShapeColour((Sender as TShape), IncColourNum((Sender as TShape).Tag));
  end;
end;

procedure TfraRow.AddCorrectMarker;
var
  i : integer;
  Done : boolean;
  CurShape : TShape;
begin
  i := 1;
  Done := false;

  while (i <= CODE_LENGTH) and not Done do
  begin
    CurShape := FindComponent('shpCorrect' + IntToStr(i)) as TShape;
    if GetShapeColourNum(i, 'shpCorrect') = 0 then
    begin
      CurShape.Tag := TAG_CORRECT;
      CurShape.Brush.Color := COL_CORRECT;
      Done := true;
    end;
    inc(i);
  end;
end;

procedure TfraRow.AddNearlyMarker;
var
  i : integer;
  Done : boolean;
  CurShape : TShape;
begin
  i := 1;
  Done := false;

  while (i <= CODE_LENGTH) and not Done do
  begin
    CurShape := FindComponent('shpNearly' + IntToStr(i)) as TShape;
    if GetShapeColourNum(i, 'shpNearly') = 0 then
    begin
      CurShape.Tag := TAG_NEARLY;
      CurShape.Brush.Color := COL_NEARLY;
      Done := true;
    end;
    inc(i);
  end;
end;

procedure TfraRow.SetRowColours(Colors: TCode);
begin
  SetShapeColour(shp1, Colors[1]);
  SetShapeColour(shp2, Colors[2]);
  SetShapeColour(shp3, Colors[3]);
  SetShapeColour(shp4, Colors[4]);
end;

procedure TfraRow.SetOneColour(Num : TAllowedNums);
const
  GUESS_SHAPE_NAME_LENGTH = 4;
var
  i : integer;
  Found : boolean;
  CurShape : TShape;
begin
  Found := false;

  i := 0;
  while (i < ComponentCount) and not Found do
  begin
    if (Components[i] is TShape) then
    begin
      CurShape := TShape(Components[i]);
      // The main guess shapes are shp1 .. shp4 so the name is always 4 characters
      if (length(CurShape.Name) = GUESS_SHAPE_NAME_LENGTH) and (CurShape.Tag = 0) then
      begin
        SetShapeColour(CurShape,Num);
        Found := true;
      end;
    end;
    inc(i);
  end;
end;

end.
