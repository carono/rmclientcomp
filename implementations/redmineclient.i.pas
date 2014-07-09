{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}

{ TRedmineClient }

function TRedmineClient.GetBusy: boolean;
begin
  Result := ForcedBusy1 or Busy1;
end;

function TRedmineClient.ExtractContent(Url: string; AMethod: TContentMethod; Data: TObject): string;
begin
  try
    if not assigned(Data) then
      ContentThread1 := TContentThread.Create(Self, Url, AMethod)
    else if Data is TStream then
      ContentThread1 := TContentThread.Create(Self, Url, AMethod, Data as TStream)
    else
      ContentThread1 := TContentThread.Create(Self, Url, AMethod, Data as TStrings);
    while Busy1 do
    begin
      Application.ProcessMessages();
      Sleep(10);
    end;
    Result := RedmineAnswer;
  except
    on E: Exception do
      Result := E.Message;
  end;
  if (HTTP.ResponseCode = 302) and (pos('login?', Result) > 0) and (pos('/my/page', Url) = 0) then
  begin
    Login(False, True, True);
    Result := ExtractContent(Url, AMethod, Data);
  end;
end;

function TRedmineClient.GetContent(Url: string): string;
begin
  Result := ExtractContent(Url, TMGet);
end;

function TRedmineClient.GetLoginned: boolean;
begin
  Result := Loginned1;
end;

function TRedmineClient.GetLoginnedHTML: boolean;
begin
  Result := LoginnedHTML1;
end;

function TRedmineClient.GetNews: TNews;
begin

end;

function TRedmineClient.GetPermission: TRedminePermissions;
var
  Content: string;
begin
  Content := GetContent(site + '/projects/new');
  if pos('name="commit"', Content) > 0 then
    Result := Result + [rcEdit];
end;

function TRedmineClient.PostContent(Url: string; Post: TObject): string;
begin
  Result := ExtractContent(Url, TMPost, Post);
end;

function TRedmineClient.PutContent(Url: string; Post: TStream): string;
begin
  Result := ExtractContent(Url, TMPut, Post);
end;

function TRedmineClient.DeleteContent(Url: string; Post: TStream): string;
begin
  Result := ExtractContent(Url, TMDelete, Post);
end;

function TRedmineClient.GetIssue(number: Integer): TIssue;
var
  i, j, t: Integer;
begin
  //for i := 0 to length(Projects1) - 1 do
  //  for t := 0 to Length(Projects1[i]^.Trackers) - 1 do
  //    for j := 0 to Length(Projects1[i]^.Trackers[t]^.Issues) - 1 do
  //      if Projects1[i]^.Trackers[t]^.Issues[j]^.Number = number then
  //      begin
  //        Result := Projects1[i]^.Trackers[t]^.Issues[j];
  //        break;
  //      end;
end;

function TRedmineClient.GetLanguages(index: Integer): TLang;
begin
  if index < Length(Languages1) then
    Result := Languages1[index]
  else
  begin
    Result.Name := '';
    Result.Value := '';
  end;
end;

function TRedmineClient.GetNotice(index: Integer): TLang;
begin
  if index < Length(Notice1) then
    Result := Notice1[index]
  else
  begin
    Result.Name := '';
    Result.Value := '';
  end;
end;

procedure TRedmineClient.GetProfile;
var
  Content, UserLogin1, firstname1, mail1, lastname1, RoleName1: string;
  RoleId1, UserId1, i, j, x: Integer;
  Select1: TSelects;
  XML: TXMLDocument;
  Node1, MembershipsNode1, ProjectNode1, MembershipNode1, RolesNode1, RoleNode1: TDOMNode;
  Project1: TRedmineProject;
  Role1: TUserRole;
  AIndex1: Integer;
begin
  try
    if not Anonym then
    begin
      Content := GetContent(Site + '/users/current.xml?include=memberships');
      LoadXMLContent(XML, Content);
      Node1 := XML.FindNode('user');
      firstname1 := Node1.FindNode('firstname').TextContent;
      lastname1 := Node1.FindNode('lastname').TextContent;
      UserId1 := StrToInt(Node1.FindNode('id').TextContent);
      UserLogin1 := Node1.FindNode('login').TextContent;
      CurrentUser1 := Users.Add(TRedmineUser.Create(firstname1 + ' ' + lastname1, UserId1));
      // Получаем список отнощений пользователя к проектам, для загрузки привилегий
      MembershipsNode1 := Node1.FindNode('memberships');
      for i := 0 to MembershipsNode1.ChildNodes.Count - 1 do
      begin
        MembershipNode1 := MembershipsNode1.ChildNodes.Item[i];
        ProjectNode1 := MembershipNode1.FindNode('project');
        Project1 := Projects.Add(TRedmineProject.Create(self));
        Project1.Id := StrToInt(ProjectNode1.Attributes.GetNamedItem('id').NodeValue);
        Project1.Name := ProjectNode1.Attributes.GetNamedItem('name').NodeValue;
        Project1.Users.Add(CurrentUser1);
        RolesNode1 := MembershipNode1.FindNode('roles');
        for j := 0 to RolesNode1.ChildNodes.Count - 1 do
        begin
          RoleNode1 := RolesNode1.ChildNodes.Item[j];
          RoleName1 := RoleNode1.Attributes.GetNamedItem('name').NodeValue;
          RoleId1 := StrToInt(RoleNode1.Attributes.GetNamedItem('id').NodeValue);
          Role1 := Roles.GetItemBy(RoleId1);
          if not Assigned(Role1) then
          begin
            Role1 := Roles.Add(TUserRole.Create(RoleName1, RoleId1));
            ReloadPermissions(Role1);
          end;
          Project1.Roles[CurrentUser1].Add(Role1);
        end;
      end;
    end
    else
    begin
      Roles.Add(TUserRole.Create('Anonumus', 0));
      CurrentUser1 := Users.Add(TRedmineUser.Create('Anonumus', 0));
    end;
  except
  end;
