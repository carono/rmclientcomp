unit rcIssueStatus;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcObject,rcArrayManager;

type

  { TIssueStatus }

  TIssueStatus = class(TRCObject)
  private
    isDefault1: boolean;
    isClosed1: boolean;
  public
    property isDefault: boolean read isDefault1 write isDefault1;
    property isClosed: boolean read isClosed1 write isClosed1;
    constructor Create(AName: string; AID: Integer); override;
  end;

  { TStatuses }

  TStatuses = class(TRCArrayManager)
  private
    function GetItem(index: Integer): TIssueStatus;
  public
    property Item[index: Integer]: TIssueStatus read GetItem;
    function Add(AObject: TIssueStatus): TIssueStatus;
    function GetItemBy(AID: Integer): TIssueStatus; overload;
  end;

implementation

{ TIssueStatus }

constructor TIssueStatus.Create(AName: string; AID: Integer);
begin
  inherited Create(AName, AID);
  isClosed1 := False;
  isDefault1 := False;
end;

{ TStatuses }

function TStatuses.GetItem(index: Integer): TIssueStatus;
begin
  Result := inherited GetItem(index) as TIssueStatus;
end;

function TStatuses.Add(AObject: TIssueStatus): TIssueStatus;
begin
  Result := inherited Add(AObject) as TIssueStatus;
end;

function TStatuses.GetItemBy(AID: Integer): TIssueStatus;
begin
  Result := inherited GetItemBy(AID) as TIssueStatus;
end;

end.
