{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}

{ TIssues }

function TIssues.GetItem(index: Integer): TIssue;
begin
  Result := inherited GetItem(index) as TIssue;
end;

function TIssues.Add(AObject: TIssue): TIssue;
begin
  Result := inherited Add(AObject) as TIssue;
end;

function TIssues.GetItemBy(AID: Integer): TIssue;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Item[i].Number1 = AID then
    begin
      Result := Item[i];
      break;
    end;
end;

procedure TIssues.Clear;
var
  i: Integer;
begin
  i := 0;
  while (i < Count) do
  begin
    (Owner as TTracker).Redmine.Issues.Extract(Item[i]);
    Inc(i);
  end;
  inherited Clear;
end;


{ TIssue }

function TIssue.GetAutor: TRedmineUser;
begin
  if IsNothing(NominalAutor1) then
    Result := Autor1
  else
    Result := NominalAutor1;
end;

function TIssue.GetClosed: TDateTime;
begin
  if IsNothing(NominalClosed1) then
    Result := Closed1
  else
    Result := NominalClosed1;
end;

function TIssue.GetAssignee: TRedmineUser;
begin
  if IsNothing(NominalAssignee1) then
    Result := Assignee1
  else
    Result := NominalAssignee1;
end;

function TIssue.GetCategory: TIssueCategory;
begin
  if IsNothing(NominalCategory1) then
    Result := Category1
  else
    Result := NominalCategory1;
end;

function TIssue.GetComment(index: Integer): TRComment;
begin
  Result := Comments1[index];
end;

function TIssue.getCountComments: Integer;
begin
  Result := Length(Comments1);
end;

function TIssue.GetCreated: TDateTime;
begin
  if IsNothing(NominalCreated1) then
    Result := Created1
  else
    Result := NominalCreated1;
end;

function TIssue.GetDone: double;
begin
  if IsNothing(NominalDone1) then
    Result := Done1
  else
    Result := NominalDone1;
end;

function TIssue.GetDueDate: TDateTime;
begin
  if IsNothing(NominalDueDate1) then
    Result := DueDate1
  else
    Result := NominalDueDate1;
end;

function TIssue.GetSpent: double;
begin
  if IsNothing(NominalSpent1) then
    Result := Spent1
  else
    Result := NominalSpent1;
end;

function TIssue.GetStarted: TDateTime;
begin
  if IsNothing(NominalStarted1) then
    Result := Started1
  else
    Result := NominalStarted1;
end;

function TIssue.GetSubject: string;
begin
  if IsNothing(NominalSubject1) then
    Result := Subject1
  else
    Result := NominalSubject1;
end;

function TIssue.GetUpdated: TDateTime;
begin
  if IsNothing(NominalUpdated1) then
    Result := Updated1
  else
    Result := NominalUpdated1;
end;

function TIssue.GetDescription: AnsiString;
begin
  if IsNothing(NominalDescription1) then
    Result := Description1
  else
    Result := NominalDescription1;
end;

function TIssue.GetisChanged: boolean;
begin
  Result := isChanged1;
end;

function TIssue.GetParent: TIssue;
begin
  if IsNothing(NominalParent1) then
    Result := Parent1
  else
    Result := NominalParent1;
end;

function TIssue.GetPriority: TIssuePriority;
begin
  if IsNothing(NominalPriority1) then
    Result := Priority1
  else
    Result := NominalPriority1;
end;

function TIssue.GetProject: TRedmineProject;
begin
  if IsNothing(NominalProject1) then
    Result := Project1
  else
    Result := NominalProject1;
end;

function TIssue.GetRedmine: TRedmineClient;
begin
  if Assigned(Project1) then
    Result := Project1.Redmine
  else if Owner1 is TRedmineClient then
    Result := Owner1 as TRedmineClient
  else if Assigned(Parent) then
    Result := Parent.Redmine
  else
    Result := nil;
end;

function TIssue.GetStatus: TIssueStatus;
begin
  if IsNothing(NominalStatus1) then
    Result := Status1
  else
    Result := NominalStatus1;
end;

function TIssue.GetTracker: TTracker;
begin
  if IsNothing(NominalTracker1) then
    Result := Tracker1
  else
    Result := NominalTracker1;
end;

function TIssue.GetURL: string;
begin
  Result := Redmine.Site + '/issues/' + IntToStr(Number);
end;

function TIssue.GetVersion: TProjectVersion;
begin
  if IsNothing(NominalVersion1) then
    Result := Version1
  else
    Result := NominalVersion1;
end;

