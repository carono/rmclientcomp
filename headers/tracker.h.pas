{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface

{$EndIf}
{ TTracker }
type
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

{$IFDEF DontDefineThisVar}
implementation

end.
{$EndIf}