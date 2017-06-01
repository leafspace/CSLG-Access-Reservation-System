object Form1: TForm1
  Left = 267
  Top = 226
  Width = 661
  Height = 627
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 35
    Width = 18
    Height = 13
    Caption = 'SN:'
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 38
    Height = 13
    Caption = 'New IP:'
  end
  object Label3: TLabel
    Left = 16
    Top = 120
    Width = 29
    Height = 13
    Caption = 'Mask:'
  end
  object Label4: TLabel
    Left = 16
    Top = 168
    Width = 45
    Height = 13
    Caption = 'Gateway:'
  end
  object Label5: TLabel
    Left = 40
    Top = 96
    Width = 87
    Height = 13
    Caption = ' .          .          .    .'
  end
  object Label6: TLabel
    Left = 40
    Top = 144
    Width = 87
    Height = 13
    Caption = ' .          .          .    .'
  end
  object Label7: TLabel
    Left = 40
    Top = 192
    Width = 87
    Height = 13
    Caption = ' .          .          .    .'
  end
  object Button1: TButton
    Left = 24
    Top = 232
    Width = 73
    Height = 33
    Caption = 'Test'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Text1: TMemo
    Left = 176
    Top = 16
    Width = 457
    Height = 569
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Button2: TButton
    Left = 24
    Top = 280
    Width = 73
    Height = 33
    Caption = 'Exit'
    TabOrder = 2
    OnClick = Button2Click
  end
  object EditSN: TEdit
    Left = 48
    Top = 32
    Width = 65
    Height = 21
    TabOrder = 3
    Text = '39990'
  end
  object EditIP1: TEdit
    Left = 16
    Top = 88
    Width = 25
    Height = 21
    TabOrder = 4
    Text = '192'
  end
  object EditIP2: TEdit
    Left = 48
    Top = 88
    Width = 25
    Height = 21
    TabOrder = 5
    Text = '168'
  end
  object EditIP3: TEdit
    Left = 80
    Top = 88
    Width = 25
    Height = 21
    TabOrder = 6
    Text = '168'
  end
  object EditIP4: TEdit
    Left = 114
    Top = 88
    Width = 25
    Height = 21
    TabOrder = 7
    Text = '90'
  end
  object EditMask1: TEdit
    Left = 16
    Top = 136
    Width = 25
    Height = 21
    TabOrder = 8
    Text = '255'
  end
  object EditMask2: TEdit
    Left = 48
    Top = 136
    Width = 25
    Height = 21
    TabOrder = 9
    Text = '255'
  end
  object EditMask3: TEdit
    Left = 80
    Top = 136
    Width = 25
    Height = 21
    TabOrder = 10
    Text = '255'
  end
  object EditMask4: TEdit
    Left = 114
    Top = 136
    Width = 25
    Height = 21
    TabOrder = 11
    Text = '0'
  end
  object EditGateway1: TEdit
    Left = 16
    Top = 184
    Width = 25
    Height = 21
    TabOrder = 12
    Text = '192'
  end
  object EditGateway2: TEdit
    Left = 48
    Top = 184
    Width = 25
    Height = 21
    TabOrder = 13
    Text = '168'
  end
  object EditGateway3: TEdit
    Left = 80
    Top = 184
    Width = 25
    Height = 21
    TabOrder = 14
    Text = '168'
  end
  object EditGateway4: TEdit
    Left = 114
    Top = 184
    Width = 25
    Height = 21
    TabOrder = 15
    Text = '254'
  end
end
