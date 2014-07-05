unit rc_classes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, strutils, XMLRead, variants, DOM, IdMultipartFormData, IdHTTP, IdHTTPCUS, rc_parser, IdAuthentication,
  IdCookieManager, rcUserProfile, rcIssueCategory, rcIssuePriority, rcRedmineUser, rcThemes,
  rcUserRole, rcObject, XMLWrite, rcSets, cUtils,rcInterfaces, rcIssueStatus,rcTracking, TripCMP, ArrayManager, base64, rcRecords, rcArrayManager, rcIssuesActivity;

type
  TRedmineClient = class;

type
  TTracker = class;

type
  TRedmineProject = class;

type
  TProjects = class;

//type
//  TIssue = class;

type
  TIssues = class;


type

  { TProjectVersion }

  TProjectVersion = class(TRCObject)
  private
    Created1: TDateTime;
    Description1: string;
    DueDate1: TDate;
    Project1: TRedmineProject;
    Status1: string;
    Updated1: TDateTime;
  public
    property Project: TRedmineProject read Project1;
    property Description: string read Description1;
    property Status: string read Status1;
    property DueDate: TDate read DueDate1;
    property Created: TDateTime read Created1;
    property Updated: TDateTime read Updated1;
  end;

type

  { TVersions }

  TVersions = class(TArrayManager)
  private
    function GetItem(index: Integer): TProjectVersion;
  public
    property Item[index: Integer]: TProjectVersion read GetItem;
    function Add(AObject: TProjectVersion): TProjectVersion;
    function GetItemBy(AID: Integer): TProjectVersion; overload;
  end;

  { TIssue }

  TIssue = class(TInterfacedObject,IIssue)
  private
    Tracker1: TTracker;
    isChanged1: boolean;
    Owner1: TObject;
    Number1: Integer;

    NominalParent1: TIssue;
    NominalTracker1: TTracker;
    NominalStatus1: TIssueStatus;
    NominalPriority1: TIssuePriority;
    NominalAssignee1: TRedmineUser;
    NominalVersion1: TProjectVersion;
    NominalClosed1: TDateTime;
    NominalCategory1: TIssueCategory;
    NominalProject1: TRedmineProject;
    NominalAutor1: TRedmineUser;
    NominalDescription1: AnsiString;
    NominalCreated1: TDateTime;
    NominalDone1: double;
    NominalDueDate1: TDateTime;
    NominalFinished1: TDateTime;
    NominalSpent1: double;
    NominalStarted1: TDateTime;
    NominalSubject1: string;
    NominalUpdated1: TDateTime;

    Project1: TRedmineProject;

    Status1: TIssueStatus;
    Priority1: TIssuePriority;
    Autor1: TRedmineUser;
    Subject1: string;
    Assignee1: TRedmineUser;
    Category1: TIssueCategory;
    Version1: TProjectVersion;
    Finished1: TDateTime;
    Description1: string;
    DueDate1: TDateTime;
    Updated1: TDateTime;
    Started1: TDateTime;
    Created1: TDateTime;
    Closed1: TDateTime;
    EvaluationTime1: double;
    Spent1: double;
    Done1: double;
    Comments1: array of TRComment;
    Childs1: TIssues;
    Note1: string;
    Parent1: TIssue;

    function GetAutor: TRedmineUser;
    function GetComment(index: Integer): TRComment;
    function getCountComments: Integer;
    function GetCreated: TDateTime;
    function GetDone: double;
    function GetDueDate: TDateTime;
    function GetSpent: double;
    function GetStarted: TDateTime;
    function GetSubject: string;
    function GetUpdated: TDateTime;
    function GetURL: string;
    function GetAssignee: TRedmineUser;
    function GetCategory: TIssueCategory;
    function GetClosed: TDateTime;
    function GetDescription: AnsiString;
    function GetisChanged: boolean;
    function GetParent: TIssue;
    function GetPriority: TIssuePriority;
    function GetProject: TRedmineProject;
    function GetRedmine: TRedmineClient;
    function GetStatus: TIssueStatus;
    function GetTracker: TTracker;
    function GetVersion: TProjectVersion;
    procedure SetAssignee(AValue: TRedmineUser);
    procedure SetAutor(AValue: TRedmineUser);
    procedure SetCategory(AValue: TIssueCategory);
    procedure SetClosed(AValue: TDateTime);
    procedure SetCreated(AValue: TDateTime);
    procedure SetDescription(AValue: AnsiString);
    procedure SetDone(AValue: double);
    procedure SetDueDate(AValue: TDateTime);
    procedure SetFinished(AValue: TDateTime);
    procedure SetParent(AValue: TIssue);
    procedure SetPriority(AValue: TIssuePriority);
    procedure SetProject(AValue: TRedmineProject);
    procedure SetSpent(AValue: double);
    procedure SetStarted(AValue: TDateTime);
    procedure SetStatus(AValue: TIssueStatus);
    procedure SetSubject(AValue: string);
    procedure SetTracker(AValue: TTracker);
    procedure SetUpdated(AValue: TDateTime);
    procedure SetVersion(AValue: TProjectVersion);
    procedure ParseComments(XMLNode1: TDOMNode);
    procedure SetParam(AValue, AParam, ANominalValue: variant);
    procedure SetParam(AValue, AParam, ANominalValue: TObject);

    function CreateNode(AParent: TXMLDocument; AName, AValue: string): TDOMElement;
  public
    property URL: string read GetURL;
    procedure UpdateComments();
    procedure UpdateEnumerations();
    property Tracker: TTracker read GetTracker write SetTracker;
    property Project: TRedmineProject read GetProject write SetProject;
    property Redmine: TRedmineClient read GetRedmine;
    property Number: Integer read Number1;
    property Parent: TIssue read GetParent write SetParent;
    property Comments[index: Integer]: TRComment read GetComment;
    property CountCommnets: Integer read getCountComments;
    property Status: TIssueStatus read GetStatus write SetStatus;
    property Priority: TIssuePriority read GetPriority write SetPriority;
    property Autor: TRedmineUser read GetAutor write SetAutor;
    property Subject: string read GetSubject write SetSubject;
    property Assignee: TRedmineUser read GetAssignee write SetAssignee;
    property Category: TIssueCategory read GetCategory write SetCategory;
    property Version: TProjectVersion read GetVersion write SetVersion;
    property Description: AnsiString read GetDescription write SetDescription;
    property EvaluationTime: double read EvaluationTime1 write EvaluationTime1;
    property DueDate: TDateTime read GetDueDate write SetDueDate;
    property Updated: TDateTime read GetUpdated write SetUpdated;
    property Started: TDateTime read GetStarted write SetStarted;
    property Created: TDateTime read GetCreated write SetCreated;
    property Closed: TDateTime read GetClosed write SetClosed;
    property Spent: double read GetSpent write SetSpent;
    property Done: double read GetDone write SetDone;
    property Childs: TIssues read Childs1;
    property isChanged: boolean read GetisChanged;
    procedure AddComment(Message: string);
    procedure Cancel;
    procedure Refresh(Silence: boolean = False);
    function AddChild(ANumber: Integer = 0): TIssue;
    function Delete(): boolean;
    procedure Save();
    procedure Update(XMLNode1: TDOMNode); overload;
    procedure Update(CSV: TCSV; Row: Integer); overload;
    constructor Create(AOwner: TObject; ANumber: Integer = 0);
    destructor Destroy; override;
  end;

