{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}
{ TTracker }

destructor TTracker.Destroy;
begin

end;

procedure TTracker.Clear;
var
  i: Integer;
begin
  i := 0;
  while (i < Issues.Count) do
  begin
    Redmine.Issues.Extract(Issues.Item[i]);
    Inc(i);
  end;
end;

function TTracker.GetRedmine: TRedmineClient;
begin
  Result := Owner1.Redmine;
end;

procedure TTracker.SetActive(AValue: boolean);
begin
  if AValue <> Active1 then
  begin
    Active1 := AValue;
    (Owner as TRedmineProject).isChanged1 := True;
  end;
end;

procedure TTracker.Update(XMLNode1: TDOMNode);
var
  IssueNumber1, p: Integer;
  Issue1, ParentIssue1: TIssue;
  ParentNode1: TDOMNode;
  ParentIssueId1: string;
begin
  IssueNumber1 := StrToInt(XMLNode1.FindNode('id').TextContent);
  Issue1 := Issues.GetItemBy(IssueNumber1);
  if not Assigned(Issue1) then
  begin
    ParentNode1 := XMLNode1.FindNode('parent');
    if Assigned(ParentNode1) then
    begin
      ParentIssueId1 := ParentNode1.Attributes.GetNamedItem('id').NodeValue;
      ParentIssue1 := Redmine.Issues.GetItemBy(StrToInt(ParentIssueId1));
      if not Assigned(ParentIssue1) then
      begin
        ParentIssue1 := Issues.Add(TIssue.Create(self, StrToInt(ParentIssueId1)));
        ParentIssue1.Refresh(True);
      end;
      Issue1 := ParentIssue1.AddChild(IssueNumber1);
    end
    else
      Issue1 := Issues.Add(TIssue.Create(self, IssueNumber1));
  end;
  Issue1.Tracker1 := self;
  Issue1.Update(XMLNode1);
end;

procedure TTracker.Update(CSV: TCSV; Row: Integer);
//var
//  IssueNumber1, p: integer;
//  Issue1, ParentIssue1: TIssue;
//  ParentIdStr1: string;
begin
  //IssueNumber1 := StrToInt(CSV.GetValueByField(Row, '#'));
  //Issue1 := GetIssue(IssueNumber1);
  //if not Assigned(Issue1) then
  //begin
  //  ParentIdStr1 := CSV.GetValueByField(Row, 'Родительская задача');
  //  if (ParentIdStr1 = '') then
  //  begin
  //    ParentIssue1 := Redmine.Issues.GetItemBy(StrToInt(ParentIdStr1));
  //    Issue1 := ParentIssue1.AddChild(IssueNumber1);
  //  end
  //  else
  //    Issue1 := AddIssue(IssueNumber1);
  //end;
  //Issue1.Update(CSV, Row);
end;

procedure TTracker.Refresh;
begin
  Redmine.FillIssues(Owner.Id, Id);
end;

function TTracker.GetActive: boolean;
begin
  Result := Active1;
end;

function TTracker.GetCountIssues: Integer;
begin
  Issues1.Free;
end;

function TTracker.AddIssue(ANumber: Integer): TIssue;
begin
  Result := TIssue.Create(Self, ANumber);
  Result.Tracker1 := self;
  Redmine.Issues.Add(Issues.Add(Result));
end;

constructor TTracker.Create(AOwner: TRedmineProject);
begin
  Issues1 := TIssues.Create(self);
  Owner1 := AOwner;
end;

{ TTrackers }

function TTrackers.GetItem(index: Integer): TTracker;
begin
  Result := inherited GetItem(index) as TTracker;
end;

function TTrackers.Add(AObject: TTracker): TTracker;
begin
  Result := inherited Add(AObject) as TTracker;
end;

function TTrackers.GetItemBy(AID: Integer): TTracker;
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

procedure TTrackers.Assign(ASource: TTrackers);
var
  i: Integer;
  Tracker1: TTracker;
begin
  Clear;
  for i := 0 to ASource.Count - 1 do
  begin
    Tracker1 := TTracker.Create(ASource.Item[i].Owner);
    Tracker1.Name1 := ASource.Item[i].Name1;
    Tracker1.Value1 := ASource.Item[i].Value1;
    Tracker1.Active1 := ASource.Item[i].Active1;
    Add(Tracker1);
  end;
end;

procedure TTrackers.Clear;
var
  i: Integer;
begin
  i := 0;
  while (i < Count) do
  begin
    Item[i].Clear();
    Inc(i);
  end;
  inherited Clear;
end;