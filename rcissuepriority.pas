unit rcIssuePriority;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcObject,rcArrayManager;

type

  { TIssuePriority }

  TIssuePriority = class(TRCObject)
  protected
    isDefault1: boolean;
  public
    property isDefault: boolean read isDefault1 write isDefault1;
    constructor Create(AName: string; AID: Integer); override;
  end;

    { TPrioritys }

  TPrioritys = class(TRCArrayManager)
  private
    function GetItem(index: Integer): TIssuePriority;
  public
    property Item[index: Integer]: TIssuePriority read GetItem;
    function Add(AObject: TIssuePriority): TIssuePriority;
    function GetItemBy(AID: Integer): TIssuePriority; overload;
  end;

implementation

{ TIssuePriority }

constructor TIssuePriority.Create(AName: string; AID: Integer);
begin
  inherited Create(AName, AID);
  isDefault1 := False;
end;

{ TPrioritys }

function TPrioritys.GetItem(index: Integer): TIssuePriority;
begin
  Result := inherited GetItem(index) as TIssuePriority;
end;

function TPrioritys.Add(AObject: TIssuePriority): TIssuePriority;
begin
  Result := inherited Add(AObject) as TIssuePriority;
end;

function TPrioritys.GetItemBy(AID: Integer): TIssuePriority;
begin
  Result := inherited GetItemBy(AID) as TIssuePriority;
end;

end.
