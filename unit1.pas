unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  StdCtrls, MongoDB;

type

  { TForm1 }

  TForm1 = class(TForm)
    Memo1: TMemo;
    slsources:tstringlist;
    procedure FormShow(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public
    procedure init();
  end;

var
  Form1: TForm1;

implementation

{$R *.frm}

procedure TForm1.FormShow(Sender: TObject);
begin
  init;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  memo1.SelStart:=length(memo1.Lines.Text);
end;

procedure TForm1.init();
var
  i:integer=0;
  slt:TStringlist;
  slv:tstringlist;
begin
  slsources:=TStringlist.Create;
  slsources.Delimiter:='=';
  slt:=TStringlist.Create;
  slt.LoadFromFile('sources');
  for i:=0 to slt.Count-1 do
  begin
    slsources.AddObject(slt.Strings[i],tstringlist.Create);
    slv:=slsources.Objects[i] as tstringlist;
    slv.LoadFromFile(slt.Strings[i]);
    slv:=nil;
  end;
  slt.FreeInstance;
  memo1.Lines.Add(inttostr(slsources.Count));
  for i:=0 to slsources.Count-1 do
  begin
    slt:=slsources.Objects[i] as tstringlist;
    memo1.Lines.Add(inttostr(i));
    memo1.lines.AddText(slt.Text);
    slt.FreeInstance;
  end;
end;

end.