procedure TIssue.SetAssignee(AValue: TRedmineUser);
begin
  SetParam(TObject(AValue), TObject(Assignee1), TObject(NominalAssignee1));
end;

procedure TIssue.SetAutor(AValue: TRedmineUser);
begin
  SetParam(TObject(AValue), TObject(Autor1), TObject(NominalAutor1));
end;

procedure TIssue.SetCategory(AValue: TIssueCategory);
begin
  SetParam(TObject(AValue), TObject(Category1), TObject(NominalCategory1));
end;

procedure TIssue.SetClosed(AValue: TDateTime);
begin
  SetParam(AValue, Closed1, NominalClosed1);
end;

procedure TIssue.SetCreated(AValue: TDateTime);
begin
  SetParam(AValue, Created1, NominalCreated1);
end;

procedure TIssue.SetDescription(AValue: AnsiString);
begin
  SetParam(AValue, Description1, NominalDescription1);
end;

procedure TIssue.SetDone(AValue: double);
begin
  SetParam(AValue, Done1, NominalDone1);
end;

procedure TIssue.SetDueDate(AValue: TDateTime);
begin
  SetParam(AValue, DueDate1, NominalDueDate1);
end;

procedure TIssue.SetFinished(AValue: TDateTime);
begin
  SetParam(AValue, Finished1, NominalFinished1);
end;

procedure TIssue.SetProject(AValue: TRedmineProject);
begin
  SetParam(TObject(AValue), TObject(Project1), TObject(NominalProject1));
end;

procedure TIssue.SetSpent(AValue: double);
begin
  SetParam(AValue, Spent1, NominalSpent1);
end;

procedure TIssue.SetStarted(AValue: TDateTime);
begin
  SetParam(AValue, Started1, NominalStarted1);
end;

procedure TIssue.SetStatus(AValue: TIssueStatus);
begin
  SetParam(TObject(AValue), TObject(Status1), TObject(NominalStatus1));
end;

procedure TIssue.SetSubject(AValue: string);
begin
  if Number1 = 0 then
    Subject1 := AValue
  else
    SetParam(AValue, Subject1, NominalSubject1);
end;

procedure TIssue.SetTracker(AValue: TTracker);
begin
  SetParam(TObject(AValue), TObject(Tracker1), TObject(NominalTracker1));
end;

procedure TIssue.SetUpdated(AValue: TDateTime);
begin
  SetParam(AValue, Updated1, NominalUpdated1);
end;

procedure TIssue.SetVersion(AValue: TProjectVersion);
begin
  SetParam(TObject(AValue), TObject(Version1), TObject(NominalVersion1));
end;

procedure TIssue.ParseComments(XMLNode1: TDOMNode);
var
  i: Integer;
  Journal1, Notes1: TDOMNode;
