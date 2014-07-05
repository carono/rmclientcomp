unit rc_parser;

{$mode objfpc}{$H+}

interface

uses
  Classes, Grids, SysUtils, strutils, CustomStringList;

type
  TLang = record
    Value: string;
    Name: string;
  end;

type
  TSelects = record
    Options: array of TLang;
    Selected: integer;
  end;

  { TCSV }
  TCSVRow = record
    Parsed: boolean;
    Start: integer;
    Size: integer;
    Text: string;
    Values: array of string;
  end;

  TCSV = class(TObject)
  private
    Rows1: array of TCSVRow;
    Delimeter1: char;
    Source1: string;
    SL: TCustomStringList;
    function GetCount: integer;
    function GetValue(Col, Row: integer): string;
    procedure ParseRow(Str: string; index: integer);
    procedure SetDelimeter(AValue: char);
  public
    function GetValueByField(Row: integer; Fieldname: string): string;
    function GetRawRow(index: integer): string;
    function GetRow(index: integer): TCSVRow;
    procedure ParseAll();
    property Count: integer read GetCount;
    property Value[Col, Row: integer]: string read GetValue;
    property Delimeter: char read Delimeter1 write SetDelimeter;
    procedure SaveToFile(Filename: string);
    procedure LoadFromFile(Filename: string);
    constructor Create(Source: string);
    destructor Destroy; override;
  end;

function GetTagParam(content, Param: string): string;
function GetTag(Content, tag: string; Pos1: integer): string;
function GetTextInTag(Content, Tag: string; Pos1: integer): string;
function GetTagByParam(Content, Tag, Param, Value: string; Pos1: integer): string;

function StripeTags(Content: string): string;
function ExtractSelectOptions(SelectContent: string): TSelects;

implementation

function StripeTags(Content: string): string;
var
  PS, PE: integer;
begin
  try
    while ((pos('<', content) <> 0) and (pos('>', content) <> 0) and (pos('<', content) < pos('>', content))) do
    begin
      PS := pos('<', content);
      PE := pos('>', content);
      if (((posEx('<', content, PS + 1) > PE) or (posEx('<', content, PS + 1) = 0)) and (PS <> 0) and (PE <> 0)) then
        Delete(content, PS, PE - PS + 1);
    end;
    Result := content;
  except
    Result := '';
  end;
end;

function ExtractSelectOptions(SelectContent: string): TSelects;
var
  i, x: integer;
  opt1, text1: string;
begin
  SelectContent := GetTextInTag(SelectContent, 'select', 1);
  i := 1;
  x := 0;
  opt1 := ' ';
  setlength(Result.Options, 0);
  while opt1 <> '' do
  begin
    text1 := StripeTags(GetTextInTag(SelectContent, 'option', i));
    if text1 = '' then
      break;
    setlength(Result.Options, length(Result.Options) + 1);
    opt1 := GetTag(SelectContent, 'option', i);
    if GetTagParam(opt1, 'selected') = 'selected' then
      Result.Selected := i - 1;

    Result.Options[i - 1].Value := GetTagParam(opt1, 'value');
    Result.Options[i - 1].Name := text1;
    Inc(i);
  end;
end;



function GetTagParam(content, Param: string): string;
var
  PS, PE: integer;
  ch: char;
