unit uPhotoProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, frxpngimage, jpeg, ExtDlgs, pngimage;

type
  TPhotoProcess = class(TForm)
    pnl_photo: TPanel;
    AImg: TImage;
    img_New: TImage;
    lbl1: TLabel;
    Panel1: TPanel;
    btn1: TButton;
    btn_Exit: TButton;
    btn_UploadPhoto: TBitBtn;
    chk_Center: TCheckBox;
    chk_Stretch: TCheckBox;
    img2: TImage;
    dlgOpen: TOpenPictureDialog;
    btn2: TButton;
    procedure img2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure img2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_UploadPhotoClick(Sender: TObject);
    procedure chk_StretchClick(Sender: TObject);
    procedure chk_CenterClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
    IsMouseDown:Boolean;
    aX,aY:Integer;
  public
    { Public declarations }
  end;

var
  PhotoProcess: TPhotoProcess;

implementation

{$R *.dfm}

procedure TPhotoProcess.btn2Click(Sender: TObject);
begin
  img_New.Picture := nil;
end;

procedure TPhotoProcess.btn_UploadPhotoClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    AImg.Picture.LoadFromFile(dlgOpen.FileName);
end;

procedure TPhotoProcess.chk_CenterClick(Sender: TObject);
begin
  AImg.Center := chk_Center.Checked;
end;

procedure TPhotoProcess.chk_StretchClick(Sender: TObject);
begin
  AImg.Stretch := chk_Stretch.Checked;
end;

procedure TPhotoProcess.img2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown := True;
  aX := X;
  aY := Y;
end;

procedure TPhotoProcess.img2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not IsMouseDown then Exit;

  img2.Left := img2.Left+X-aX;
  img2.Top := img2.Top+Y-aY;
  aX := X;
  aY := Y;
end;

procedure TPhotoProcess.img2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  MS:TMemoryStream;
  aJpeg :TJPEGImage;
  bmp : TBitMap;
begin
  if not IsMouseDown then Exit;

  img2.Left := img2.Left+X-aX;
  img2.Top := img2.Top+Y-aY;
  aX := X;
  aY := Y;
  if IsMouseDown then
  begin
    bmp := TBitmap.Create;
    aJpeg := TJPEGImage.Create;
    MS := TMemoryStream.Create;
    try
      //AImg.Picture.Graphic.SaveToStream(MS);
      //MS.Position := 0;
      //aJpeg.LoadFromStream(MS);
      //bmp.Canvas.StretchDraw(Rect(img2.Left,img2.Top,img2.Left+Img_New.Width,img2.Top+Img_New.Height),aJpeg);
      Img_New.Picture := nil;
      img2.Height := 125;
      img2.Width := 100;
      Img_New.Canvas.StretchDraw(img2.ClientRect,AImg.Picture.Graphic);
      //aJpeg.CompressionQuality := 100;
      //aJpeg.Assign(bmp);
      //MS.Position := 0;
      //aJpeg.SaveToFile('c:\aaa.jpg');
      //aJpeg.SaveToStream(MS);
      //MS.Position := 0;
      //img_New.Picture.Graphic.LoadFromStream(MS);
      //img_New.Picture.Graphic.Assign(aJpeg);
      //img_New.Picture.Graphic.LoadFromStream(MS);
      //ImageField.LoadFromStream(MS);
      //cds_Photo.Post;
      //DM.UpdateData('报名序号','select * from 考生照片表 where 1=0',cds_Photo.Delta);
    finally
      bmp.Free;
      aJpeg.Free;
      MS.Free;
    end;
  end;

  IsMouseDown := False;
end;

end.
