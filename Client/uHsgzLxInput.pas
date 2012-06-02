unit uHsgzLxInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrlsEh, Mask,DB;

type
  THsgzLxInput = class(TForm)
    lbl1: TLabel;
    edt_Index: TDBNumberEditEh;
    edt_HsgzLx: TDBEditEh;
    Label1: TLabel;
    btn_OK: TButton;
    btn_Cancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure edt_IndexChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure THsgzLxInput.edt_IndexChange(Sender: TObject);
begin
  btn_OK.Enabled := (edt_Index.Text<>'') and (edt_HsgzLx.Text<>'') and
                    (edt_Index.DataSource.DataSet.State in [dsInsert,dsEdit]);
end;

procedure THsgzLxInput.FormShow(Sender: TObject);
begin
  edt_IndexChange(Self);
end;

end.
