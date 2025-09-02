program Mastermind;

// Please note this is not designed to be a commercial product
// So any logos etc belong to their copyright holders

uses
  Forms,
  UfrmPlayingBoard in 'UfrmPlayingBoard.pas' {frmPlayingBoard},
  UConsts in 'UConsts.pas',
  UfraRow in 'UfraRow.pas' {fraRow: TFrame},
  UTypes in 'UTypes.pas',
  UUtils in 'UUtils.pas',
  UfrmSplash in 'UfrmSplash.pas' {frmSplashScreen},
  UfrmHelp in 'UfrmHelp.pas' {frmHelp};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MasterMind';
  with TfrmSplashScreen.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
  // First call to CreateForm makes this the application's main form
  // i.e. closing it closes the application
  Application.CreateForm(TfrmPlayingBoard, frmPlayingBoard);
  Application.Run;
end.
