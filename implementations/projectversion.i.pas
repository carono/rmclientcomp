{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}

{ TVersions }

function TVersions.GetItem(index: Integer): TProjectVersion;
begin
  Result := inherited GetItem(index) as TProjectVersion;
end;

function TVersions.Add(AObject: TProjectVersion): TProjectVersion;
begin
  Result := inherited Add(AObject) as TProjectVersion;
end;

function TVersions.GetItemBy(AID: Integer): TProjectVersion;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Item[i].ID = AID then
    begin
      Result := Item[i];
      break;
    end;
end;