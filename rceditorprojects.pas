unit rcEditorProjects;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rcRecords;

{ TEditorProjects }
type

  TEditorProjects = class(TObject)
  private
    ProjectParam1: TProjectParam;
    ProjectStream: TFileStream;
    Filename1: string;
    procedure Close();
    procedure ClearProp();
    function GetProjectParam: TProjectParam;
    procedure OpenFile(Filename: string);
    procedure ReloadProp();
  public
    procedure Save();
    procedure SaveAs(Filename: string);
    procedure Load(Filename: string);
    property Prop: TProjectParam read ProjectParam1 write ProjectParam1;
    constructor Create();
    procedure Delete();
    destructor Destroy(); override;
  end;

implementation

{ TEditorProjects }

procedure TEditorProjects.Close;
begin

end;

procedure TEditorProjects.ClearProp;
begin
  ProjectParam1.Name := '';
  ProjectParam1.Login := '';
  ProjectParam1.Password := '';
  ProjectParam1.Site := '';
end;

function TEditorProjects.GetProjectParam: TProjectParam;
begin
  if not Assigned(ProjectStream) then
    raise TExceptionClass.Create('Проект не загружен')
  else
    Result := ProjectParam1;
end;

procedure TEditorProjects.OpenFile(Filename: string);
begin
  if Assigned(ProjectStream) then
    FreeAndNil(ProjectStream);
  Filename := Utf8ToAnsi(Filename);
  if FileExists(Filename) then
    ProjectStream := TFileStream.Create(Filename, fmOpenReadWrite)
  else
    ProjectStream := TFileStream.Create(Filename, fmCreate);
end;

procedure TEditorProjects.ReloadProp;
begin
  ClearProp();
  if ProjectStream.Size = SizeOf(ProjectParam1) then
    try
      ProjectStream.ReadBuffer(ProjectParam1, SizeOf(ProjectParam1));
    except

    end;
end;

procedure TEditorProjects.Save;
begin
  ProjectStream.Size := 0;
  ProjectStream.WriteBuffer(ProjectParam1, SizeOf(ProjectParam1));
end;

procedure TEditorProjects.SaveAs(Filename: string);
begin
  Delete();
  OpenFile(Filename);
  Save;
end;

procedure TEditorProjects.Load(Filename: string);
begin
  Filename1 := Utf8ToAnsi(Filename);
  OpenFile(Filename);
  ReloadProp();
end;

constructor TEditorProjects.Create;
begin
  Filename1 := '';
end;

procedure TEditorProjects.Delete;
begin
  if Assigned(ProjectStream) then
    FreeAndNil(ProjectStream);
  if FileExists(PChar(Filename1)) then
    DeleteFile(PChar(Filename1));
end;

destructor TEditorProjects.Destroy;
begin
  ProjectStream.Free;
end;

end.

