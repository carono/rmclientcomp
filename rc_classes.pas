unit rc_classes;

{$mode objfpc}{$H+}

{create empty file, or delete this include}
{$I defines.inc}

interface

uses
  Classes, SysUtils, Forms, strutils, XMLRead, DOM, IdMultipartFormData, IdHTTP, IdHTTPCUS, rc_parser,
  rcIssueCategory, rcIssuePriority, rcRedmineUser, rcThemes, TripCMP,
  rcUserRole, rcObject, XMLWrite, rcSets, cUtils, rcIssueStatus, rcTracking, ArrayManager,
  base64, rcRecords, rcIssuesActivity;

type
  TRedmineClient = class;

type
  TTracker = class;

type
  TRedmineProject = class;

type
  TProjects = class;


type
  TIssues = class;


{$I headers/projectversion.h.pas}
{$I headers/issue.h.pas}
{$I headers/tracker.h.pas}
{$I headers/news.h.pas}
{$I headers/redmineproject.h.pas}
{$I headers/contentthread.h.pas}
{$I headers/redmineclient.h.pas}


procedure ParseMembershipsHTML(Project: TRedmineProject);
procedure ParseProjectsHTML1(var Client: TRedmineClient);
procedure LoadXMLContent(var XML: TXMLDocument; Content: string);
function StrToDateTimeCustom(Str1: string): TDateTime;
function StrToFloatCustom(Str1: string): double;

implementation

{$I implementations/redmineproject.i.pas}
{$I implementations/news.i.pas}
{$I implementations/projectversion.i.pas}
{$I implementations/tracker.i.pas}
{$I implementations/redmineclient.i.pas}
{$I implementations/issue.i.pas}
{$I implementations/contentthread.i.pas}

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

end.
