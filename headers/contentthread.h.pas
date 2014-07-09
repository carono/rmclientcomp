{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface

{$EndIf}

type

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

{$IFDEF DontDefineThisVar}
implementation

end.
{$EndIf}