type

  { TIssues }

  TIssues = class(TArrayManager)
  private
    function GetItem(index: Integer): TIssue;
  public
    property Item[index: Integer]: TIssue read GetItem;
    function Add(AObject: TIssue): TIssue;
    function GetItemBy(AID: Integer): TIssue; overload;
    procedure Clear; override;
  end;

  { TTracker }

  TTracker = class(TObject)
  private
    Issues1: TIssues;
    Owner1: TRedmineProject;
    Name1: string;
    Value1: Integer;
    Active1: boolean;
    function GetActive: boolean;
    function GetCountIssues: Integer;
    function GetRedmine: TRedmineClient;
    procedure SetActive(AValue: boolean);
  public
    property Redmine: TRedmineClient read GetRedmine;
    property Active: boolean read GetActive write SetActive;
    property Owner: TRedmineProject read Owner1;
    property Name: string read Name1 write Name1;
    property Id: Integer read Value1 write Value1;
    property Issues: TIssues read Issues1;
    property CountIssues: Integer read GetCountIssues;
    procedure Update(XMLNode1: TDOMNode); overload;
    procedure Update(CSV: TCSV; Row: Integer); overload;
    procedure Refresh();
    function AddIssue(ANumber: Integer = 0): TIssue;
    constructor Create(AOwner: TRedmineProject);
    destructor Destroy(); override;
    procedure Clear();
  end;

