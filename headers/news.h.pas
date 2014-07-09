{$IFDEF DontDefineThisVar}
// Only for jedi code
unit neverusedname;

interface

{$EndIf}

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

{$IFDEF DontDefineThisVar}
implementation

end.
{$EndIf}