end;

function TRedmineClient.GetProgress: double;
begin
  Result := Progress1;
end;

//function TRedmineClient.GetProjects(index: integer): TRedmineProject;
//begin
//  Result := Projects1[index];
//end;

//function TRedmineClient.GetStatus(index: integer): TIssueStatus;
//begin
//  Result := Statuses1[index];
//end;

//function TRedmineClient.GetTracker(index: integer): TTracker;
//begin
//  Result := Trackers1[index];
//end;

//function TRedmineClient.GetTrackerBy(AID: integer): TTracker;
//var
//  i: integer;
//begin
//  Result := nil;
//  for i := 0 to CountTrackers - 1 do
//    if Trackers[i].Id = AID then
//    begin
//      Result := Trackers[i];
//      break;
//    end;
//end;

//function TRedmineClient.GetTrackerBy(AName: string): TTracker;
//var
//  i: integer;
//begin
//  Result := nil;
//  for i := 0 to CountTrackers - 1 do
//    if Trackers[i].Name = AName then
//    begin
//      Result := Trackers[i];
//      break;
//    end;
//end;

//function TRedmineClient.GetPriorityBy(AID: integer): TIssuePriority;
//var
//  i: integer;
//begin
//  Result := nil;
//  for i := 0 to CountPriority - 1 do
//    if Priority[i].Id = AID then
//    begin
//      Result := Priority[i];
//      break;
//    end;
//end;

//function TRedmineClient.GetPriorityBy(AName: string): TIssuePriority;
//var
//  i: integer;
//begin
//  Result := nil;
//  for i := 0 to CountPriority - 1 do
//    if Priority[i].Name = AName then
//    begin
//      Result := Priority[i];
//      break;
//    end;
//end;

//function TRedmineClient.GetStatusBy(AID: integer): TIssueStatus;
//var
//  i: integer;
//begin
//  Result := nil;
//  for i := 0 to CountStatuses - 1 do
//    if Statuses[i].ID = AID then
//    begin
//      Result := Statuses[i];
//      break;
//    end;
//end;

//function TRedmineClient.GetStatusBy(AName: string): TIssueStatus;
//var
//  i: integer;
//begin
//  Result := nil;
//  for i := 0 to CountStatuses - 1 do
//    if Statuses[i].Name = AName then
//    begin
//      Result := Statuses[i];
//      break;
//    end;
//end;

function TRedmineClient.GetDefaultPriority: TIssuePriority;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Prioritys.Count - 1 do
    if Prioritys.Item[i].isDefault then
    begin
      Result := Prioritys.Item[i];
      break;
    end;
end;

function TRedmineClient.GetDefaultStatus: TIssueStatus;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Statuses.Count - 1 do
    if Statuses.Item[i].isDefault then
    begin
      Result := Statuses.Item[i];
      break;
    end;
end;

//function TRedmineClient.GetUser(id: integer): TRedmineUser;
//var
//  i, j: integer;
//begin
//  for i := 0 to CountProjects - 1 do
//    for j := 0 to Projects[i].CountUsers - 1 do
//      if Projects[i].Users[j].id = id then
//      begin
//        Result := Projects[i].Users[j];
//        break;
//      end;
//end;

procedure TRedmineClient.SetSite(AValue: string);
begin
  if Pos('http://', AValue) <> 1 then
    site1 := 'http://' + AValue
  else
    site1 := AValue;
end;

procedure TRedmineClient.UpdateIssues(AProject: TRedmineProject);
begin

end;

