{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}

{ TNews }

function TNews.GetCount: Integer;
begin
  Result := length(Items1);
end;

function TNews.GetItem(index: Integer): TNewsitem;
begin
  Result := Items1[index];
end;

procedure TNews.AddNews(News: TNewsitem);
begin
  SetLength(Items1, Count + 1);
  Items1[Count - 1] := News;
end;

destructor TNews.Destroy;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items1[i].Free;
end;