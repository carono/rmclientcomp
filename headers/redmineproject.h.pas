{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface

{$EndIf}

type
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
    procedure Update(AID: integer); overload;
    procedure Update(AName: string); overload;
    procedure Save;
    procedure Cancel;
    property isChanged: boolean read GetisChanged;
    //property Permission: TRedminePermissions read GetPermission;
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
  end;

type
  { TProjects }

  TProjects = class(TArrayManager)
  private
    function GetItem(index: Integer): TRedmineProject;
  public
    property Item[index: Integer]: TRedmineProject read GetItem;
    function Add(AObject: TRedmineProject): TRedmineProject;
    function GetItemBy(AID: Integer): TRedmineProject; overload;
  end;

{$IFDEF DontDefineThisVar}
implementation

end.
{$EndIf}
