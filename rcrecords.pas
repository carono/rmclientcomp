unit rcRecords;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TRCModuleRec = record
    Name: string[64];
    ID: string[64];
    Enabled: boolean;
  end;

type
  TRComment = record
    Autor: string;
    Text: string;
    Added: TDate;
  end;

type
  TProjectParam = record
    Name: string[50];
    Site: string[255];
    Login: string[50];
    Password: string[50];
  end;

type
  TRCTheme = record
    AType: word;
    ID: Integer;
    Icon: string[255];
  end;

type
  TElemParsed = record
    Active: boolean;
    Parsed: boolean;
  end;

implementation

end.
