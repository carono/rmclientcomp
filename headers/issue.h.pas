{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


implementation

{$EndIf}
type

  { TIssue }

  TIssue = class(TObject)
  private
    FCustromFields: TIssueCustomFieldManager;
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

    function SetParam(var AValue: TObject; var AParam: TObject; var ANominalValue: TObject): boolean;
    function SetParam(var AValue: TDateTime; var AParam: TDateTime; var ANominalValue: TDateTime): boolean;
    function SetParam(var AValue: AnsiString; var AParam: AnsiString; var ANominalValue: AnsiString): boolean;
    function CreateNode(AParent: TXMLDocument; AName, AValue: string): TDOMElement;
  public
    property URL: string read GetURL;
    procedure UpdateComments();
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
    property CustromFields: TIssueCustomFieldManager read FCustromFields;

    procedure AddComment(Message: string);
    procedure Cancel;

    procedure Refresh(Silence: boolean = False);
    function AddChild(ANumber: Integer = 0): TIssue;
    function Delete(): boolean;
    procedure Save();
    procedure Update(XMLNode1: TDOMNode); overload;
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


{$IFDEF DontDefineThisVar}
end.
{$EndIf}
