unit rcIssueCategory;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcObject, rcRedmineUser, rcArrayManager;

type
  TIssueCategory = class(TRCObject)
  private
    Assigned1: TRedmineUser;
  public
    property Assigned: TRedmineUser read Assigned1 write Assigned1;
  end;


type

  { TCategorys }

  TCategorys = class(TRCArrayManager)
  private
    function GetItem(index: Integer): TIssueCategory;
  public
    property Item[index: Integer]: TIssueCategory read GetItem;
    function Add(AObject: TIssueCategory): TIssueCategory;
    function GetItemBy(AID: Integer): TIssueCategory; overload;
  end;

implementation

{ TCategorys }

function TCategorys.GetItem(index: Integer): TIssueCategory;
begin
  Result := inherited GetItem(index) as TIssueCategory;
end;

function TCategorys.Add(AObject: TIssueCategory): TIssueCategory;
begin
  Result := inherited Add(AObject) as TIssueCategory;
end;

function TCategorys.GetItemBy(AID: Integer): TIssueCategory;
begin
  Result := inherited GetItemBy(AID) as TIssueCategory;
end;

end.