type

  { TTrackers }

  TTrackers = class(TArrayManager)
  private
    function GetItem(index: Integer): TTracker;
  public
    property Item[index: Integer]: TTracker read GetItem;
    function Add(AObject: TTracker): TTracker;
    function GetItemBy(AID: Integer): TTracker; overload;
    procedure Assign(ASource: TTrackers);
    procedure Clear; override;
  end;

type

  { TNews }

  TNewsitem = class(TObject)
  private
    Autor1: TRedmineUser;
    Created1: TDateTime;
    Description1: string;
    ID1: Integer;
    Project1: TRedmineProject;
    Subject1: string;
    Summary1: string;
  public
    property Project: TRedmineProject read Project1;
    property ID: Integer read ID1;
    property Autor: TRedmineUser read Autor1;
    property Subject: string read Subject1;
    property Description: string read Description1;
    property Created: TDateTime read Created1;
    property Summary: string read Summary1;
  end;

  TNews = class(TObject)
  private
    Items1: array of TNewsitem;
    function GetCount: Integer;
    function GetItem(index: Integer): TNewsitem;
  public
    property Count: Integer read GetCount;
    property Items[index: Integer]: TNewsitem read GetItem;
    procedure AddNews(News: TNewsitem);
    destructor Destroy; override;
  end;

  { TRedmineProject }

  TRedmineProject = class(TObject)
  private
    Modules1: array of TRCModuleRec;
    Roles1: array of TRoles;
    Identifier1: string;
    Owner1: TObject;
    URL1: string;
    Name1: string;
    Description1: string;
    Trackers1: TTrackers;
    Versions1: TVersions;
    Categorys1: TCategorys;
    SubProjects1: TProjects;
    Users1: TUsers;
    Id1: Integer;
    IsPublic1: boolean;
    NominalIdentifier1: string;
    NominalOwner1: TObject;
    NominalDescription1: string;
    Page1: string;
    isChanged1: boolean;
    isChangedModules1: boolean;
    function GetCountModules: Integer;
    function GetDescription: string;
    function GetisChanged: boolean;
    function GetModules(index: Integer): TRCModuleRec;
    function GetParent: TRedmineProject;
    //function GetPermission(): TRedminePermissions;
    function GetRedmine: TRedmineClient;
    function GetRoles(User: TRedmineUser): TRoles;
    function GetSubTracker(index: Integer): TRedmineProject;
    function GetURL: string;
    procedure SaveModules();
    procedure SetDescription(AValue: string);
    procedure SetIdentifier(AValue: string);
    procedure SetIsPublic(AValue: boolean);
    procedure SetOwner(AValue: TObject);
    procedure SetPage(AValue: string);
    procedure SetParent(AValue: TRedmineProject);
  public
    procedure SetModule(ID: string; Value: boolean);
    property Homepage: string read Page1 write SetPage;
    property Modules[index: Integer]: TRCModuleRec read GetModules;
    property Redmine: TRedmineClient read GetRedmine;
    property Roles[User: TRedmineUser]: TRoles read GetRoles;
    property Users: TUsers read Users1;
    property IsPublic: boolean read IsPublic1 write SetIsPublic;
    property CountModules: Integer read GetCountModules;
    function AddUser(AName: string; AID: Integer): TRedmineUser;
    property Owner: TObject read Owner1 write SetOwner;
    property Identifier: string read Identifier1 write SetIdentifier;
    property URL: string read GetURL;
    property Name: string read Name1 write Name1;
    property Id: Integer read Id1 write Id1;
    property Parent: TRedmineProject read GetParent write SetParent;
    property Description: string read GetDescription write SetDescription;
    property Trackers: TTrackers read Trackers1;
    property SubProjects: TProjects read SubProjects1;
    property Versions: TVersions read Versions1;
    property Categorys: TCategorys read Categorys1;
    function AddSubProject(): TRedmineProject;
    procedure LoadCategorys;
    procedure RefreshTrackers();
    procedure RefreshMemberships();
    procedure RefreshVersions();
    procedure RefreshCategories();
    procedure RefreshIssues();
    procedure Refresh();
    procedure Update(XMLNode1: TDOMNode); overload;
    procedure Update(CSV: TCSV; Row: Integer); overload;
    procedure Save;
    procedure Cancel;
    property isChanged: boolean read GetisChanged;
    //property Permission: TRedminePermissions read GetPermission;
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
  end;

  { TProjects }

  TProjects = class(TArrayManager)
  private
    function GetItem(index: Integer): TRedmineProject;
  public
    property Item[index: Integer]: TRedmineProject read GetItem;
    function Add(AObject: TRedmineProject): TRedmineProject;
    function GetItemBy(AID: Integer): TRedmineProject; overload;
  end;

  { TRedmineClient }
  TOnGetProjects = procedure(Sender: TObject; Projects: array of TRedmineProject) of object;
  TOnLogin = procedure(Sender: TObject) of object;
  TOnError = procedure(Sender: TObject; ErrorNo: Integer) of object;
  TOnUpdateIssue = procedure(Sender: TObject; Issue: TIssue) of object;
  TOnStartBusy = procedure(Sender: TObject) of object;
  TOnEndBusy = procedure(Sender: TObject) of object;
  TOnSaveIssue = procedure(Sender: TObject; Issue: TIssue; Saved: boolean) of object;
  TOnChangeProgress = procedure(Sender: TObject) of object;
  TOnChangeStatus = procedure(Sender: TObject; Message: string) of object;
  TOnUpdateNews = procedure(Sender: TObject) of object;
  TOnUpdateProject = procedure(Sender: TObject; AProject: TRedmineProject) of object;
  { TContentThread }
  TContentMethod = (TMPost, TMGet, TMPut, TMDelete);

  TContentThread = class(TThread)
  private
    Method1: TContentMethod;
  public
    Owner: TObject;
    Url1: string;
    Content1: string;
    Data1: TStream;
    Data2: TStrings;
    HTTPError1: Integer;
  private
    destructor Destroy(); override;
    procedure Execute(); override;
    constructor Create(AOwner: TObject; Url: string; AMethod: TContentMethod; AData: TStream); overload;
    constructor Create(AOwner: TObject; Url: string; AMethod: TContentMethod; AData: TStrings); overload;
    constructor Create(AOwner: TObject; Url: string; AMethod: TContentMethod); overload;
  end;

  TRedmineClient = class(TComponent)
  private
    FOnUpdateProject: TOnUpdateProject;
    Roles1: TRoles;
    Users1: TUsers;
    Issues1: TIssues;
    Projects1: TProjects;
    Tracking1: TTracking;
    Activities1: TActivities;
    FOnUpdateNews: TOnUpdateNews;
    Trackers1: TTrackers;
    Prioritys1: TPrioritys;
    Statuses1: TStatuses;
    Anonym1: boolean;
    ContentThread1: TContentThread;
    Busy1: boolean;
    ForcedBusy1: boolean;
    Loginned1: boolean;
    LoginnedHTML1: boolean;
    Password1: string;
    Silence1: boolean;
    Site1: string;
    Theme1: TRCThemes;
    Username1: string;
    Languages1: array of TLang;
    Notice1: array of TLang;
    FOnGetProjects: TOnGetProjects;
    FOnLogin: TOnLogin;
    FOnError: TOnError;
    FOnUpdateIssue: TOnUpdateIssue;
    FOnEndBusy: TOnEndBusy;
    FOnStartBusy: TOnStartBusy;
    FOnSaveIssue: TOnSaveIssue;
    FOnChangeProgress: TOnChangeProgress;
    FOnChangeStatus: TOnChangeStatus;
    RedmineAnswer: string;
    Progress1: double;
    ProgressMax: Integer;
    ProgressPosition: Integer;
    Temp1: string;
    HTTP: TIdHTTP;
    authenticity_token: string;
    HTMLCONTENT1: string;
    FNews: TNews;
    CurrentUser1: TRedmineUser;
    IssueTracking1: array of array of array of TElemParsed;
    function GetBusy: boolean;
    function ExtractContent(Url: string; AMethod: TContentMethod; Data: TObject = nil): string;
    function GetContent(Url: string): string; overload;
    function GetLoginned: boolean;
    function GetLoginnedHTML: boolean;
    function GetNews(): TNews;
    function GetPermission: TRedminePermissions;
    function PostContent(Url: string; Post: TObject = nil): string;
    function PutContent(Url: string; Post: TStream = nil): string;
    function DeleteContent(Url: string; Post: TStream = nil): string; overload;
    function GetIssue(number: Integer): TIssue;
    function GetLanguages(index: Integer): TLang;
    function GetNotice(index: Integer): TLang;
    procedure GetProfile();
    function GetProgress: double;
    function GetDefaultPriority(): TIssuePriority;
    function GetDefaultStatus(): TIssueStatus;
    procedure SetSite(AValue: string);
    procedure UpdateIssues(AProject: TRedmineProject);
    procedure Init();
    procedure SetBusy(Force: boolean = False);
    procedure UnSetBusy(Force: boolean = False);
    procedure UpdateProgres(Max: Integer = -1; Current: Integer = -1; ClearStoraged: boolean = False);
    function FillRoles(): Integer;
    function FillTrackers(): Integer;
    function FillProjects(id: Integer = 0): Integer;
    function FillPriority(): Integer;
    function FillStatuses(): Integer;
    function FillUsers(): Integer;
    function FillIssues(AProjectId: Integer = 0; ATrackerId: Integer = 0): Integer;
    function FillActivities(): Integer;
    procedure ChangeStatus(Message: string);
    function PreparePost(AsSave: boolean; method: string = ''): TIdMultiPartFormDataStream;
    function GetToken(AForce: boolean = False): AnsiString;
    function ParseIssueTracking(AIssue: TIssue): boolean;
    procedure AOnLogin();
  public
    function IssueTracking(AIssue: TIssue; AForce: boolean = True): boolean; overload;
    function IssueTracking(AProject: TRedmineProject; ACurrentStatus, AChangeStatus: TIssueStatus): boolean; overload;
    property Themes: TRCThemes read Theme1 write Theme1;
    function CheckPermission(AProject: TRedmineProject; Permission: TRCPermissions): boolean;
    procedure ReloadPermissions(ARole: TUserRole);
    property CurrentUser: TRedmineUser read CurrentUser1;
    procedure Update();
    procedure UpdateNews(Offset: Integer = 0);
    property Tracking: TTracking read Tracking1;
    property News: TNews read FNews;
    property Roles: TRoles read Roles1;
    property Users: TUsers read Users1;
    property Activities: TActivities read Activities1;
    property Projects: TProjects read Projects1;
    property Trackers: TTrackers read Trackers1;
    property Issues: TIssues read Issues1;
    property Prioritys: TPrioritys read Prioritys1;
    property Statuses: TStatuses read Statuses1;
    property Languages[index: Integer]: TLang read GetLanguages;
    property Notice[index: Integer]: TLang read GetNotice;
    property Loginned: boolean read GetLoginned;
    property LoginnedHTML: boolean read GetLoginnedHTML;
    property Busy: boolean read GetBusy;
    property Progress: double read GetProgress;
    procedure SaveIssue(index: Integer);
    property Anonym: boolean read Anonym1;
    function Login(AAnonym: boolean = False; AsHtml: boolean = False; ASilence: boolean = False): boolean;
    property Permission: TRedminePermissions read GetPermission;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure Test(var1: string);
  published
    property Silence: boolean read Silence1 write Silence1;
    property Username: string read Username1 write Username1;
    property Password: string read Password1 write Password1;
    property Site: string read Site1 write SetSite;
    property OnGetProjects: TOnGetProjects read FOnGetProjects write FOnGetProjects;
    property OnStartBusy: TOnStartBusy read FOnStartBusy write FOnStartBusy;
    property OnEndBusy: TOnEndBusy read FOnEndBusy write FOnEndBusy;
    property OnLogin: TOnLogin read FOnLogin write FOnLogin;
    property OnError: TOnError read FOnError write FOnError;
    property OnUpdateIssue: TOnUpdateIssue read FOnUpdateIssue write FOnUpdateIssue;
    property OnSaveIssue: TOnSaveIssue read FOnSaveIssue write FOnSaveIssue;
    property OnChangeProgress: TOnChangeProgress read FOnChangeProgress write FOnChangeProgress;
    property OnChangeStatus: TOnChangeStatus read FOnChangeStatus write FOnChangeStatus;
    property OnUpdateNews: TOnUpdateNews read FOnUpdateNews write FOnUpdateNews;
    property OnUpdateProject: TOnUpdateProject read FOnUpdateProject write FOnUpdateProject;
  end;

