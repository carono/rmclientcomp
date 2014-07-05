unit IdHTTPCUS;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IdHTTP;

type

  { TIdHTTPCUS }

  TIdHTTPCUS = class(TIdHTTP)
  public
    function Delete(AURL: string): string; overload;
    procedure Delete(AURL: string; AResponseContent: TStream); overload;
  end;

implementation

{ TIdHTTPCUS }

function TIdHTTPCUS.Delete(AURL: string): string;
var
  LResponse: TStringStream;
begin
  LResponse := TStringStream.Create('');   {do not localize}
  try
    Delete(AURL, LResponse);
  finally
    Result := LResponse.DataString;
    FreeAndNil(LResponse);
  end;
end;

procedure TIdHTTPCUS.Delete(AURL: string; AResponseContent: TStream);
begin
  Assert(AResponseContent <> nil);
  DoRequest(Id_HTTPMethodDelete, AURL, nil, AResponseContent, []);
end;

end.
