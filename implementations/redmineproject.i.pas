{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}

{ TRedmineProject }

procedure TRedmineProject.RefreshTrackers;
var
  Content: string;
  XML: TXMLDocument;
  Node1: TDOMNode;
  i, AID1: Integer;
begin
  Content := Redmine.GetContent(URL + '.xml?include=trackers');
  LoadXMLContent(XML, Content);
  Node1 := XML.FindNode('project').FindNode('trackers');
  for i := 0 to Node1.ChildNodes.Count - 1 do
  begin
    AID1 := StrToInt(Node1.ChildNodes[i].Attributes.GetNamedItem('id').NodeValue);
    Trackers.GetItemBy(AID1).Active1 := True;
  end;
  XML.Free;
end;

procedure TRedmineProject.RefreshMemberships;
var
  Content, AName1: string;
  XML: TXMLDocument;
  Node1, Node2: TDOMNode;
  i, j, AID1, AIndex1: Integer;
  User1: TRedmineUser;
begin
  if (Redmine.CheckPermission(self, [MANAGE_MEMBERS])) then
  begin
    try
      Content := Redmine.GetContent(URL + '/memberships.xml');
      LoadXMLContent(XML, Content);
      Node1 := XML.FindNode('memberships');
      for i := 0 to Node1.ChildNodes.Count - 1 do
      begin
        Node2 := Node1.ChildNodes.Item[i].FindNode('user');
        AName1 := Node2.Attributes.GetNamedItem('name').NodeValue;
        AID1 := StrToInt(Node2.Attributes.GetNamedItem('id').NodeValue);
        User1 := AddUser(AName1, AID1);
        AIndex1 := Users.GetItemIndex(User1);
        Node2 := Node1.ChildNodes.Item[i].FindNode('roles');
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          AID1 := StrToInt(Node2.ChildNodes.Item[j].Attributes.GetNamedItem('id').NodeValue);
          Roles[User1].Add(Redmine.Roles.GetItemBy(AID1));
        end;
      end;
      XML.Free;
    except
    end;
  end
  else
  begin
    ParseMembershipsHTML(self);
  end;
end;

procedure TRedmineProject.RefreshVersions;
var
  Content, AName1: string;
  XML: TXMLDocument;
  Node1: TDOMNode;
  i, AID1: Integer;
  Version1: TProjectVersion;
begin
  if not Redmine.CheckPermission(self, [MANAGE_VERSIONS]) then
    exit;
  Content := Redmine.GetContent(URL + '/versions.xml');
  LoadXMLContent(XML, Content);
  Node1 := XML.FindNode('versions');
  for i := 0 to Node1.ChildNodes.Count - 1 do
  begin
    AName1 := Node1.ChildNodes[i].FindNode('name').TextContent;
    AID1 := StrToInt(Node1.ChildNodes[i].FindNode('id').TextContent);
    Version1 := TProjectVersion.Create(AName1, AID1);
    Version1.Description1 := Node1.ChildNodes[i].FindNode('description').TextContent;
    Version1.Status1 := Node1.ChildNodes[i].FindNode('status').TextContent;
    Version1.DueDate1 := StrToDateTimeCustom(Node1.ChildNodes[i].FindNode('due_date').TextContent);
    Version1.Created1 := StrToDateTimeCustom(Node1.ChildNodes[i].FindNode('created_on').TextContent);
    Version1.Updated1 := StrToDateTimeCustom(Node1.ChildNodes[i].FindNode('updated_on').TextContent);
    Versions.Add(Version1);
  end;
  XML.Free;
end;

procedure TRedmineProject.RefreshCategories;
var
  Content, AName1: string;
  XML: TXMLDocument;
  Node1: TDOMNode;
  i, AID1: Integer;
  Category1: TIssueCategory;
begin
  if not Redmine.CheckPermission(self, [MANAGE_CATEGORIES]) then
    exit;

  Content := Redmine.GetContent(URL + '/issue_categories.xml');
  LoadXMLContent(XML, Content);
  Node1 := XML.FindNode('issue_categories');
  for i := 0 to Node1.ChildNodes.Count - 1 do
  begin
    AName1 := Node1.ChildNodes.Item[i].FindNode('name').TextContent;
    AID1 := StrToInt(Node1.ChildNodes.Item[i].FindNode('id').TextContent);
    Category1 := TIssueCategory.Create(AName1, AID1);
    if assigned(Node1.ChildNodes.Item[i].FindNode('assigned_to')) then
    begin
      AID1 := StrToInt(Node1.ChildNodes.Item[i].FindNode('assigned_to').Attributes.GetNamedItem('id').NodeValue);
      Category1.Assigned := Users.GetItemBy(AID1);
    end;
    Categorys.Add(Category1);
  end;
  XML.Free;
end;

procedure TRedmineProject.RefreshIssues;
begin
  Redmine.FillIssues(id);
end;

procedure TRedmineProject.Refresh;
begin
  Redmine.FillProjects(id);
end;

