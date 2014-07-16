unit rc_components;

{$mode objfpc}{$H+}
interface

uses rc_classes, rc_parser, Classes;

procedure Register;

implementation

{$R 'images.res'}

procedure Register;
begin
  RegisterComponents('Redmine', [TRedmineClient]);
end;

end.
