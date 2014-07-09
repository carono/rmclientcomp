{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}

{ TContentThread }

destructor TContentThread.Destroy;
begin
  (Owner as TRedmineClient).RedmineAnswer := Content1;
  (Owner as TRedmineClient).UnSetBusy(False);
  inherited;
end;

procedure TContentThread.Execute;
var
  Req1: TIdHTTPRequest;
begin
  HTTPError1 := 0;
  Content1 := '';
  //(Owner as TRedmineClient).HTTP.CookieManager;
  try
    case Method1 of
      TMPost:
        if Assigned(Data1) then
          Content1 := (Owner as TRedmineClient).HTTP.Post(Url1, Data1)
        else
          Content1 := (Owner as TRedmineClient).HTTP.Post(Url1, Data2);
      TMGet:
        Content1 := (Owner as TRedmineClient).HTTP.Get(Url1);
      TMPut:
        Content1 := (Owner as TRedmineClient).HTTP.Put(Url1, Data1);
      TMDelete:
        Content1 := TIdHTTPCUS((Owner as TRedmineClient).HTTP).Delete(Url1);
    end;
  except
    on E: EIdHTTPProtocolException do
      Content1 := E.ErrorMessage;
  end;
end;

constructor TContentThread.Create(AOwner: TObject; Url: string; AMethod: TContentMethod; AData: TStream);
begin
  inherited Create(True);
  Owner := AOwner;
  Url1 := Url;
  (Owner as TRedmineClient).SetBusy;
  FreeOnTerminate := True;
  if Assigned(AData) then
    Data1 := AData;
  Method1 := AMethod;
  Resume;
end;

constructor TContentThread.Create(AOwner: TObject; Url: string; AMethod: TContentMethod; AData: TStrings);
begin
  inherited Create(True);
  Owner := AOwner;
  Url1 := Url;
  (Owner as TRedmineClient).SetBusy;
  FreeOnTerminate := True;
  if Assigned(AData) then
    Data2 := AData;
  Method1 := AMethod;
  Resume;
end;

constructor TContentThread.Create(AOwner: TObject; Url: string; AMethod: TContentMethod);
begin
  inherited Create(True);
  Owner := AOwner;
  Url1 := Url;
  (Owner as TRedmineClient).SetBusy;
  FreeOnTerminate := True;
  Method1 := AMethod;
  Resume;
end;
