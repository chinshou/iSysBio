program iSysBio;

uses
  FMX_Forms,
  uiMain in 'uiMain.pas' {Form1},
  uNodes in 'uNodes.pas',
  uEdges in 'uEdges.pas',
  uFunctions in 'uFunctions.pas',
  fView in 'fView.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