procedure ParseMembershipsHTML(Project: TRedmineProject);
procedure ParseProjectsHTML1(var Client: TRedmineClient);

implementation

function StrToFloatCustom(Str1: string): double;
begin
  if Str1 = '' then
    Str1 := '0,0';
  Str1 := StringReplace(Str1, '.', ',', [rfReplaceAll]);
  Result := StrToFloat(Str1);
end;

function StrToDateTimeCustom(Str1: string): TDateTime;
var
  p: Integer;
  formatSettings: TFormatSettings;
begin
  try
    formatSettings.DateSeparator := '-';
    formatSettings.TimeSeparator := ':';
    formatSettings.ShortDateFormat := 'yyyy-mm-dd';
    if pos('UTC', Str1) > 0 then
    begin
      Str1 := Trim(StringReplace(Str1, 'UTC', '', []));
    end;
    if pos('Z', Str1) > 0 then
    begin
      Str1 := Trim(StringReplace(Str1, 'T', ' ', []));
      Str1 := Trim(StringReplace(Str1, 'Z', '', []));
      Result := StrToDateTime(Str1, formatSettings);
      exit;
    end;
    Result := StrToDateTime(Str1, formatSettings);
  except
    Result := 0;
  end;
end;

procedure LoadXMLContent(var XML: TXMLDocument; Content: string);
var
  SL: TStringStream;
