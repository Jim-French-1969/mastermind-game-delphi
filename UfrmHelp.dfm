object frmHelp: TfrmHelp
  Left = 581
  Top = 187
  BorderStyle = bsDialog
  Caption = 'How To Play'
  ClientHeight = 322
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object memInfo: TMemo
    Left = 0
    Top = 0
    Width = 410
    Height = 129
    Align = alTop
    Lines.Strings = (
      'Click on each circle to cycle through the 6 available colours '
      '(or use the number keys '#39'1'#39' through '#39'6'#39').'
      
        'When all 4 circles have been chosen, click on Guess (or press ke' +
        'y '#39'G'#39').'
      
        'For each correct colour in a correct position, you will see a fi' +
        'lled in answer spot'
      'above the guess.'
      
        'For each correct colour in an incorrect position, you will see a' +
        ' filled in answer spot'
      'below the guess.'
      'There will only ever be 4 answer spots in total.'
      'Use your logic to guess the code!')
    ReadOnly = True
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 168
    Top = 287
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOKClick
  end
  object grpColours: TGroupBox
    Left = 72
    Top = 134
    Width = 256
    Height = 57
    Caption = 'Colours'
    TabOrder = 2
    object shp1: TShape
      Left = 8
      Top = 12
      Width = 25
      Height = 41
      Shape = stCircle
    end
    object shp2: TShape
      Left = 49
      Top = 13
      Width = 25
      Height = 41
      Shape = stCircle
    end
    object shp3: TShape
      Left = 91
      Top = 13
      Width = 25
      Height = 41
      Shape = stCircle
    end
    object shp4: TShape
      Left = 132
      Top = 13
      Width = 25
      Height = 41
      Shape = stCircle
    end
    object shp5: TShape
      Left = 174
      Top = 13
      Width = 25
      Height = 41
      Shape = stCircle
    end
    object shp6: TShape
      Left = 216
      Top = 13
      Width = 25
      Height = 41
      Shape = stCircle
    end
    object Label3: TLabel
      Left = 17
      Top = 28
      Width = 8
      Height = 13
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 57
      Top = 28
      Width = 8
      Height = 13
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 99
      Top = 28
      Width = 8
      Height = 13
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 140
      Top = 28
      Width = 8
      Height = 13
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 183
      Top = 28
      Width = 8
      Height = 13
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 225
      Top = 28
      Width = 8
      Height = 13
      Caption = '6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  object grpAnswers: TGroupBox
    Left = 72
    Top = 198
    Width = 256
    Height = 83
    Caption = 'Answers'
    TabOrder = 3
    object shpCorrect: TShape
      Left = 8
      Top = 21
      Width = 17
      Height = 28
      Shape = stCircle
    end
    object shpNearly: TShape
      Left = 8
      Top = 45
      Width = 17
      Height = 28
      Shape = stCircle
    end
    object Label1: TLabel
      Left = 34
      Top = 28
      Width = 144
      Height = 13
      Caption = 'Correct colour, correct position'
    end
    object Label2: TLabel
      Left = 35
      Top = 53
      Width = 152
      Height = 13
      Caption = 'Correct colour, incorrect position'
    end
  end
end
