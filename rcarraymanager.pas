unit rcArrayManager;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ArrayManager, rcObject;

type

  { TRCArrayManager }

  TRCArrayManager = class(TArrayManager)
  protected
    function GetItem(index: Integer): TRCObject;
  public
    property Item[index: Integer]: TRCObject read GetItem;
    function GetItemBy(AID: Integer): TRCObject;
    function GetItemBy(AName: string): TRCObject;
  end;

implementation

{ TRCArrayManager }

function TRCArrayManager.GetItem(index: Integer): TRCObject;
begin
  Result := inherited GetItem(index) as TRCObject;
end;

function TRCArrayManager.GetItemBy(AID: Integer): TRCObject;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Item[i].ID = AID then
    begin
      Result := Item[i] as TRCObject;
      break;
    end;
end;

function TRCArrayManager.GetItemBy(AName: string): TRCObject;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Item[i].Name = AName then
    begin
      Result := Item[i] as TRCObject;
      break;
    end;
end;

end.