begin
  if not Assigned(XML) then
    XML := TXMLDocument.Create;
  SL := TStringStream.Create(AnsiToUtf8(Content));
  ReadXMLFile(XML, SL);
  SL.Free;
end;

function ExtractParentInt(Str: string): Integer;
var
  ST, ED: Integer;
  str1: string;
begin
  try
    ST := pos('#', Str) + 1;
    ED := posEx(':', Str, ST);
    str1 := copy(Str, ST, ED - ST);
    if str1 <> '' then
      Result := StrToInt(str1)
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

procedure ParseMembershipsHTML(Project: TRedmineProject);
var
  Content, Tag1, RoleName1, UserName1, Str1, Tag2: string;
  SL: TStringList;
  Ar1, Ar2, Ar3: TStringArray;
  AID1, i, j, AIndex1, k: Integer;
  User1: TRedmineUser;
  Role1: TUserRole;
begin
  if not Project.Redmine.LoginnedHTML and not Project.Redmine.Anonym then
    Project.Redmine.Login(False, True, True);
  //SL := TStringList.Create;
  Content := Project.Redmine.GetContent(Project.URL);
  Tag1 := GetTagByParam(Content, 'div', 'class', 'members box', 1);
  Tag1 := GetTextInTag(Tag1, 'p', 1);
  //SL.Text := StripeTags(Tag1);
  Explode(Ar1, #10, Trim(StripeTags(Tag1)));
  k := 1;
  for i := 0 to Length(Ar1) - 1 do
  begin
    Str1 := Trim(Ar1[i]);
    if Str1 <> '' then
    begin
      Explode(Ar2, ':', Str1);
      RoleName1 := Ar2[0];
      Explode(Ar2, ',', Ar2[1]);
      Role1 := Project.Redmine.Roles.GetItemBy(RoleName1);
      for j := 0 to Length(Ar2) - 1 do
      begin
        UserName1 := Trim(Ar2[j]);
        Tag2 := GetTagParam(GetTag(Tag1, 'a', k), 'href');
        Explode(Ar3, '/', Tag2);
        AID1 := StrToInt(Ar3[Length(Ar3) - 1]);
        User1 := Project.AddUser(UserName1, AID1);
        Project.Roles[User1].Add(Role1);
        Inc(k);
      end;
    end;
  end;
  //SL.SaveToFile('c:\1.txt');
  //SL.Free;
end;

procedure ParseProjectsHTML1(var Client: TRedmineClient);

  procedure GetChilds(var Client: TRedmineClient; content: string; Project: TRedmineProject);
  var
    i: Integer;
    Project1, ParentProject1: TRedmineProject;
    li, ul: string;
  begin
    li := GetTextInTag(content, 'li', 1);
    i := 1;
    while (li <> '') do
    begin
      li := GetTextInTag(content, 'li', i);
      if Assigned(Project) then
        Project1 := Project.AddSubProject()
      else
        Project1 := Client.Projects.Add(TRedmineProject.Create(Client));
      Project1.Id := -1;
      Project1.Identifier := StringReplace(GetTagParam(GetTag(li, 'a', 1), 'href'), '/projects/', '', []);
      Project1.Name := StripeTags(GetTextInTag(li, 'a', 1));
      Project1.Description := StripeTags(GetTextInTag(li, 'div', 2));
      ul := GetTextInTag(li, 'ul', 1);
      if (ul <> '') then
        GetChilds(Client, ul, Project1);
      Inc(i);
    end;
  end;

var
  Content, ul: string;

begin
  with Client do
  begin
    content := GetContent(site + '/projects');
    ul := GetTextInTag(content, 'ul', 3);
    GetChilds(Client, ul, nil);
  end;
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
  SetParam(AValue, Assignee1, NominalAssignee1);
end;

procedure TIssue.SetAutor(AValue: TRedmineUser);
begin
  SetParam(AValue, Autor1, NominalAutor1);
end;

procedure TIssue.SetCategory(AValue: TIssueCategory);
begin
  SetParam(AValue, Category1, NominalCategory1);
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
  SetParam(AValue, Project1, NominalProject1);
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
  SetParam(AValue, Status1, NominalStatus1);
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
  SetParam(AValue, Tracker1, NominalTracker1);
end;

procedure TIssue.SetUpdated(AValue: TDateTime);
begin
  SetParam(AValue, Updated1, NominalUpdated1);
end;

procedure TIssue.SetVersion(AValue: TProjectVersion);
begin
  SetParam(AValue, Version1, NominalVersion1);
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

procedure TIssue.SetParam(AValue, AParam, ANominalValue: variant);
begin
  if TripCompare(AValue, AParam, ANominalValue) then
    isChanged1 := True;
end;

procedure TIssue.SetParam(AValue, AParam, ANominalValue: TObject);
begin
  if TripCompare(AValue, AParam, ANominalValue) then
    isChanged1 := True;
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

procedure TIssue.UpdateEnumerations;
begin

end;

procedure TIssue.AddComment(Message: string);
begin
  Note1 := Message;
  Save();
end;

procedure TIssue.SetParent(AValue: TIssue);
begin
  SetParam(AValue, Parent1, NominalParent1);
end;

procedure TIssue.SetPriority(AValue: TIssuePriority);
begin
  SetParam(AValue, Priority1, NominalPriority1);
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


      {$Define DEBUG}
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

    S := TStringStream.Create('');
    {$IFDEF DEBUG}
    WriteXMLFile(XML, 'c:/test.xml');
    {$ENDIF}
    WriteXML(XML, S);
    Content := S.DataString;

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

procedure TIssue.Update(CSV: TCSV; Row: Integer);
begin

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

{ TRedmineProject }

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

function TRedmineClient.CheckPermission(AProject: TRedmineProject; Permission: TRCPermissions): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to AProject.Roles[CurrentUser].Count - 1 do
    Result := Result or (Permission * AProject.Roles[CurrentUser].Item[i].Privileges >= Permission);
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

function TRedmineProject.AddSubProject: TRedmineProject;
begin
  SubProjects1.Add(Redmine.Projects.Add(TRedmineProject.Create(Self)));
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
begin
  if not Loginned then
    exit;
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

end.
