{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit redmineclient;

interface

uses
  rc_classes, rc_parser, rc_components, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('rc_components', @rc_components.Register);
end;

initialization
  RegisterPackage('redmineclient', @Register);
end.