procedure TRedmineClient.Init;
begin
  FNews := TNews.Create;
  //UserProfile1 := TUserProfile.Create;
  HTTP := TIdHTTP.Create(nil);
  HTTP.HTTPOptions := HTTP.HTTPOptions - [hoForceEncodeParams];
  //HTTP.CookieManager := TIdCookieManager.Create;
  HTTP.AllowCookies := True;
  //HTTP.ProxyParams.ProxyPort := 3128;
  //HTTP.ProxyParams.ProxyServer := '192.168.0.120';
  HTTP.Request.UserAgent :=
    'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.12 (KHTML, like Gecko) Maxthon/3.0 Chrome/18.0.966.0 Safari/535.12';
  HTTP.Request.Accept :=
    'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
  HTTP.Request.AcceptLanguage := 'ru-RU';
  HTTP.Request.AcceptCharSet := 'UTF-8,*;q=0.5';
  HTTP.RedirectMaximum := 1;
  HTTP.HandleRedirects := False;
  HTTP.ReadTimeout := 20000;
  HTTP.ConnectTimeout := 20000;

end;

procedure TRedmineClient.SetBusy(Force: boolean);
begin
  Busy1 := True;
  if Force then
    ForcedBusy1 := True;
  if Assigned(FOnStartBusy) and not Silence then
    FOnStartBusy(Self);
end;

procedure TRedmineClient.UnSetBusy(Force: boolean);
begin
  Busy1 := False;
  if Force then
    ForcedBusy1 := False;
  if Assigned(FOnEndBusy) and not Busy and not Silence then
    FOnEndBusy(Self);
end;

procedure TRedmineClient.UpdateProgres(Max: Integer; Current: Integer; ClearStoraged: boolean);
var
  r: double;
begin
  if Max <> -1 then
    ProgressMax := Max;
  if Current <> -1 then
    ProgressPosition := Current;
  if ProgressMax > 0 then
  begin
    r := (ProgressPosition / ProgressMax) * 100;
    if r <> Progress1 then
    begin
      Progress1 := r;
      if Assigned(FOnChangeProgress) then
        FOnChangeProgress(Self);
      if ProgressPosition = ProgressMax then
      begin
        ProgressMax := 0;
        ProgressPosition := 0;
        Progress1 := -1;
      end;
    end;
  end;
end;

function TRedmineClient.FillRoles: Integer;
var
  Content: string;
  Node1, Node2: TDOMNode;
  XML: TXMLDocument;
  i: Integer;
  Role1: TUserRole;
begin
  if Anonym then
    exit;

  Content := GetContent(site + '/roles.xml');
  LoadXMLContent(XML, Content);
  Node1 := XML.FindNode('roles');
  for i := 0 to Node1.ChildNodes.Count - 1 do
  begin
    Node2 := Node1.ChildNodes.Item[i];
    Role1 := TUserRole.Create(Node2.FindNode('name').TextContent, StrToInt(Node2.FindNode('id').TextContent));
    Roles1.Add(Role1);
  end;
end;

function TRedmineClient.FillProjects(id: Integer = 0): Integer;
var
  ProjectId1, ParentId1, i, j, k, x: Integer;
  XML: TXMLDocument;
  XML2: TXMLDocument;
  Node1, Node2, ProjectsNode1: TDOMNode;
  Project1, ParentProject1: TRedmineProject;
  li, Content, Name1, st1: string;
  Tr: TTracker;
  User1: TRedmineUser;
  Version1: TProjectVersion;
  Category1: TIssueCategory;
begin

  Result := 0;
  ChangeStatus('Парсинг проектов (XML)');
  if (id > 0) then
    Content := GetContent(site + '/projects/' + IntToStr(id) + '.xml')
  else
    Content := GetContent(site + '/projects.xml');
  LoadXMLContent(XML, Content);

  if Assigned(XML.FindNode('projects')) then
    ProjectsNode1 := XML.FindNode('projects')
  else
  begin
    ProjectsNode1 := XML.CreateElement('projects');
    ProjectsNode1.AppendChild(XML.FindNode('project'));
  end;

  for i := 0 to ProjectsNode1.ChildNodes.Count - 1 do
  begin
    UpdateProgres(ProjectsNode1.ChildNodes.Count, i + 1);
    Node1 := ProjectsNode1.ChildNodes.Item[i];
    ProjectId1 := StrToInt(Node1.FindNode('id').TextContent);
    if (ProjectId1 = 20) then
      ProjectId1 := ProjectId1;
    if Assigned(Node1.FindNode('parent')) then
    begin
      ParentId1 := StrToInt(Node1.FindNode('parent').Attributes.GetNamedItem('id').NodeValue);
      ParentProject1 := Projects.GetItemBy(ParentId1);
      if not Assigned(ParentProject1) then
      begin
        ParentProject1 := Projects.Add(TRedmineProject.Create(self));
        ParentProject1.Id1 := ParentId1;
      end;
      Project1 := Projects.GetItemBy(ProjectId1);
      if not Assigned(Project1) then
        Project1 := ParentProject1.AddSubProject();
      Project1.Owner1 := ParentProject1;
    end
    else
    begin
      Project1 := Projects.GetItemBy(ProjectId1);
      if not Assigned(Project1) then
        Project1 := Projects.Add(TRedmineProject.Create(self));
      Project1.Owner1 := self;
    end;
    Project1.Id1 := ProjectId1;
    Project1.Identifier1 := Node1.FindNode('identifier').TextContent;
    Project1.Name1 := Node1.FindNode('name').TextContent;
    Project1.Description1 := Node1.FindNode('description').TextContent;
    Project1.NominalDescription1 := Node1.FindNode('description').TextContent;
    Project1.Trackers.Assign(Trackers);
    for j := 0 to Project1.Trackers.Count - 1 do
      Project1.Trackers.Item[j].Owner1 := Project1;
    ChangeStatus('Парсинг проектов (XML) - ' + Project1.Name1);

    if Anonym then
      Project1.Roles[Project1.Users.Add(CurrentUser)].Add(Roles.GetItemBy(0));

    Project1.RefreshTrackers();
    Project1.RefreshMemberships();
    Project1.RefreshVersions();
    Project1.RefreshCategories();

    if Assigned(FOnUpdateProject) then
      FOnUpdateProject(self, Project1);
  end;
  XML.Free;
