unit uKsInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, DBCtrls, Menus, ExtDlgs, DB,StrUtils,
  frxpngimage;

type
  TKsInfo = class(TForm)
    Image1: TImage;
    img_Photo: TImage;
    DBEdit1: TDBText;
    DBEdit2: TDBText;
    DBEdit3: TDBText;
    DBEdit4: TDBText;
    DBEdit5: TDBText;
    DBEdit6: TDBText;
    DBEdit7: TDBText;
    DBEdit9: TDBText;
    DBEdit10: TDBText;
    DBEdit11: TDBText;
    DBEdit12: TDBText;
    DBEdit13: TDBText;
    DBEdit14: TDBText;
    DBEdit15: TDBText;
    DBEdit16: TDBText;
    DBEdit17: TDBText;
    lbl_Csrq: TLabel;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    DataSource1: TDataSource;
    dbtxt1: TDBText;
    dbtxt2: TDBText;
    dbtxt3: TDBText;
    dbtxt4: TDBText;
    lbl_YxTj: TLabel;
    dbtxt5: TDBText;
    DBText1: TDBText;
    lbl_UserName: TLabel;
    procedure N1Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sWebSrvUrl:string;
  public
    { Public declarations }
    function DownLoadPhotoFromUrl(const Photo_Url:string;aImage:TImage=nil;const OverPhoto:Boolean=True):Boolean;
  end;

implementation
uses udm;
{$R *.dfm}

procedure TKsInfo.DataSource1DataChange(Sender: TObject; Field: TField);
var
  sfzh,sBmNo:string;
  Photo_Url:string;
begin
  if DataSource1.DataSet.FieldByName('是否同意调剂').AsBoolean then
    lbl_YxTj.Caption := '同意专业调剂'
  else
    lbl_YxTj.Caption := '不同意专业调剂';

  sfzh := DataSource1.DataSet.FieldByName('身份证号').AsString;
  if Length(Sfzh)=18 then
    lbl_Csrq.Caption := Copy(sfzh,7,4)+'年'+copy(sfzh,11,2)+'月'+Copy(sfzh,13,2)+'日'
  else if Length(sfzh)=15 then
    lbl_Csrq.Caption := '19'+Copy(sfzh,7,2)+'年'+copy(sfzh,9,2)+'月'+Copy(sfzh,11,2)+'日'
  else
    lbl_Csrq.Caption := '    /  /  /';

  Photo_Url := DataSource1.DataSet.FieldByName('照片文件名').AsString;
  sBmNo := DataSource1.DataSet.FieldByName('报名序号').AsString;
  if Self.Showing and (Photo_Url<>'') then
  begin
    img_Photo.Picture := nil;
    DownLoadPhotoFromUrl(Photo_Url,img_Photo,False);
  end;
end;

function TKsInfo.DownLoadPhotoFromUrl(const Photo_Url:string;aImage:TImage=nil;const OverPhoto:Boolean=True): Boolean;
var
  sUrl:string;
begin
  sUrl := Trim(Photo_Url);
  if sUrl='' then Exit;
  
  if LowerCase(Copy(sUrl,1,7))<>'http:// 'then
    sUrl := sWebSrvUrl+sUrl;

  dm.DownLoadKsPhoto(sUrl,aImage,OverPhoto);
end;

procedure TKsInfo.FormCreate(Sender: TObject);
begin
  sWebSrvUrl := dm.GetWebSrvUrl;
end;

procedure TKsInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_UP) and (not DataSource1.DataSet.Bof) then
    DataSource1.DataSet.Prior;
  if (Key=VK_DOWN) and (not DataSource1.DataSet.Eof) then
    DataSource1.DataSet.Next;
end;

procedure TKsInfo.FormShow(Sender: TObject);
begin
  DataSource1DataChange(Sender,nil);
end;

procedure TKsInfo.N1Click(Sender: TObject);
var
  fn:string;
begin
  fn := DataSource1.DataSet.FieldByName('照片文件名').AsString;
  if (fn<>'') then // and (img_Photo.Picture.Graphic<>nil) then
  begin
    fn := StringReplace(fn,'/','\',[rfReplaceAll]);
    SavePictureDialog1.FileName := ExtractFileName(fn);
    if SavePictureDialog1.Execute then
      img_Photo.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

end.