begin
  try
    PS := pos(param + '=', content) + length(param) + 1;
    Result := '';
    ch := #23;
    if length(content) > PS then
    begin
      if ((content[PS] = '"') or (content[PS] = #39)) then
        ch := content[PS];
      if ch <> #23 then
        Inc(PS);
      PE := posex(ch, content, ps + 1);
      if PE > PS then
        Result := copy(content, PS, PE - PS);
    end;
  except
  end;
end;

function GetTag(Content, tag: string; Pos1: integer): string;
var
  PS, PE, i: integer;
begin
  Result := '';
  try
    Result := '';
    if content = '' then
    begin
      exit;
    end;
    PS := 0;
    for i := 1 to pos1 do
      PS := posEX('<' + tag, content, PS + 1);

    PE := posEX('>', content, PS);
    if PE < PS then
    begin
      exit;
    end;
    Result := copy(content, PS, PE - PS + 1);
    if Result = '<' then //Костылина
      Result := '';
  except
    Result := '';
  end;
end;

function GetTextInTag(Content, Tag: string; Pos1: integer): string;
var
  PS, PE, PS1, i, flag: integer;
begin
  Result := '';
  try
    if content = '' then
    begin
      exit;
    end;
    PS := 0;
    for i := 1 to pos1 do
    begin
      PS := posEX('<' + tag, content, PS + 1);
      if PS = 0 then
      begin
        exit;
      end;
    end;
    flag := 0;
    PS1 := PS;
    PE := PS;
    while (flag = 0) do
    begin
      PE := posEX('</' + tag, content, PE + 1);
      PS1 := posEX('<' + tag, content, PS1 + 1);
      if ((PS1 > PE) or (PS1 = 0)) then
        break;
    end;
    //Находим конец закрывающегося тега
    if (PE = 0) and (PS <> 0) then
      PE := posEX('>', content, PS);

    if ((PE = 0) and (PS = 0)) then
      exit;



    for PE := PE to PE + 50 do
      if (content[PE] = '>') then
        break;
    Result := copy(content, PS, PE - PS + 1);
  except
    Result := '';
  end;
end;

function GetTagByParam(Content, Tag, Param, Value: string; Pos1: integer): string;
var
  i, x: integer;
  str1: string;
begin
  str1 := GetTextInTag(Content, Tag, 1);
  x := 1;
  i := 1;
  while str1 <> '' do
  begin
    str1 := GetTextInTag(Content, Tag, i);
    if GetTagParam(str1, Param) = Value then
    begin
      if Pos1 = x then
        break;
      Inc(x);
    end;
    inc(i);
  end;
  Result := str1;
end;

{ TCSV }

function TCSV.GetValue(Col, Row: integer): string;
var
  Row1: string;
begin
  Result := '';
  Row1 := GetRawRow(Row);
  if Row1 <> '' then
  begin
    if Rows1[Row].Parsed = False then
      ParseRow(Row1, Row);
    Result := Rows1[Row].Values[Col];
  end;
end;

function TCSV.GetValueByField(Row: integer; Fieldname: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Length(Rows1[0].Values) - 1 do
    if Rows1[0].Values[i] = Fieldname then
    begin
      Result := Value[i, Row];
      break;
    end;
end;

function TCSV.GetRawRow(index: integer): string;
var
  ST, ED, i, k, m, q, IST: integer;
  Flag1: boolean;
begin
  Result := '';
  ST := 0;
  ED := 0;
  IST := 0;
  if Length(Rows1) > 0 then
    if index < Length(Rows1) then
    begin
      Result := Rows1[index].Text;
      exit;
    end
    else
    begin
      ST := Rows1[Length(Rows1) - 1].Start;
      ED := Rows1[Length(Rows1) - 1].Start + Rows1[Length(Rows1) - 1].Size;
      IST := Length(Rows1);
    end;

  for i := IST to index do
  begin
    Flag1 := False;
    ST := ED + 1;
    while not Flag1 do
    begin
      ED := posEx(#10, Source1, ED + 1);
      if Source1[ED - 1] = #13 then
        m := 1
      else
        m := 0;
      k := ED;
      q := 0;
      for k := ST to ED - 1 do
      begin
        if Source1[k] = '"' then
          Inc(q);
      end;
      if (q mod 2 = 0) then
        Flag1 := True;
    end;
  end;
  if ED > ST then
  begin
    m := ED - ST;
    Result := Copy(Source1, ST, m);
    SetLength(Rows1, index + 1);
    Rows1[index].Start := ST;
    Rows1[index].Size := m;
    Rows1[index].Text := Result;
    Rows1[index].Parsed := False;
  end;
end;

function TCSV.GetCount: integer;
begin
  Result := Length(Rows1);
end;

procedure TCSV.ParseRow(Str: string; index: integer);
var
  i: integer;
begin
  if Length(Rows1) - 1 < index then
    SetLength(Rows1, index + 1);
  SL.DelimitedText := Str;
  if SL.Count = 1 then
  begin
    Delimeter := ',';
    SL.DelimitedText := Str;
  end;

  SetLength(Rows1[index].Values, SL.Count);
  for i := 0 to SL.Count - 1 do
    Rows1[index].Values[i] := SL[i];
end;

procedure TCSV.SetDelimeter(AValue: char);
begin
  SL.Delimiter := AValue;
end;

function TCSV.GetRow(index: integer): TCSVRow;
begin
  Result := Rows1[index];
end;

procedure TCSV.ParseAll;
var
  i, j: integer;
  Row1: string;
begin
  SetLength(Rows1, 0);
  i := 0;
  while GetRawRow(i) <> '' do
  begin
    Row1 := GetRawRow(i);
    ParseRow(Row1, i);
    Inc(i);
  end;
end;

procedure TCSV.SaveToFile(Filename: string);
var
  SL1: TStringList;
begin
  SL1 := TStringList.Create;
  SL1.Text := Source1;
  SL1.SaveToFile(Filename);
  SL1.Free;
end;

procedure TCSV.LoadFromFile(Filename: string);
var
  SL1: TStringList;
begin
  SL1 := TStringList.Create;
  SL1.LoadFromFile(Filename);
  Source1 := SL1.Text;
  SL1.Free;
end;

constructor TCSV.Create(Source: string);
begin
  Delimeter1 := ';';
  SL := TCustomStringList.Create;
  SL.Delimiter := Delimeter;
  Source1 := Source;
end;

destructor TCSV.Destroy;
begin
  inherited Destroy;
  SL.Free;
end;

//procedure ParseIssuesCSV(var Client: TRedmineClient);
//var
//  content, ProjectName1, x: string;
//  CSV: TCSV;
//  i: integer;
//  RProject1: TRedmineProject;
//begin
//with Client do
//begin
//  ChangeStatus('Парсинг задач (CSV)');
//  x := site + '/issues.csv?columns=all&description=1';
//  content := Client.GetContent(x);
//  CSV := TCSV.Create(content);
//  CSV.ParseAll();
//  for i := 1 to CSV.Count - 1 do
//  begin
//    ProjectName1 := CSV.GetValueByField(i, 'Проект');
//RProject1 := GetProjectByName(ProjectName1);
//    RProject1.Update(CSV, i);
//  end;
//  CSV.Free;
//end;
//end;

//ChangeStatus('Парсинг трекеров (HTML)');
//for i := 0 to CountProjects - 1 do
//begin
//  Content := GetContent(Projects[i].URL);
//  Content := GetTextInTag(copy(Content, pos('issues box', Content), length(Content)), 'ul', 1);
//  j := 1;
//  while GetTag(Content, 'a', j) <> '' do
//  begin
//    a := GetTextInTag(Content, 'a', j);
//    str1 := GetTagParam(a, 'href');
//    ST := pos('tracker_id=', str1) + 11;
//    ED := posEx('&', str1, ST);
//    if ED = 0 then
//      ED := length(Str1)
//    else
//      ED := ED - ST;
//    name1 := StripeTags(a);
//    if GetTrackerOptionByName(name1).Value = 0 then
//    begin
//      setLength(TrackersOptions1, Length(TrackersOptions1) + 1);
//      TrackersOptions1[Length(TrackersOptions1) - 1].Name := name1;
//      TrackersOptions1[Length(TrackersOptions1) - 1].Value := StrToInt(copy(str1, ST, ED));
//    end;
//    Inc(j);
//  end;
//  break;
//end;

  //ChangeStatus('Парсинг приоритетов (HTML)');
  //if HTMLCONTENT1 = '' then
  //  HTMLCONTENT1 := GetContent(Projects[0].URL + '/issues/report');
  //Content := GetTextInTag(copy(HTMLCONTENT1, pos('report/priority', HTMLCONTENT1), Length(HTMLCONTENT1)), 'tbody', 1);
  //i := 1;
  //while GetTag(Content, 'tr', i) <> '' do
  //begin
  //  setLength(PrioritysOptions1, i);
  //  str1 := GetTextInTag(Content, 'tr', i);
  //  a := GetTextInTag(str1, 'a', 1);
  //  str1 := GetTagParam(a, 'href');
  //  ST := pos('priority_id=', str1) + 12;
  //  ED := posEx('&', str1, ST);
  //  if ED = 0 then
  //    ED := length(Str1)
  //  else
  //    ED := ED - ST;
  //  PrioritysOptions1[i - 1].Name := StripeTags(a);
  //  PrioritysOptions1[i - 1].Value := StrToInt(copy(str1, ST, ED));
  //  Inc(i);
  //end;
  //end;
end.
