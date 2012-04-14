unit uRightGroupSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzTabs;

type
  TForm1 = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    pnl1: TPanel;
    spl1: TSplitter;
    btn_Save: TBitBtn;
    btn_Close: TBitBtn;
    pnl2: TPanel;
    btn3: TBitBtn;
    btn4: TBitBtn;
    procedure btn_CloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

end.
