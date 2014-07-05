unit rcObject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TRCObject }

  TRCObject = class(TObject)
  private
    ID1: Integer;
    Name1: string;
  public
    property ID: Integer read ID1;
    property Name: string read Name1;
    constructor Create(AName: string; AID: Integer); virtual;
  end;

implementation

{ TRCObject }

constructor TRCObject.Create(AName: string; AID: Integer);
begin
  ID1 := AID;
  Name1 := AName;
end;

end.
