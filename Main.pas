unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
{$IF Defined(MSWINDOWS)}
   System.Win.Registry,
{$ENDIF}
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    edtUrl: TEdit;
    btnAbrir: TButton;
    wbYT: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
  private
    { Private declarations }
{$IFDEF MSWINDOWS}
    procedure SetPermissions;
{$ENDIF}
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TForm1 }

procedure TForm1.btnAbrirClick(Sender: TObject);
begin
  wbYT.Navigate(edtUrl.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  SetPermissions;
{$ENDIF}
end;

{$IFDEF MSWINDOWS}
procedure TForm1.SetPermissions;
const
  cHomePath = 'SOFTWARE';
  cFeatureBrowserEmulation = 'Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION\';
  cIE11 = 11001;
var
  Reg: TRegIniFile;
  sKey: string;
begin
  sKey := ExtractFileName(ParamStr(0));
  Reg := TRegIniFile.Create(cHomePath);
  try
    if Reg.OpenKey(cFeatureBrowserEmulation, True) and
      not(TRegistry(Reg).KeyExists(sKey) and (TRegistry(Reg).ReadInteger(sKey) = cIE11)) then
      TRegistry(Reg).WriteInteger(sKey, cIE11);
  finally
    Reg.Free;
  end;
end;
{$ENDIF}

end.
