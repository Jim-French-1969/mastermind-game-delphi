unit UfrmSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, MPlayer, StdCtrls, ComCtrls;

type
  TfrmSplashScreen = class(TForm)
    pnlTop: TPanel;
    imgLogo: TImage;
    mplTheme: TMediaPlayer;
    btnPlay: TButton;
    chkShowColourNumbers: TCheckBox;
    sbrLink: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPlayClick(Sender: TObject);
    procedure sbrLinkClick(Sender: TObject);
  private
    fPlay : boolean;
  public
    { Public declarations }
  end;

var
  frmSplashScreen: TfrmSplashScreen;

implementation

{$R *.dfm}
{$R MasterMindRes.res}

// The splash screen includes the “Mastermind” logo from the BBC TV show.
// The short music is the leitmotif from
// "Approaching Menace" composed by Neil Richardson used in the Mastermind TV show.
// Both are used for educational/demonstration purposes only.
// This code is not designed to be a commercial product.
// All rights belong to their respective copyright holders.
uses
  UConsts, UfrmPlayingBoard, ShellAPI, MMSystem;

procedure TfrmSplashScreen.FormShow(Sender: TObject);
const
  USE_RESOURCE = true;
var
  Res : TResourceStream;
begin
  fPlay := false;

  if USE_RESOURCE then
  begin
    Res := TResourceStream.Create(HInstance, 'LEITMOTIF', 'WAV');
    try
      Res.Position := 0;
      SndPlaySound(res.Memory, SND_MEMORY or SND_ASYNC);
    finally
      Res.Free;
    end;
  end
  else
  begin
    // This would require an additional external mp3 file
    mplTheme.FileName := 'leitmotif.mp3';
    mplTheme.Open;
    mplTheme.Play;
  end;
end;

procedure TfrmSplashScreen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // If the splash window is closed - terminate the app
  // If the play button was pressed continue
  if not fPlay then
    Application.Terminate;
  SHOW_NUM_ON_SHAPE := chkShowColourNumbers.Checked;
end;

procedure TfrmSplashScreen.btnPlayClick(Sender: TObject);
begin
  fPlay := true;
  Close;
end;

procedure TfrmSplashScreen.sbrLinkClick(Sender: TObject);
begin
  ShellExecute(HInstance, 'open', PChar(INFO_URL), nil, nil, SW_NORMAL);
end;

end.