begin
  SetLength(Comments1, 0);
  if Assigned(XMLNode1.FindNode('journals')) then
  begin
    for i := 0 to XMLNode1.FindNode('journals').ChildNodes.Count - 1 do
    begin
      Journal1 := XMLNode1.FindNode('journals').ChildNodes.Item[i];
      Notes1 := Journal1.FindNode('notes');
      if Notes1.TextContent <> '' then
      begin
        SetLength(Comments1, CountCommnets + 1);
        Comments1[CountCommnets - 1].Autor :=
          Journal1.FindNode('user').Attributes.GetNamedItem('name').NodeValue;
        if Assigned(Journal1.FindNode('created_on')) then
          Comments1[CountCommnets - 1].Added :=
            StrToDateTimeCustom(Journal1.FindNode('created_on').TextContent)
        else
        begin
          Comments1[CountCommnets - 1].Added := 0;
        end;
        Comments1[CountCommnets - 1].Text := StringReplace(Notes1.TextContent, #10, LineEnding, [rfReplaceAll]);
      end;
    end;
  end;
end;

function TIssue.SetParam(var AValue: TObject; var AParam: TObject; var ANominalValue: TObject): boolean;
begin
  if pointer(AValue) = pointer(AParam) then
    SetNothing(ANominalValue)
  else
  begin
    AParam := AValue;
    isChanged1 := True;
  end;
end;

function TIssue.SetParam(var AValue: TDateTime; var AParam: TDateTime; var ANominalValue: TDateTime): boolean;
begin
  if AValue = AParam then
    SetNothing(ANominalValue)
  else
  begin
    AParam := AValue;
    isChanged1 := True;
  end;
end;

function TIssue.SetParam(var AValue: AnsiString; var AParam: AnsiString; var ANominalValue: AnsiString): boolean;
begin
  if AValue = AParam then
    SetNothing(ANominalValue)
  else
  begin
    AParam := AValue;
    isChanged1 := True;
  end;
end;

function TIssue.CreateNode(AParent: TXMLDocument; AName, AValue: string): TDOMElement;
begin
  Result := AParent.CreateElement(AName);
  Result.TextContent := AValue;
end;

function TIssue.Delete: boolean;
begin
  if (Redmine.CheckPermission(Project, [DELETE_ISSUES])) then
  begin
    Redmine.DeleteContent(Redmine.Site + '/issues/' + IntToStr(Number) + '.xml');
    Result := Redmine.HTTP.ResponseCode = 200;
  end
  else
    Result := False;
end;

procedure TIssue.UpdateComments;
var
  RC: TRedmineClient;
  i: Integer;
  XML: TXMLDocument;
  Notes1, Journal1: TDOMNode;
  Content: string;
begin
  RC := Redmine;
  Content := RC.GetContent(RC.Site + '/issues/' + IntToStr(Number) + '.xml?include=journals');
  LoadXMLContent(XML, Content);
  ParseComments(XML.FindNode('issue'));
  XML.Free;
end;

procedure TIssue.AddComment(Message: string);
begin
  Note1 := Message;
  Save();
end;

procedure TIssue.SetParent(AValue: TIssue);
begin
  SetParam(TObject(AValue), TObject(Parent1), TObject(NominalParent1));
end;

procedure TIssue.SetPriority(AValue: TIssuePriority);
begin
  SetParam(TObject(AValue), TObject(Priority1), TObject(NominalPriority1));
end;

procedure TIssue.Cancel;
begin
  isChanged1 := False;
  SetNothing(NominalParent1);
  SetNothing(NominalTracker1);
  SetNothing(NominalStatus1);
  SetNothing(NominalPriority1);
  SetNothing(NominalAssignee1);
  SetNothing(NominalVersion1);
  SetNothing(NominalClosed1);
  SetNothing(NominalCategory1);
  SetNothing(NominalProject1);
  SetNothing(NominalAutor1);
  SetNothing(NominalDescription1);
  SetNothing(NominalCreated1);
  SetNothing(NominalDone1);
  SetNothing(NominalDueDate1);
  SetNothing(NominalFinished1);
  SetNothing(NominalSpent1);
  SetNothing(NominalStarted1);
  SetNothing(NominalSubject1);
  SetNothing(NominalUpdated1);
end;

procedure TIssue.Refresh(Silence: boolean);
var
  content: string;
  XML: TXMLDocument;
begin
  if Number <> 0 then
  begin
    content := Redmine.GetContent(Redmine.Site + '/issues/' + IntToStr(Number) + '.xml?include=journal');
    LoadXMLContent(XML, content);
    Update(XML.FindNode('issue'));
    XML.Free;
  end;
  if Assigned(Parent) then
    Parent.Refresh(Silence);
end;

function TIssue.AddChild(ANumber: Integer): TIssue;
begin
  Result := TIssue.Create(Self, ANumber);
  Result.Tracker1 := Tracker;
  Redmine.Issues.Add(Childs.Add(Result));
end;



procedure TIssue.Save;
var
  Post: TIdMultiPartFormDataStream;
  Content, authenticity_token, st, x: string;
  RC: TRedmineClient;
  ReqURL1, ReqURL2: string;
  ar: TStringArray;
  XML: TXMLDocument;
  Node1, Node2: TDOMNode;
  S: TStringStream;
begin
  RC := Redmine;
  RC.SetBusy(True);
  S := TStringStream.Create('');
  try
    XML := TXMLDocument.Create;

    Redmine.HTTP.Request.ContentType := 'text/xml';
    Node1 := XML.CreateElement('issue');

    Node1.AppendChild(CreateNode(XML, 'project_id', IntToStr(Project.Id)));
    Node1.AppendChild(CreateNode(XML, 'tracker_id', IntToStr(Tracker.Id)));
    Node1.AppendChild(CreateNode(XML, 'status_id', IntToStr(Status.ID)));
    Node1.AppendChild(CreateNode(XML, 'subject', Utf8ToAnsi(Subject)));
    Node1.AppendChild(CreateNode(XML, 'priority_id', IntToStr(Priority.ID)));
    Node1.AppendChild(CreateNode(XML, 'done_ratio', IntToStr(round(Done))));
    Node1.AppendChild(CreateNode(XML, 'description', Utf8ToAnsi(Description)));
    Node1.AppendChild(CreateNode(XML, 'notes', Utf8ToAnsi(Note1)));
    Node1.AppendChild(CreateNode(XML, 'notes', Utf8ToAnsi(Note1)));
    if (Started = 0) then
    begin
      raise Exception.Create('Invalid started date');
      exit;
    end;
    Node1.AppendChild(CreateNode(XML, 'start_date', FormatDateTime('yyyy-mm-dd', Started)));
    if (DueDate > Started) then
      Node1.AppendChild(CreateNode(XML, 'due_date', FormatDateTime('yyyy-mm-dd', DueDate)));

    if Assigned(Parent) then
      Node1.AppendChild(CreateNode(XML, 'parent_issue_id', IntToStr(Parent.Number)))
    else
      Node1.AppendChild(CreateNode(XML, 'parent_issue_id', ''));

    if Assigned(Category) then
      Node1.AppendChild(CreateNode(XML, 'category_id', IntToStr(Category.ID)))
    else
      Node1.AppendChild(CreateNode(XML, 'category_id', ''));

    if Assigned(Version) then
      Node1.AppendChild(CreateNode(XML, 'fixed_version_id', IntToStr(Version.ID)))
    else
      Node1.AppendChild(CreateNode(XML, 'fixed_version_id', ''));

    if Assigned(Assignee) then
      Node1.AppendChild(CreateNode(XML, 'assigned_to_id', IntToStr(Assignee.ID)))
    else
      Node1.AppendChild(CreateNode(XML, 'assigned_to_id', ''));

    XML.Appendchild(Node1);


    {$IFDEF DEBUG}
    WriteXMLFile(XML, 'c:/test.xml');
    {$ENDIF}


    WriteXML(XML, S);
    Content := S.DataString;
    {$IFNDEF DEBUG}
    if Number = 0 then
    begin
      content := Redmine.PostContent(Redmine.Site + '/issues.xml', S);
      LoadXMLContent(XML, Content);
      Update(XML.FindNode('issue'));
    end
    else
    begin
      content := Redmine.PutContent(URL + '.xml', S);
    end;
    {$ENDIF}
    Cancel;
    XML.Free;
    Redmine.HTTP.Request.ContentType := 'text/html';
  except
    on e: Exception do
      st := E.Message;
  end;

  Note1 := '';
  RC.UnSetBusy(True);

  S.Free;
  Refresh();
  if Assigned(RC.OnSaveIssue) then
    RC.OnSaveIssue(RC, self, True);

end;

procedure TIssue.Update(XMLNode1: TDOMNode);
var
  AParentIssue1: TIssue;
  ASubject1: string;
  AAutorId1: Integer;
  AAssigneeId1: Integer;
  AUpdatedStr1: string;
  ACatecoryId1: Integer;
  AVersionId1: Integer;
  AStarted1: string;
  ADueDateStr1: string;
  ACreatedStr1: string;
  ASpentStr1: string;
  ADoneStr1: string;
  ADescription1: string;
  AEvaluationTime1: string;
  AClosed1: string;
  ADueDate1: Integer;
  APriorityId1: Integer;
  AStatusId1: Integer;
  AParentId1: Integer;
  AProjectId1: Integer;
  ATrackerId1: Integer;
  ARole1: TUserRole;
  AIndex1: Integer;
  AUser1: TRedmineUser;
begin
  if Number1 = 0 then
    Number1 := StrToInt(XMLNode1.FindNode('id').TextContent);
  if Number1 = 522 then
    Number1 := Number1;
  ASubject1 := XMLNode1.FindNode('subject').TextContent;
  AAutorId1 := StrToInt(XMLNode1.FindNode('author').Attributes.GetNamedItem('id').NodeValue);
  if Assigned(XMLNode1.FindNode('assigned_to')) then
    AAssigneeId1 := StrToInt(XMLNode1.FindNode('assigned_to').Attributes.GetNamedItem('id').NodeValue)
  else
    AAssigneeId1 := 0;
  AUpdatedStr1 := XMLNode1.FindNode('updated_on').TextContent;
  if Assigned(XMLNode1.FindNode('category')) then
    ACatecoryId1 := StrToInt(XMLNode1.FindNode('category').Attributes.GetNamedItem('id').NodeValue)
  else
    ACatecoryId1 := 0;

  if Assigned(XMLNode1.FindNode('fixed_version')) then
    AVersionId1 := StrToInt(XMLNode1.FindNode('fixed_version').Attributes.GetNamedItem('id').NodeValue)
  else
    AVersionId1 := 0;

  if Assigned(XMLNode1.FindNode('parent')) then
    AParentId1 := StrToInt(XMLNode1.FindNode('parent').Attributes.GetNamedItem('id').NodeValue)
  else
    AParentId1 := 0;

  ATrackerId1 := StrToInt(XMLNode1.FindNode('tracker').Attributes.GetNamedItem('id').NodeValue);
  AProjectId1 := StrToInt(XMLNode1.FindNode('project').Attributes.GetNamedItem('id').NodeValue);
  AStarted1 := XMLNode1.FindNode('start_date').TextContent;
  ADueDateStr1 := XMLNode1.FindNode('due_date').TextContent;
  if Assigned(XMLNode1.FindNode('spent_hours')) then
    ASpentStr1 := XMLNode1.FindNode('spent_hours').TextContent;
  ADoneStr1 := XMLNode1.FindNode('done_ratio').TextContent;
  ACreatedStr1 := XMLNode1.FindNode('created_on').TextContent;
  ADescription1 := XMLNode1.FindNode('description').TextContent;
  if Assigned(XMLNode1.FindNode('estimated_hours')) then
    AEvaluationTime1 := XMLNode1.FindNode('estimated_hours').TextContent;
  if Assigned(XMLNode1.FindNode('closed_on')) then
    AClosed1 := XMLNode1.FindNode('closed_on').TextContent;
  Closed1 := StrToDateTimeCustom(AClosed1);
  APriorityId1 := StrToInt(XMLNode1.FindNode('priority').Attributes.GetNamedItem('id').NodeValue);
  AStatusId1 := StrToInt(XMLNode1.FindNode('status').Attributes.GetNamedItem('id').NodeValue);

  Project1 := Redmine.Projects.GetItemBy(AProjectId1);
  if AParentId1 > 0 then
  begin
    AParentIssue1 := Redmine.Issues.GetItemBy(AParentId1);
    if not Assigned(AParentIssue1) then
    begin
      //AParentIssue1 := Redmine.Issues.Add(TIssue.Create(self, AParentId1));
      //AParentIssue1.Refresh(True);
    end
    else
    begin
      AParentIssue1.Childs.Add(self);
      Parent1 := AParentIssue1;
    end;
  end;

  Tracker1 := Project1.Trackers.GetItemBy(ATrackerId1);

  if Assigned(Tracker1) then
  begin
    if Tracker1.Issues.GetItemIndex(self) = -1 then
      Tracker1.Issues.Add(self);
  end
  else
    Status1 := Status1;

  Status1 := Redmine.Statuses.GetItemBy(AStatusId1);
  Priority1 := Redmine.Prioritys.GetItemBy(APriorityId1);
  Subject1 := ASubject1;
  Autor1 := Project.Users.GetItemBy(AAutorId1);
  Assignee1 := Project.Users.GetItemBy(AAssigneeId1);
  Updated1 := StrToDateTimeCustom(AUpdatedStr1);
  Category1 := Project.Categorys.GetItemBy(ACatecoryId1);
  Version1 := Project.Versions.GetItemBy(AVersionId1);
  Started1 := StrToDateTimeCustom(AStarted1);
  Spent1 := StrToFloatCustom(ASpentStr1);
  Done1 := StrToFloatCustom(ADoneStr1);
  EvaluationTime := StrToFloatCustom(AEvaluationTime1);
  Created1 := StrToDateTimeCustom(ACreatedStr1);
  Description1 := ADescription1;
  DueDate1 := StrToDateTimeCustom(ADueDateStr1);
  AIndex1 := Redmine.Users.GetItemIndex(Redmine.CurrentUser);
  //ARole1 := Project1.Users.Roles[AIndex1].Item[0];

  //if not Redmine.Tracking.Storaged(ARole1, Status1, Redmine.CurrentUser) then
  //  Redmine.ParseIssueTracking(self);

  ParseComments(XMLNode1);
  Cancel;
  if Assigned(Redmine.FOnUpdateIssue) then
    Redmine.FOnUpdateIssue(Redmine, Self);
end;

constructor TIssue.Create(AOwner: TObject; ANumber: Integer);
begin
  Cancel;
  Number1 := ANumber;
  Childs1 := TIssues.Create(self);
  Owner1 := AOwner;
  Project1 := nil;
  Tracker1 := nil;
  if Owner1 is TTracker then
  begin
    Project1 := (Owner1 as TTracker).Owner;
    Tracker1 := Owner1 as TTracker;
  end
  else if Owner1 is TIssue then
  begin
    Parent1 := AOwner as TIssue;
    Project1 := (AOwner as TIssue).Project;
    Tracker1 := (AOwner as TIssue).Tracker;
  end;

  Priority1 := Redmine.GetDefaultPriority;
  Status1 := Redmine.GetDefaultStatus;

end;

destructor TIssue.Destroy;
begin
  Childs1.Free;
end;