end;

//procedure TRedmineClient.UpdateIssue(number: integer);
//var
//  content, p: string;
//  x: integer;
//  Issue1: TPIssue;
//begin
//  content := GetContent(site + '/issues/' + IntToStr(number));
//  x := pos('<strong>Описание</strong>', content);
//  if x > 0 then
//    p := StripeTags(GetTextInTag(Copy(content, x, length(content)), 'div', 1))
//  else
//    p := 'Описание отсутствует';
//  Issue1 := Issue[number];
//  Issue1^.Parsed := True;
//  Issue1^.Description := p;
//  if Assigned(FOnUpdateIssue) then
//    FOnUpdateIssue(Self, Issue1^);
//end;

procedure TRedmineClient.Update;
var
  Content: string;
  id1: Integer;
begin
  if not Loginned then
    exit;
  {$IFDEF DEBUG}
  id1 := 18;
  {$ELSE}
  id1 := 0;
  {$ENDIF}
  SetBusy(True);
  HTMLCONTENT1 := '';
  FillRoles;
  FillTrackers;
  FillProjects(18);
  FillPriority;
  //FillUsers;
  FillStatuses;
  FillIssues(18);
  UpdateNews();
  UpdateProgres(1, 1);
  UnSetBusy(True);
end;

//function TRedmineClient.GetProjectByName(AName: string): TRedmineProject;
//var
//  i: integer;
//begin
//  Result := GetProjectByNameRecursive(AName);
//end;

procedure TRedmineClient.UpdateNews(Offset: Integer);
var
  i, j, count1: Integer;
  s, content: string;
  XML: TXMLDocument;
  Node1: TDOMNode;
  NewsItem: TNewsitem;

begin
  Content := GetContent(site + '/news.xml?offset=' + IntToStr(Offset));
  if pos('<?xml', Content) <> 0 then
  begin
    LoadXMLContent(XML, Content);
    //count1 := StrToInt(XML.FindNode('news').Attributes.GetNamedItem('total_count').NodeValue);
    Node1 := XML.FindNode('news');
    count1 := Node1.ChildNodes.Count;
    for i := 0 to count1 - 1 do
    begin
      NewsItem := TNewsitem.Create;
      NewsItem.Description1 := Node1.ChildNodes[i].FindNode('description').TextContent;
      NewsItem.Subject1 := Node1.ChildNodes[i].FindNode('title').TextContent;
      NewsItem.ID1 := StrToInt(Node1.ChildNodes[i].FindNode('id').TextContent);
      NewsItem.Summary1 := Node1.ChildNodes[i].FindNode('summary').TextContent;
      //s:=Node1.ChildNodes[i].FindNode('author').Attributes.GetNamedItem('id').NodeValue;
      NewsItem.Autor1 := Users.GetItemBy(StrToInt(Node1.ChildNodes[i].FindNode('author').Attributes.GetNamedItem(
        'id').NodeValue));
      FNews.AddNews(NewsItem);
    end;
  end;
  if Assigned(FOnUpdateNews) then
    FOnUpdateNews(self);
end;

