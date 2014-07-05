unit rcUserProfile;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TUserProfile }

  TUserProfile = class(TObject)
  public
    FirstName: string;
    SecondName: string;
    Email: string;
    Login: string;
    APIkey: string;
    Created: TDateTime;
    LastLogined: TDateTime;
    constructor Create;
    destructor Destroy;
  end;

implementation

{ TUserProfile }

constructor TUserProfile.Create;
begin

end;

destructor TUserProfile.Destroy;
begin

end;

end.
