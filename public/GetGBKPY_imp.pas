{Import unit for GetGBKPY.Dll}

unit GetGBKPY_imp;

interface
uses
  Types,SysUtils;

function GetPY(const HZ: WORD; const buf: pchar; const count:integer): DWORD; stdcall;
function GetFirstPY(const sStr:string;const iCount:Integer=4):string;

implementation
  function GetPY(const HZ: WORD; const buf: pchar; const count:integer): DWORD;	external 'GetGBKPY' ;//index 1;

//{ ======放在uDM.pas中去实现＝＝＝＝＝＝＝＝＝
//判断字符是否是汉字
function IsMBCSChar(const ch: Char): Boolean;
begin
  Result := (ByteType(ch, 1) <> mbSingleByte);
end;

function GetFirstPY(const sStr:string;const iCount:Integer=4):string;
var
  HZ: WORD;
  buf: array [0..100] of char;
  i: Integer;
begin
  Result := '';
  if length(sStr) < 0 then
    Exit;
  i := 1;
  while i<=Length(sStr) do
  begin
    if IsMBCSChar(sStr[i]) then
    begin
      HZ:= WORD(sStr[i]) shl 8 + WORD(sStr[i+1]);
      GetPY(HZ, buf, 100);
      Result := Result + Copy(string(buf),1,1);
      i := i+2;
    end else
    begin
      Result := Result + sStr[i];
      Inc(i);
    end;
    if Length(Result)>=iCount then
       Break;
  end;
  Result := UpperCase(Result);
end;
//}

end.
