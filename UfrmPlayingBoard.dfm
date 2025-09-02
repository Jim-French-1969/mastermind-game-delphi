object frmPlayingBoard: TfrmPlayingBoard
  Left = 90
  Top = 185
  BorderStyle = bsSingle
  Caption = 'MasterMind'
  ClientHeight = 362
  ClientWidth = 949
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 13
  object Shape1: TShape
    Left = 400
    Top = 183
    Width = 33
    Height = 33
    Shape = stCircle
  end
  object Shape2: TShape
    Left = 400
    Top = 139
    Width = 33
    Height = 33
    Shape = stCircle
  end
  object Shape3: TShape
    Left = 400
    Top = 96
    Width = 33
    Height = 33
    Shape = stCircle
  end
  object Shape4: TShape
    Left = 400
    Top = 56
    Width = 33
    Height = 33
    Shape = stCircle
  end
  object sbxGrid: TScrollBox
    Left = 0
    Top = 0
    Width = 721
    Height = 343
    Align = alLeft
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 0
  end
  object btnGuess: TButton
    Left = 814
    Top = 24
    Width = 75
    Height = 25
    Caption = '&Guess'
    TabOrder = 1
    OnClick = btnGuessClick
  end
  object sbrInfo: TStatusBar
    Left = 0
    Top = 343
    Width = 949
    Height = 19
    Panels = <>
  end
  object btnReset: TButton
    Left = 814
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Reset'
    TabOrder = 3
    OnClick = btnResetClick
  end
  object pnlCode: TPanel
    Left = 744
    Top = 16
    Width = 57
    Height = 209
    BevelOuter = bvNone
    TabOrder = 5
    object shp4: TShape
      Left = 6
      Top = 160
      Width = 33
      Height = 33
      Shape = stCircle
    end
    object shp3: TShape
      Left = 6
      Top = 115
      Width = 33
      Height = 33
      Shape = stCircle
    end
    object shp2: TShape
      Left = 6
      Top = 72
      Width = 33
      Height = 33
      Shape = stCircle
    end
    object shp1: TShape
      Left = 6
      Top = 32
      Width = 33
      Height = 33
      Shape = stCircle
    end
    object Label1: TLabel
      Left = 1
      Top = 8
      Width = 50
      Height = 13
      Caption = 'The Code!'
    end
    object lblshp1: TLabel
      Left = 18
      Top = 43
      Width = 8
      Height = 13
      Alignment = taCenter
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lblshp2: TLabel
      Left = 17
      Top = 83
      Width = 8
      Height = 13
      Alignment = taCenter
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lblshp3: TLabel
      Left = 18
      Top = 126
      Width = 8
      Height = 13
      Alignment = taCenter
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lblshp4: TLabel
      Left = 17
      Top = 171
      Width = 8
      Height = 13
      Alignment = taCenter
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
  end
  object btnShowCode: TButton
    Left = 814
    Top = 64
    Width = 75
    Height = 25
    Caption = '&Show Code'
    TabOrder = 2
    OnClick = btnShowCodeClick
  end
  object btnHelp: TButton
    Left = 814
    Top = 144
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 4
    OnClick = btnHelpClick
  end
end