procedure TRedmineClient.SaveIssue(index: Integer);
//var
//Issue1: TPIssue;
//Post: TIdMultiPartFormDataStream;
//Content: string;
begin
  //Issue1 := Issue[index];
  //if assigned(Issue1) then
  //begin
  //  SetBusy(True);
  //  HTTP.AllowCookies := False;
  //  Content := GetContent(site + '/issues/' + IntToStr(Issue1^.Number));
  //  Post := TIdMultiPartFormDataStream.Create;
  //  authenticity_token := GetTagParam(GetTag(Content, 'input', 5), 'value');
  //  HTTP.Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
  //  HTTP.Request.AcceptEncoding := 'gzip,deflate';
  //  HTTP.Request.CacheControl := 'max-age=0';
  //  Post.AddFormField('utf8', '✓');
  //  Post.AddFormField('_method', 'put');
  //  Post.AddFormField('authenticity_token', authenticity_token);
  //  //Post.AddFormField('issue[tracker_id]','2');
  //  Post.AddFormField('issue[subject]', Issue1^.Subject);
  //  Post.AddFormField('issue[description]', Issue1^.Description);
  //  //Post.AddFormField('issue[status_id]','1');
  //  //Post.AddFormField('issue[priority_id]','4');
  //  //Post.AddFormField('issue[assigned_to_id]','6');
  //  //Post.AddFormField('issue[parent_issue_id]','');
  //  //Post.AddFormField('issue[start_date]','2013-04-22');
  //  //Post.AddFormField('issue[due_date]','');
  //  //Post.AddFormField('issue[estimated_hours]','');
  //  //Post.AddFormField('issue[done_ratio]','0');
  //  //Post.AddFormField('time_entry[hours]','');
  //  //Post.AddFormField('time_entry[activity_id]','');
  //  //Post.AddFormField('time_entry[comments]','');
  //  //Post.AddFormField('notes','');
  //  //Post.AddFormField('attachments[1][file]','');
  //  //Post.AddFormField('attachments[1][description]','');
  //  Post.AddFormField('issue[lock_version]', GetTagParam(GetTag(Content, 'input', 21), 'value'));
  //  Post.AddFormField('last_journal_id', GetTagParam(GetTag(Content, 'input', 22), 'value'));
  //  Post.AddFormField('commit', 'Принять');
  //  GetPostContent(site + '/issues/' + IntToStr(Issue1^.Number), Post);
  //  UnSetBusy(True);

  //  if Assigned(FOnSaveIssue) then
  //    FOnSaveIssue(Self, Issue1, True);
  //end;
end;

//function TRedmineClient.AddProject: TRedmineProject;
//begin
//  SetLength(Projects1, CountProjects + 1);
//  Projects1[CountProjects - 1] := TRedmineProject.Create(self);
//  Result := Projects1[CountProjects - 1];
//end;

function TRedmineClient.Login(AAnonym: boolean; AsHtml: boolean; ASilence: boolean = False): boolean;
var
  Post1: TStringList;
  Content, Token1, Auth1: string;
  p: Integer;
begin
  SetBusy(not ASilence);
  Loginned1 := False;
  UpdateProgres(4, 0);
  ChangeStatus('Подключаемся к сайту');
  if AAnonym then
  begin
    Loginned1 := True;
    Anonym1 := True;
  end
  else
  begin
    if AsHtml then
    begin
      Auth1 := HTTP.Request.CustomHeaders.Values['Authorization'];
      HTTP.Request.CustomHeaders.Values['Authorization'] := '';
      HTTP.Request.CustomHeaders.Values['Cookie'] := '';
      Post1 := TStringList.Create;
      Post1.Add('utf8=?');
      Post1.Add('authenticity_token=' + GetToken(True));
      Post1.Add('username=' + Username);
      Post1.Add('password=' + Password);

      Content := PostContent(Site + '/login', Post1);
      if HTTP.ResponseCode = 302 then
      begin
        if Auth1 <> '' then
          HTTP.Request.CustomHeaders.Values['Authorization'] := Auth1;
        LoginnedHTML1 := True;
      end
      else
      begin
        LoginnedHTML1 := False;
        exit;
      end;
      Post1.Free;
    end
    else
    begin
      HTTP.Request.CustomHeaders.Add('Authorization: Basic ' + EncodeStringBase64(Username + ':' + Password));
      //HTTP.Request.CustomHeaders.Add('X-Redmine-API-Key: fc47105c62ec791a3f93e561d15943748ceb11dc');
      ChangeStatus('Авторизируемся как "' + Username + '"');
      Content := GetContent(Site + '/my/page');
      if HTTP.ResponseCode = 302 then
      begin
        Loginned1 := True;
      end
      else
        Loginned1 := False;
      UpdateProgres(4, 2);
    end;
  end;
  UpdateProgres(4, 4);
  Result := Loginned1 or LoginnedHTML1;
  UnSetBusy(not ASilence);
  AOnLogin();
end;

constructor TRedmineClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tracking1 := TTracking.Create;
  Statuses1 := TStatuses.Create(self);
  Prioritys1 := TPrioritys.Create(self);
  Trackers1 := TTrackers.Create(self);
  Projects1 := TProjects.Create(self);
  Issues1 := TIssues.Create(self);
  Roles1 := TRoles.Create(self);
  Users1 := TUsers.Create(self);
  Activities1 := TActivities.Create(self);
  HTMLCONTENT1 := '';
  LoginnedHTML1 := False;
  Progress1 := -1;
  Anonym1 := False;
  authenticity_token := '';
  Silence1 := False;
  RedmineAnswer := '';
  Loginned1 := False;
  Site1 := '';
  ForcedBusy1 := False;
  Busy1 := False;
  Init();
end;

