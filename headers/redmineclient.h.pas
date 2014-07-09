{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}
type

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

{$IFDEF DontDefineThisVar}
end.
{$EndIf}
