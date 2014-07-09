{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface

{$EndIf}

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

{$IFDEF DontDefineThisVar}
implementation

end.
{$EndIf}