destructor TRedmineClient.Destroy;
begin
  Tracking1.Free;
  Statuses1.Free;
  Prioritys1.Free;
  Trackers1.Free;
  Projects1.Free;
  Issues1.Free;
  Activities1.Free;
  Roles1.Free;
  Users1.Free;
  FNews.Free;
  HTTP.Free;
  inherited Destroy;
end;

procedure TRedmineClient.Test(var1: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  SL.Text := GetContent(var1);
  SL.SaveToFile('c:\test.txt');
  SL.Free;
end;

function TRedmineClient.CheckPermission(AProject: TRedmineProject; Permission: TRCPermissions): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to AProject.Roles[CurrentUser].Count - 1 do
    Result := Result or (Permission * AProject.Roles[CurrentUser].Item[i].Privileges >= Permission);
end;


function TRedmineClient.FillUsers: Integer;
var
  i, p, ST, ED: Integer;
  Sel1: TSelects;
  XML: TXMLDocument;
  Node1: TDOMNode;
  Project1, ParentProject1: TRedmineProject;
  Content, a, str1: string;
begin
  //Content := GetContent(site + '/users.xml');
  //setLength(UsersOptions1, 0);
  //if pos('<?xml', Content) <> 0 then
  //begin
  //ChangeStatus('Парсинг юзеров (XML)');
  //LoadXMLContent(XML, Content);
  //end
  //else
  //begin
  //ChangeStatus('Парсинг юзеров (HTML)');
  //if HTMLCONTENT1 = '' then
  //  HTMLCONTENT1 := GetContent(Projects[0].URL + '/issues/report');
  //Content := GetTextInTag(copy(HTMLCONTENT1, pos('report/assigned_to', HTMLCONTENT1), Length(HTMLCONTENT1)), 'tbody', 1);
  //i := 1;
  //while GetTag(Content, 'tr', i) <> '' do
  //begin
  //  setLength(UsersOptions1, i);
  //  str1 := GetTextInTag(Content, 'tr', i);
  //  a := GetTextInTag(str1, 'a', 1);
  //  str1 := GetTagParam(a, 'href');
  //  ST := pos('assigned_to_id=', str1) + 15;
  //  ED := posEx('&', str1, ST);
  //  if ED = 0 then
  //    ED := length(Str1)
  //  else
  //    ED := ED - ST;
  //  UsersOptions1[i - 1].Name := StripeTags(a);
  //  UsersOptions1[i - 1].Value := StrToInt(copy(str1, ST, ED));
  //  Inc(i);
  //end;
  //end;
end;

function TRedmineClient.FillIssues(AProjectId: Integer; ATrackerId: Integer): Integer;
var
  ProjectId1, i, j, t: Integer;
  RProject1: TRedmineProject;
  CSV: TCSV;
  ul, li: string;
  Content, Url: string;
  limit1, offset1, total1: Integer;
  XML: TXMLDocument;
  Node1: TDOMNode;
  Issue1: TIssue;

begin
  ChangeStatus('Парсинг задач (XML)');
  limit1 := 100;
  j := 0;
  t := 0;
  //status_id=*&
  while limit1 > 0 do
  begin
    Url := '/issues.xml?sort=id&limit=100&offset=' + IntToStr(j);
    if (AProjectId > 0) then
      Url := Url + '&project_id=' + IntToStr(AProjectId);
    if (ATrackerId > 0) then
      Url := Url + '&tracker_id=' + IntToStr(ATrackerId);

    Content := GetContent(site + Url);
    LoadXMLContent(XML, Content);
    if Assigned(XML.FindNode('issues').Attributes.GetNamedItem('offset')) then
      offset1 := StrToInt(XML.FindNode('issues').Attributes.GetNamedItem('offset').NodeValue)
    else
      offset1 := XML.FindNode('issues').ChildNodes.Count;
    if Assigned(XML.FindNode('issues').Attributes.GetNamedItem('total_count')) then
      total1 := StrToInt(XML.FindNode('issues').Attributes.GetNamedItem('total_count').NodeValue)
    else
      total1 := XML.FindNode('issues').ChildNodes.Count;
    limit1 := total1 - offset1;
    for i := 0 to XML.FindNode('issues').ChildNodes.Count - 1 do
    begin
      UpdateProgres(total1, t);
      Node1 := XML.FindNode('issues').ChildNodes.Item[i];
      Issue1 := Issues.Add(TIssue.Create(Self, 0));
      Issue1.Update(Node1);
      Inc(t);
    end;
    Inc(j, 100);
  end;
end;

function TRedmineClient.FillActivities: Integer;
var
  Content: string;
  Node1, Node2: TDOMNode;
  XML: TXMLDocument;
  i: Integer;
  Activity1: TIssuesActivity;
begin
  //Activities.Clear;
  Content := GetContent(site + '/enumerations/issue_priorities.xml');
  LoadXMLContent(XML, Content);
  Node1 := XML.FindNode('time_entry_activities');
  for i := 0 to Node1.ChildNodes.Count - 1 do
  begin
    Node2 := Node1.ChildNodes.Item[i];
    Activity1 := TIssuesActivity.Create(Node2.FindNode('name').TextContent, StrToInt(Node2.FindNode('id').TextContent));
    Activities1.Add(Activity1);
  end;
  XML.Free;
end;

procedure TRedmineClient.ChangeStatus(Message: string);
begin
  if Assigned(FOnChangeStatus) then
    FOnChangeStatus(Self, Message);
end;

//function TRedmineClient.GetProjectByNameRecursive(AName: string; AOwner: TRedmineProject): TRedmineProject;
//var
//  i: integer;
//  Count1: integer;
//begin
//  Result := nil;
//  if Assigned(AOwner) then
//  begin
//    for i := 0 to Length(AOwner.SubProjects1) - 1 do
//    begin
//      if AOwner.SubProjects[i].Name = AName then
//        Result := AOwner.SubProjects[i];
//      if (AOwner.SubProjects[i].CountSubProject > 0) and (not Assigned(Result)) then
//        Result := GetProjectByNameRecursive(AName, AOwner.SubProjects[i]);
//      if Assigned(Result) then
//        break;
//    end;
//  end
//  else
//  begin
//    for i := 0 to CountProjects - 1 do
//    begin
//      if Projects[i].Name = AName then
//        Result := Projects[i];
//      if (Projects[i].CountSubProject > 0) and (not Assigned(Result)) then
//        Result := GetProjectByNameRecursive(AName, Projects[i]);
//      if Assigned(Result) then
//        break;
//    end;
//  end;
//end;

function TRedmineClient.PreparePost(AsSave: boolean; method: string): TIdMultiPartFormDataStream;
begin
  Result := TIdMultiPartFormDataStream.Create;
  Result.AddFormField('utf8', '✓');
  Result.AddFormField('authenticity_token', GetToken());
  if method <> '' then
    Result.AddFormField('_method', method);
  if AsSave then
    Result.AddFormField('commit', 'Сохранить')
  else
    Result.AddFormField('commit', 'Создать');
end;

function TRedmineClient.GetToken(AForce: boolean): AnsiString;
var
  Content: string;
begin
  if (authenticity_token = '') or AForce then
  begin
    content := GetContent(Site);
    Result := StringReplace(GetTagParam(GetTagByParam(Content, 'meta', 'name', 'csrf-token', 1), 'content'),
      '+', '%2B', [rfReplaceAll]);
  end
  else
    Result := authenticity_token;
end;

function TRedmineClient.ParseIssueTracking(AIssue: TIssue): boolean;
var
  Content, Tag1: string;
  CurStatus1, NewStatus1: Integer;
  SL: TStringList;
  i, j: Integer;
  Sel1: TSelects;
  OptStatus1: TIssueStatus;
  Role1: TUserRole;
begin
  if AIssue.Assignee <> CurrentUser then
    exit;
  if not LoginnedHTML then
    Login(False, True, True);
  try
    Content := GetContent(AIssue.URL + '/edit');
    Tag1 := GetTagByParam(Content, 'select', 'id', 'issue_status_id', 1);
    Sel1 := ExtractSelectOptions(Tag1);
    CurStatus1 := AIssue.Status.ID;
    for i := 0 to Length(Sel1.Options) - 1 do
    begin
      NewStatus1 := StrToInt(Sel1.Options[i].Value);
      OptStatus1 := TIssueStatus.Create('', NewStatus1);
      IssueTracking(AIssue.Project, AIssue.Status, OptStatus1);
      OptStatus1.Free;
      IssueTracking1[AIssue.Project.Id - 1][CurStatus1 - 1][NewStatus1 - 1].Active := True;
    end;
    for i := 0 to Length(IssueTracking1[AIssue.Project.Id - 1][CurStatus1 - 1]) - 1 do
      IssueTracking1[AIssue.Project.Id - 1][CurStatus1 - 1][i].Parsed := True;
  except
  end;
end;

procedure TRedmineClient.AOnLogin;
var
  Name1: string;
begin
  if (assigned(FOnLogin)) then
    FOnLogin(self);
  if Loginned then
  begin
    Theme1 := TRCThemes.Create(ExtractFileDir(ParamStr(0)) + DirectorySeparator + 'themes' +
      DirectorySeparator + ExtractFileName(Site) + '_' + Username + '.tm', True);
  end;
  GetProfile();
end;

function TRedmineClient.IssueTracking(AIssue: TIssue; AForce: boolean): boolean;
var
  IssueStatus: TIssueStatus;
  NParsed: boolean;
begin
  IssueStatus := TIssueStatus.Create('', 1);
  IssueTracking(AIssue.Project, AIssue.Status, IssueStatus);
  NParsed := IssueTracking1[AIssue.Project.ID - 1][AIssue.Status.ID - 1][IssueStatus.ID - 1].Parsed;
  if (not IssueTracking1[AIssue.Project.ID - 1][AIssue.Status.ID - 1][IssueStatus.ID - 1].Parsed) and AForce then
    ParseIssueTracking(AIssue);
  IssueStatus.Free;
end;

function TRedmineClient.IssueTracking(AProject: TRedmineProject; ACurrentStatus, AChangeStatus: TIssueStatus): boolean;
var
  i, x, CU, CH, PR: Integer;
begin
  CU := ACurrentStatus.Id;
  CH := AChangeStatus.Id;
  PR := AProject.Id;
  if AProject.ID > Length(IssueTracking1) then
    SetLength(IssueTracking1, PR);

  if ACurrentStatus.ID > Length(IssueTracking1[PR - 1]) then
    SetLength(IssueTracking1[PR - 1], CU);

  if AChangeStatus.ID > Length(IssueTracking1[PR - 1][CU - 1]) then
  begin
    x := Length(IssueTracking1[PR - 1][CU - 1]);
    SetLength(IssueTracking1[PR - 1][CU - 1], CH);
    for i := x to Length(IssueTracking1[PR - 1][CU - 1]) - 1 do
    begin
      IssueTracking1[PR - 1][CU - 1][i].Active := False;
      IssueTracking1[PR - 1][CU - 1][i].Parsed := False;
    end;
  end;

  Result := IssueTracking1[PR - 1][CU - 1][CH - 1].Active and IssueTracking1[PR - 1][CU - 1][CH - 1].Parsed;
end;

procedure TRedmineClient.ReloadPermissions(ARole: TUserRole);
var
  Content, PName: string;
  i: Integer;
  XML: TXMLDocument;
  Node1, Node2: TDOMNode;
  P: TRCPermissions;
begin
  Content := GetContent(Site + '/roles/' + IntToStr(ARole.ID) + '.xml');
  LoadXMLContent(XML, Content);
  Node1 := XML.FindNode('role').FindNode('permissions');
  P := [];
  for i := 0 to Node1.ChildNodes.Count - 1 do
  begin
    Node2 := Node1.ChildNodes.Item[i];
    PName := Node2.TextContent;
    SetPermissionByName(P, PName);
  end;
  ARole.Privileges := P;
  XML.Free;
end;

function TRedmineClient.FillTrackers: Integer;
var
  Content, a, str1, name1: string;
  i, j, ST, ED: Integer;
  XML: TXMLDocument;
  Node1: TDOMNode;
  Tr: TTracker;
begin
  //Trackers.Clear;
  Content := GetContent(site + '/trackers.xml');

  ChangeStatus('Парсинг трекеров (XML)');
  LoadXMLContent(XML, Content);
  for i := 0 to XML.FindNode('trackers').ChildNodes.Count - 1 do
  begin
    Node1 := XML.FindNode('trackers').ChildNodes.Item[i];
    Tr := TTracker.Create(nil);
    Tr.Id := StrToInt(Node1.FindNode('id').TextContent);
    Tr.Name := Node1.FindNode('name').TextContent;
    Trackers.Add(Tr);
  end;
  XML.Free;
end;

function TRedmineClient.FillPriority: Integer;
var
  i, p, ST, ED: Integer;
  Sel1: TSelects;
  XML: TXMLDocument;
  Node1: TDOMNode;
  Project1, ParentProject1: TRedmineProject;
  Content, str1, a: string;
  Priority1: TIssuePriority;
begin
  //Prioritys.Clear;
  Content := GetContent(site + '/enumerations/issue_priorities.xml');
  ChangeStatus('Парсинг приоритетов (XML)');
  LoadXMLContent(XML, Content);
  for i := 0 to XML.FindNode('issue_priorities').ChildNodes.Count - 1 do
  begin
    Node1 := XML.FindNode('issue_priorities');
    Priority1 := TIssuePriority.Create(Node1.ChildNodes[i].FindNode('name').TextContent, StrToInt(
      Node1.ChildNodes[i].FindNode('id').TextContent));
    Priority1.isDefault := StrToBool(Node1.ChildNodes[i].FindNode('is_default').TextContent);
    Prioritys.Add(Priority1);
  end;
end;

function TRedmineClient.FillStatuses: Integer;
var
  Content: string;
  i: Integer;
  XML: TXMLDocument;
  Node1: TDOMNode;
  Status1: TIssueStatus;
begin
  //Statuses.Clear;
  Content := GetContent(site + '/issue_statuses.xml');
  ChangeStatus('Парсинг статусов (XML)');
  LoadXMLContent(XML, Content);
  for i := 0 to XML.FindNode('issue_statuses').ChildNodes.Count - 1 do
  begin
    Node1 := XML.FindNode('issue_statuses').ChildNodes.Item[i];
    Status1 := TIssueStatus.Create(Node1.FindNode('name').TextContent, StrToInt(Node1.FindNode('id').TextContent));
    Status1.isClosed := StrToBool(Node1.FindNode('is_closed').TextContent);
    Status1.isDefault := StrToBool(Node1.FindNode('is_default').TextContent);
    Statuses.Add(Status1);
  end;
  XML.Free;
end;