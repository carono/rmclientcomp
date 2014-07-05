unit rcThemes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcRecords;

type

  { TRCThemes }

  TRCThemes = class
  private
    File1: string;
    Themes1: array of TRCTheme;
    function GetCount: Integer;
    function GetTheme: TRCTheme;

  public
    procedure SetTheme(ATheme: TRCTheme);
    function GetTheme(AType: word; AID: Integer): TRCTheme;
    property Count: Integer read GetCount;
    property Icons: TRCTheme read GetTheme;
    procedure Save;
    procedure Load;
    constructor Create(FileName: string; ACreate: boolean = False);
    destructor Destroy;
  end;

implementation

{ TRCThemes }

function TRCThemes.GetTheme: TRCTheme;
begin

end;

procedure TRCThemes.SetTheme(ATheme: TRCTheme);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if (Themes1[i].AType = ATheme.AType) and (Themes1[i].ID = ATheme.ID) then
    begin
      Themes1[i].Icon := ATheme.Icon;
      break;
    end;
end;

function TRCThemes.GetTheme(AType: word; AID: Integer): TRCTheme;
var
  i: Integer;
  Flag1: boolean;
begin
  Flag1 := False;
  for i := 0 to Count - 1 do
    if (Themes1[i].AType = AType) and (Themes1[i].ID = AID) then
    begin
      Result.AType := Themes1[i].AType;
      Result.ID := Themes1[i].ID;
      Result.Icon := Themes1[i].Icon;
      Flag1 := True;
      break;
    end;
  if not Flag1 then
  begin
    SetLength(Themes1, Count + 1);
    Themes1[Count - 1].AType := AType;
    Themes1[Count - 1].ID := AID;
    Themes1[Count - 1].Icon := '';
    Result := Themes1[Count - 1];
  end;
end;

function TRCThemes.GetCount: Integer;
begin
  Result := Length(Themes1);
end;

procedure TRCThemes.Save;
var
  i: Integer;
  FileStream1: TFileStream;
begin
  FileStream1 := TFileStream.Create(File1, fmOpenReadWrite);
  for i := 0 to Count - 1 do
    FileStream1.WriteBuffer(Themes1[i], SizeOf(TRCTheme));
  FileStream1.Free;
end;

procedure TRCThemes.Load;
begin

end;

constructor TRCThemes.Create(FileName: string; ACreate: boolean);
var
  Theme: TRCTheme;
  FileStream1: TFileStream;
begin
  SetLength(Themes1, 0);
  File1 := FileName;
  if not DirectoryExists(ExtractFileDir(FileName)) then
    CreateDir(ExtractFileDir(FileName));
  if not FileExists(FileName) then
  begin
    if ACreate then
      FileStream1 := TFileStream.Create(File1, fmCreate)
    else
      FileStream1 := TFileStream.Create(File1, fmOpenReadWrite);
  end
  else
    FileStream1 := TFileStream.Create(File1, fmOpenReadWrite);

  while FileStream1.Position <> FileStream1.Size do
  begin
    SetLength(Themes1, Length(Themes1) + 1);
    FileStream1.ReadBuffer(Themes1[Length(Themes1) - 1], SizeOf(Theme));
  end;
  FileStream1.Free;

end;

destructor TRCThemes.Destroy;
begin

end;

end.

