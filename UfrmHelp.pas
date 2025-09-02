unit UfrmHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmHelp = class(TForm)
    memInfo: TMemo;
    btnOK: TButton;
    grpColours: TGroupBox;
    shp1: TShape;
    shp2: TShape;
    shp3: TShape;
    shp4: TShape;
    shp5: TShape;
    shp6: TShape;
    grpAnswers: TGroupBox;
    shpCorrect: TShape;
    shpNearly: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelp: TfrmHelp;

implementation

{$R *.dfm}

uses
  UUtils, UConsts;

procedure TfrmHelp.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmHelp.FormShow(Sender: TObject);
begin
  shp1.Brush.Color := ColourNumToColour(1);
  shp2.Brush.Color := ColourNumToColour(2);
  shp3.Brush.Color := ColourNumToColour(3);
  shp4.Brush.Color := ColourNumToColour(4);
  shp5.Brush.Color := ColourNumToColour(5);
  shp6.Brush.Color := ColourNumToColour(6);
  shpCorrect.Brush.Color := COL_CORRECT;
  shpNearly.Brush.Color := COL_NEARLY;
end;

end.
