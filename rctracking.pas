unit rcTracking;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcObject, rcArrayManager, rcIssueStatus, rcRedmineUser, rcUserRole;

type

  { TTracking }

  TTracking = class(TObject)
  private
    Roles1: TRcArrayManager;
    Statuses1: TRcArrayManager;
    Users1: TRcArrayManager;
    Active1: array of array of array of array of boolean;
  public
    procedure Add(ARole: TUserRole; ASlectedStatus: TIssueStatus; AOptionStatus: TIssueStatus; AUser: TRedmineUser);
    function isActive(ARole: TUserRole; ASlectedStatus: TIssueStatus; AStatus: TIssueStatus; AUser: TRedmineUser): boolean;
    function Storaged(ARole: TUserRole; AStatus: TIssueStatus; AUser: TRedmineUser): boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TTracking }

procedure TTracking.Add(ARole: TUserRole; ASlectedStatus: TIssueStatus; AOptionStatus: TIssueStatus; AUser: TRedmineUser);
var
  AIndex1, AIndex2, AIndex3, AIndex4: Integer;
begin
  AIndex1 := Roles1.GetItemIndex(Roles1.Add(ARole));
  AIndex2 := Statuses1.GetItemIndex(Statuses1.Add(ASlectedStatus));
  AIndex3 := Users1.GetItemIndex(Users1.Add(AUser));
  AIndex4 := Statuses1.GetItemIndex(Statuses1.Add(AOptionStatus));
  if Length(Active1) <= AIndex1 then
    SetLength(Active1, AIndex1 + 1);
  if Length(Active1[AIndex1]) <= AIndex2 then
    SetLength(Active1[AIndex1], AIndex2 + 1);
  if Length(Active1[AIndex1][AIndex2]) <= AIndex3 then
    SetLength(Active1[AIndex1][AIndex2], AIndex3 + 1);
  if Length(Active1[AIndex1][AIndex2][AIndex3]) <= AIndex4 then
    SetLength(Active1[AIndex1][AIndex2][AIndex3], AIndex4 + 1);
  Active1[AIndex1][AIndex2][AIndex3][AIndex4] := True;
end;

function TTracking.isActive(ARole: TUserRole; ASlectedStatus: TIssueStatus; AStatus: TIssueStatus; AUser: TRedmineUser): boolean;
var
  AIndex1, AIndex2, AIndex3, AIndex4: Integer;
begin
  try
    AIndex1 := Roles1.GetItemIndex(Roles1.Add(ARole));
    AIndex2 := Statuses1.GetItemIndex(Statuses1.Add(ASlectedStatus));
    AIndex3 := Users1.GetItemIndex(Users1.Add(AUser));
    AIndex4 := Statuses1.GetItemIndex(Statuses1.Add(AStatus));
    Result := Active1[AIndex1][AIndex2][AIndex3][AIndex4];
  except
    Result := False;
  end;
end;

function TTracking.Storaged(ARole: TUserRole; AStatus: TIssueStatus; AUser: TRedmineUser): boolean;
var
  AIndex1, AIndex2, AIndex3: Integer;
begin
  Result := False;
  AIndex1 := Roles1.GetItemIndex(ARole);
  if (Length(Active1) > AIndex1) and (AIndex1 <> -1) then
  begin
    AIndex2 := Statuses1.GetItemIndex(AStatus);
    if (Length(Active1[AIndex1]) > AIndex2) and (AIndex2 <> -1) then
    begin
      AIndex3 := Users1.GetItemIndex(AUser);
      if (Length(Active1[AIndex1][AIndex2]) > AIndex3) and (AIndex3 <> -1) then
        Result := True;
    end;
  end;
end;

constructor TTracking.Create;
begin
  Roles1 := TRCArrayManager.Create(self);
  Statuses1 := TRCArrayManager.Create(self);
  Users1 := TRCArrayManager.Create(self);
end;

destructor TTracking.Destroy;
begin
  inherited Destroy;
  Roles1.Free;
  Statuses1.Free;
  Users1.Free;
end;


end.

