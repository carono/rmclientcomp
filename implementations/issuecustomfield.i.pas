{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}
{ TIssueCustomField }

constructor TIssueCustomField.Create(AName: string; AID: Integer; AValue: string);
begin
  inherited Create(AName, AID);
  FValue := AValue;
end;

{ TIssueCustomFieldManager }

function TIssueCustomFieldManager.GetItem(index: Integer): TIssueCustomField;
begin
  Result := inherited GetItem(index) as TIssueCustomField;
end;

function TIssueCustomFieldManager.GetOwner: TIssue;
begin
  Result := inherited GetOwner() as TIssue;
end;

procedure TIssueCustomFieldManager.SetOwner(AValue: TIssue);
begin
  FOwner1 := AValue;
end;

function TIssueCustomFieldManager.Add(AObject: TIssueCustomField): TIssueCustomField;
begin
  Result := inherited Add(AObject) as TIssueCustomField;
end;

function TIssueCustomFieldManager.GetItemByID(AID: Integer): TIssueCustomField;
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

function TIssueCustomFieldManager.Current: TIssueCustomField;
begin
  Result := inherited Current() as TIssueCustomField;
end;

procedure TIssueCustomFieldManager.Load(XMLNode: TDOMNode);
var
  i: Integer;
  CField1: TDOMNode;
  Name1, Value1: string;
  ID1: Integer;
  CField2: TIssueCustomField;
begin
  Clear();
  for i := 0 to XMLNode.ChildNodes.Count - 1 do
  begin
    CField1 := XMLNode.ChildNodes[i];
    Name1 := CField1.Attributes.GetNamedItem('name').NodeValue;
    ID1 := StrToInt(CField1.Attributes.GetNamedItem('id').NodeValue);
    Value1 := CField1.TextContent;
    CField2 := TIssueCustomField.Create(Name1, ID1, Value1);
    Add(CField2);
  end;
end;

procedure TIssueCustomFieldManager.Load;
begin

end;

procedure TIssueCustomFieldManager.Clear;
begin
  inherited Clear;
end;
