object Form1: TForm1
  Left = 128
  Top = 117
  Width = 879
  Height = 565
  Caption = 'XSDJar Generator v1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 289
    Top = 0
    Width = 582
    Height = 456
    Align = alClient
    Caption = 'Consola'
    TabOrder = 0
    object console: TMemo
      Left = 2
      Top = 15
      Width = 578
      Height = 439
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = False
      Lines.Strings = (
        'XSD Jar Generator '
        'Console capture')
      ParentCtl3D = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 289
    Height = 456
    Align = alLeft
    Caption = 'Navegador'
    TabOrder = 1
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 285
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object DriveComboBox1: TDriveComboBox
        Left = 8
        Top = 0
        Width = 273
        Height = 19
        BevelInner = bvNone
        BevelOuter = bvNone
        Ctl3D = False
        DirList = DirectoryListBox1
        ParentCtl3D = False
        TabOrder = 0
      end
    end
    object DirectoryListBox1: TDirectoryListBox
      Left = 2
      Top = 41
      Width = 285
      Height = 97
      Align = alTop
      Ctl3D = True
      FileList = FileListBox1
      ItemHeight = 16
      ParentCtl3D = False
      TabOrder = 1
    end
    object FileListBox1: TFileListBox
      Left = 2
      Top = 138
      Width = 285
      Height = 316
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = True
      ItemHeight = 13
      Mask = '*.xsd'
      ParentCtl3D = False
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 456
    Width = 871
    Height = 75
    Align = alBottom
    TabOrder = 2
    object Gauge1: TGauge
      Left = 1
      Top = 1
      Width = 869
      Height = 73
      Align = alClient
      BackColor = cl3DLight
      BorderStyle = bsNone
      Color = clBtnFace
      ForeColor = clBlue
      ParentColor = False
      Progress = 0
    end
    object Label1: TLabel
      Left = 175
      Top = 41
      Width = 371
      Height = 20
      Caption = 'Generador de librerias java a partir de un XSD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Button1: TButton
      Left = 8
      Top = 11
      Width = 161
      Height = 49
      Caption = 'PROCESAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
