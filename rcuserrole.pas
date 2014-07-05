unit rcUserRole;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcObject, rcSets, rcArrayManager;

type
  TUserRole = class(TRCObject)
  private
    Privileges1: TRCPermissions;
  public
    property Privileges: TRCPermissions read Privileges1 write Privileges1;
  end;

type

  { TRoles }

  TRoles = class(TRcArrayManager)
  private
    function GetItem(index: Integer): TUserRole;
  public
    property Item[index: Integer]: TUserRole read GetItem;
    function GetItemBy(AID: Integer): TUserRole;
    function GetItemBy(AName: string): TUserRole;
    function Add(AObject: TUserRole): TUserRole;
  end;

implementation

{ TRoles }

function TRoles.GetItem(index: Integer): TUserRole;
begin
  Result := inherited GetItem(index) as TUserRole;
end;

function TRoles.Add(AObject: TUserRole): TUserRole;
begin
  Result := inherited Add(AObject) as TUserRole;
end;

function TRoles.GetItemBy(AID: Integer): TUserRole;
begin
  Result := inherited GetItemBy(AID) as TUserRole;
end;

function TRoles.GetItemBy(AName: string): TUserRole;
begin
  Result := inherited GetItemBy(AName) as TUserRole;
end;

end.