destructor TRedmineProject.Destroy;
begin
  Trackers1.Free;
  SubProjects1.Free;
  Categorys1.Free;
  Versions1.Free;
  Users1.Free;
end;

procedure TRedmineProject.Update(XMLNode1: TDOMNode);
var
  TrackerId1: string;
  Tracker1, TrackerTmp: TTracker;
begin
  //TrackerId1 := StrToInt(XMLNode1.FindNode('tracker').Attributes.GetNamedItem('id').NodeValue);
  //Tracker1 := Redmine(TrackerName1);
  //if not Assigned(Tracker1) then
  //begin
  //  TrackerTmp := Redmine.GetTrackerBy(TrackerName1);
  //  Tracker1 := AddTracker(TrackerTmp.Name, TrackerTmp.Id);
  //end;
  //Tracker1.Update(XMLNode1);
end;

procedure TRedmineProject.Update(CSV: TCSV; Row: Integer);
var
  TrackerName1: string;
  Tracker1, TrackerTmp: TTracker;
begin
  //TrackerName1 := CSV.GetValueByField(Row, 'Трекер');
  //Tracker1 := GetTrackerByName(TrackerName1);
  //if not Assigned(Tracker1) then
  //begin
  //  TrackerTmp := Redmine.GetTrackerBy(TrackerName1);
  //  Tracker1 := AddTracker(TrackerTmp.Name, TrackerTmp.Id);
  //end;
  //Tracker1.Update(CSV, Row);
end;

procedure TRedmineProject.Save;
var
  Post: TIdMultiPartFormDataStream;
  Content, authenticity_token, Buf1: string;
  RC: TRedmineClient;
  ReqURL1, ReqURL2: string;
  i: Integer;
  XML: TXMLDocument;
  Node1, Node2, Node3: TDOMNode;
  Attr: TDOMAttr;
  Tracker1: TTracker;
  S: TStringStream;
begin
  RC := Redmine;
  RC.SetBusy(True);
  try
    XML := TXMLDocument.Create;

    Redmine.HTTP.Request.ContentType := 'text/xml';
    Node1 := XML.CreateElement('project');

    Node2 := XML.CreateElement('description');
    Node2.TextContent := Utf8ToAnsi(Description);
    Node1.AppendChild(Node2);

    Node2 := XML.CreateElement('name');
    Node2.TextContent := Utf8ToAnsi(Name);
    Node1.AppendChild(Node2);

    Node2 := XML.CreateElement('homepage');
    Node2.TextContent := Utf8ToAnsi(Homepage);
    Node1.AppendChild(Node2);

    Node2 := XML.CreateElement('is_public');
    Node2.TextContent := BoolToStr(IsPublic, '1', '0');
    Node1.AppendChild(Node2);

    //Node2 := XML.CreateElement('enabled_module_names');
    ////TDOMElement(Node2).SetAttribute('value', 'news');
    ////Attr := XML.CreateAttribute('name');
    ////Attr.NodeValue := 'news';

    //Node3 := XML.CreateElement('issue_tracking');
    ////Node2.TextContent := '[issue_tracking, news]';
    //Node2.AppendChild(Node3);
    //Node1.AppendChild(Node2);

    for i := 0 to Trackers.Count - 1 do
    begin
      Tracker1 := Trackers.Item[i];
      if (Tracker1.Active) then
      begin
        Node2 := XML.CreateElement('tracker_ids');
        Node2.TextContent := IntToStr(Tracker1.Id);
        Node1.AppendChild(Node2);
      end;
    end;

    XML.Appendchild(Node1);
    S := TStringStream.Create('');
    WriteXMLFile(XML, 'c:/test.xml');
    WriteXML(XML, S);
    Content := S.DataString;

    content := Redmine.PutContent(Redmine.Site + '/projects/' + IntToStr(id) + '.xml', S);
    LoadXMLContent(XML, Content);
    Redmine.HTTP.Request.ContentType := 'text/html';
  except
  end;

  RC.UnSetBusy(True);

end;

procedure TRedmineProject.Cancel;
begin
  isChanged1 := False;
end;

constructor TRedmineProject.Create(AOwner: TObject);
begin
  Trackers1 := TTrackers.Create(self);
  SubProjects1 := TProjects.Create(self);
  Versions1 := TVersions.Create(self);
  Categorys1 := TCategorys.Create(self);
  Users1 := TUsers.Create(self);
  Owner1 := AOwner;
end;

procedure TRedmineProject.LoadCategorys;
var
  Content: string;
  i: Integer;
  XML: TXMLDocument;
  Node1: TDOMNode;
begin
  //Content := Redmine.GetContent(URL + '/issue_categories.xml');
  //LoadXMLContent(XML, Content);
  //setLength(CategorysOptions1, 0);
  //setLength(CategorysOptions1, XML.FindNode('issue_categories').ChildNodes.Count);
  //for i := 0 to XML.FindNode('issue_categories').ChildNodes.Count - 1 do
  //begin
  //  Node1 := XML.FindNode('issue_categories').ChildNodes.Item[i];
  //  CategorysOptions1[i].Name := Node1.FindNode('name').TextContent;
  //  CategorysOptions1[i].Value := StrToInt(Node1.FindNode('id').TextContent);
  //end;
  //XML.Free;
