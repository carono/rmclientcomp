unit rcIssuesActivity;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcObject, rcArrayManager;

type
  TIssuesActivity = class(TRCObject);

type

  { TActivities }

  TActivities = class(TRCArrayManager)
  private
    function GetItem(index: Integer): TIssuesActivity;
  public
    property Item[index: Integer]: TIssuesActivity read GetItem;
    function Add(AObject: TIssuesActivity): TIssuesActivity;
    function GetItemBy(AID: Integer): TIssuesActivity;
  end;

implementation

{ TActivities }

function TActivities.GetItem(index: Integer): TIssuesActivity;
begin
  Result := inherited GetItem(index) as TIssuesActivity;
end;

function TActivities.Add(AObject: TIssuesActivity): TIssuesActivity;
begin
  Result := inherited Add(AObject) as TIssuesActivity;
end;

function TActivities.GetItemBy(AID: Integer): TIssuesActivity;
begin
  Result := inherited GetItemBy(AID) as TIssuesActivity;
end;

end.

