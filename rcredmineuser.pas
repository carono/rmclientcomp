unit rcRedmineUser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcObject, rcUserProfile, rcUserRole, rcArrayManager;

type

  { TRedmineUser }

  TRedmineUser = class(TRCObject)
  private
    Info1: TUserProfile;
  public
    property Info: TUserProfile read Info1;
    constructor Create(AName: string; AID: Integer); override;
    destructor Destroy();
  end;

type

  { TUsers }

  TUsers = class(TRCArrayManager)
  private
    function GetItem(index: Integer): TRedmineUser;
  public
    function Add(AObject: TRedmineUser): TRedmineUser;
    property Item[index: Integer]: TRedmineUser read GetItem;
    function GetItemBy(AID: Integer): TRedmineUser;
    function GetItemBy(AName: string): TRedmineUser;
  end;

implementation

{ TRedmineUser }

constructor TRedmineUser.Create(AName: string; AID: Integer);
begin
  inherited Create(AName, AID);
  Info1 := TUserProfile.Create;
end;

destructor TRedmineUser.Destroy;
begin
  Info1.Free;
end;

{ TUsers }

function TUsers.GetItem(index: Integer): TRedmineUser;
begin
  Result := inherited GetItem(index) as TRedmineUser;
end;

function TUsers.Add(AObject: TRedmineUser): TRedmineUser;
begin
  Result := GetItemBy(AObject.ID);
  if not assigned(Result) then
    Result := inherited Add(AObject) as TRedmineUser;
end;

function TUsers.GetItemBy(AID: Integer): TRedmineUser;
begin
  Result := inherited GetItemBy(AID) as TRedmineUser;
end;

function TUsers.GetItemBy(AName: string): TRedmineUser;
begin
  Result := inherited GetItemBy(AName) as TRedmineUser;
end;

end.