end;

function TRedmineProject.AddSubProject: TRedmineProject;
begin
  SubProjects1.Add(Redmine.Projects.Add(TRedmineProject.Create(Self)));
end;

function TRedmineProject.GetSubTracker(index: Integer): TRedmineProject;
begin

end;

function TRedmineProject.GetCountModules: Integer;
begin
  Result := Length(Modules1);
end;

function TRedmineProject.GetDescription: string;
begin
  Result := NominalDescription1;
end;

function TRedmineProject.GetisChanged: boolean;
begin
  Result := isChanged1 or isChangedModules1;
end;

function TRedmineProject.GetModules(index: Integer): TRCModuleRec;
begin
  Result := Modules1[index];
end;

function TRedmineProject.GetParent: TRedmineProject;
begin
  if Owner1 is TRedmineProject then
    Result := Owner1 as TRedmineProject
  else
    Result := nil;
end;

function TRedmineProject.GetRedmine: TRedmineClient;
begin
  if Owner is TRedmineClient then
    Result := Owner as TRedmineClient
  else if Owner is TRedmineProject then
    Result := (Owner as TRedmineProject).Redmine;
end;

function TRedmineProject.GetRoles(User: TRedmineUser): TRoles;
var
  Index1: Integer;
begin
  Result := nil;
  Index1 := Users.GetItemIndex(User);
  if Index1 >= 0 then
  begin
    if Index1 >= length(Roles1) then
      SetLength(Roles1, Index1 + 1);
    if not Assigned(Roles1[Index1]) then
      Roles1[Index1] := TRoles.Create(self);
    Result := Roles1[Index1];
  end;
end;

//function TRedmineProject.GetStatus(index: integer): TIssueStatus;
//begin
//  Result := Redmine.Statuses1[index];
//end;

//function TRedmineProject.GetSubProject(index: integer): TRedmineProject;
//begin
//  Result := SubProjects1[index];
//end;

//function TRedmineProject.GetTracker(index: integer): TTracker;
//begin
//  Result := Trackers1[index];
//end;

function TRedmineProject.GetURL: string;
begin
  Result := Redmine.Site + '/projects/' + Identifier;
end;

//function TRedmineProject.GetUser(index: integer): TRedmineUser;
//begin
//  Result := Users1[index];
//end;

procedure TRedmineProject.SaveModules;
var
  Post: TIdMultiPartFormDataStream;
  i: Integer;
  SS: TStringStream;
  s: string;
begin
  Post := Redmine.PreparePost(True);
  for i := 0 to CountModules - 1 do
    if Modules[i].Enabled then
      Post.AddFormField('enabled_module_names[]', Modules[i].ID);
  Redmine.PostContent(URL + '/modules', Post);
  isChangedModules1 := False;
  //Post.Free;
end;

procedure TRedmineProject.SetDescription(AValue: string);
begin
  if Description1 = AValue then
    Exit;
  NominalDescription1 := AValue;
  isChanged1 := True;
end;

procedure TRedmineProject.SetIdentifier(AValue: string);
begin
  if (Identifier = '') and (NominalIdentifier1 <> AValue) then
  begin
    NominalIdentifier1 := AValue;
    isChanged1 := True;
  end;
end;

procedure TRedmineProject.SetIsPublic(AValue: boolean);
begin
  if IsPublic1 = AValue then
    Exit;
  IsPublic1 := AValue;
end;

procedure TRedmineProject.SetModule(ID: string; Value: boolean);
var
  i: Integer;
begin
  for i := 0 to CountModules - 1 do
    if (Modules[i].ID = ID) and (Modules[i].Enabled <> Value) then
    begin
      Modules1[i].Enabled := Value;
      isChangedModules1 := True;
    end;
end;

function TRedmineProject.AddUser(AName: string; AID: Integer): TRedmineUser;
var
  User1: TRedmineUser;
begin
  User1 := Redmine.Users.GetItemBy(AID);
  if not assigned(User1) then
    User1 := Redmine.Users.Add(TRedmineUser.Create(AName, AID));
  Result := Users.Add(User1);
end;

procedure TRedmineProject.SetOwner(AValue: TObject);
begin
  if (NominalOwner1 <> AValue) then
  begin
    NominalOwner1 := AValue;
    isChanged1 := True;
  end;
end;

procedure TRedmineProject.SetPage(AValue: string);
begin
  if Page1 = AValue then
    Exit;
  Page1 := AValue;
end;

procedure TRedmineProject.SetParent(AValue: TRedmineProject);
begin

end;

{ TProjects }

function TProjects.GetItem(index: Integer): TRedmineProject;
begin
  Result := inherited GetItem(index) as TRedmineProject;
end;

function TProjects.Add(AObject: TRedmineProject): TRedmineProject;
begin
  Result := inherited Add(AObject) as TRedmineProject;
end;

function TProjects.GetItemBy(AID: Integer): TRedmineProject;
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