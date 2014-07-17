{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface


{$EndIf}

type

  { TIssueCustomField }

  TIssueCustomField = class(TRCObject)
  private
    FValue: string;
  public
    property Value: string read FValue write FValue;
    constructor Create(AName: string; AID: Integer; AValue: string);
  end;

type

  { TIssueCustomFieldManager }

  TIssueCustomFieldManager = class(TArrayManager)
  private
    function GetItem(index: Integer): TIssueCustomField;
    function GetOwner: TIssue;
    procedure SetOwner(AValue: TIssue);
  public
    property Owner: TIssue read GetOwner write SetOwner;
    property Item[index: Integer]: TIssueCustomField read GetItem;
    function Add(AObject: TIssueCustomField): TIssueCustomField;
    function GetItemByID(AID: Integer): TIssueCustomField;
    function Current: TIssueCustomField;
    procedure Load(XMLNode: TDOMNode); overload;
    procedure Load(); overload;
    procedure Clear; override;
  end;

{$IFDEF DontDefineThisVar}
implementation

end.
{$EndIf}
