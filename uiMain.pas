unit uiMain;

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls,
  FMX_Forms, FMX_Dialogs, FMX_Objects, FMX_Layouts, FMX_Memo, FMX_Edit,
  uNodes, uEdges, contnrs, uFunctions;

type

  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    CalloutPanel1: TCalloutPanel;
    ClearingEdit1: TClearingEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboTrackBar1: TComboTrackBar;
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: single);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
      x, y: single);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: single);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PaintBox1DblClick(Sender: TObject);
    procedure ComboTrackBar1Change(Sender: TObject);
    procedure ClearingEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Node: TNode;
    NodeList: TObjectList;
    EdgeList: TObjectList;
    NodeSelectedIndex: integer;
    NodeMove: Boolean;
    NodeAddEdgeIndex1: integer;
    NodeAddEdgeIndex2: integer;
    StateAddNode: integer;
    StateAddEdge: integer;
    nodeW: integer;
    nodeH: integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


// detects if coordinates are within a node
// Returns index of node if it is, -1 otherwise
function isNode(x, y: single; NodeList: TObjectList): integer;
var
  I: integer;
begin
  for I := 0 to NodeList.Count - 1 do
    // if (x > (NodeList[I] as TNode).x) and (x < (NodeList[I] as TNode).w) and
    // (y > (NodeList[I] as TNode).y) and (y < (NodeList[I] as TNode).h) then
    if (x > (NodeList[I] as TNode).x - (NodeList[I] as TNode).w) and
      (x < (NodeList[I] as TNode).x + (NodeList[I] as TNode).w) and
      (y > (NodeList[I] as TNode).y - (NodeList[I] as TNode).h) and
      (y < (NodeList[I] as TNode).y + (NodeList[I] as TNode).h) then
    begin
      Result := I;
      Exit;
    end
    else
      Result := -1;
  Result := -1;
end;

// detects if coordinates are within an edge
// Returns index of edge if it is, -1 otherwise
// function isEdge(x, y: single; NodeList: TObjectList, EdgeList: TObjectList): integer;
// var
// I: integer;
// begin
// for I := 0 to NodeList.Count - 1 do
// // if (x > (NodeList[I] as TNode).x) and (x < (NodeList[I] as TNode).w) and
// // (y > (NodeList[I] as TNode).y) and (y < (NodeList[I] as TNode).h) then
// if (x > (NodeList[I] as TNode).x - (NodeList[I] as TNode).w) and
// (x < (NodeList[I] as TNode).x + (NodeList[I] as TNode).w) and
// (y > (NodeList[I] as TNode).y - (NodeList[I] as TNode).h) and
// (y < (NodeList[I] as TNode).y + (NodeList[I] as TNode).h) then
// begin
// Result := I;
// Exit;
// end
// else
// Result := -1;
// Result := -1;
// end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  if StateAddNode = -1 then
  begin
    StateAddNode := 1;
    Button1.Text := 'Stop Add Node';
    StateAddEdge := -1;
    Button2.Text := 'Add Edge';
    PaintBox1.Repaint;
  end
  else
  begin
    Button1.Text := 'Add Node';
    StateAddNode := -1;
    PaintBox1.Repaint;
  end
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if StateAddEdge = -1 then
  begin
    StateAddNode := -1;
    Button1.Text := 'Add Node';
    NodeSelectedIndex := -1;
    StateAddEdge := 1;
    Button2.Text := 'Stop Add Edge';
  end
  else
  begin
    StateAddEdge := -1;
    Button2.Text := 'Add Edge';
    NodeSelectedIndex := -1;

  end
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  NodeList.Clear;
  EdgeList.Clear;
  Memo1.Text := '';
  PaintBox1.Repaint;
end;

procedure TForm1.ClearingEdit1Change(Sender: TObject);
begin
  (NodeList[NodeSelectedIndex] as TNode).name := ClearingEdit1.Text;
end;

procedure TForm1.ComboTrackBar1Change(Sender: TObject);
begin
  (NodeList[NodeSelectedIndex] as TNode).value :=
    StrToFloat(ComboTrackBar1.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: integer;
  x, y: single;
  Node: TNode;

begin
  // Setting States
  NodeMove := False;
  NodeSelectedIndex := -1;
  StateAddNode := -1;
  StateAddEdge := -1;
  NodeAddEdgeIndex1 := -1;
  NodeAddEdgeIndex2 := -1;
  // Creating object structures and setting global params
  NodeList := TObjectList.Create();
  EdgeList := TObjectList.Create();
  nodeW := 30;
  nodeH := 30;

  // Setting visual components
  CalloutPanel1.Visible := False;
  Form1.ClientHeight

  // Node := TNode.Create(10, 10, 10 + 30, 10 + 30);
  // NodeList.Add(Node);

  // for I := 0 to 9 do
  // begin
  // x := Random(100);
  // y := Random(100);
  // Node := TNode.Create(x, y, x + nodeW, y + nodeH);
  // NodeList.Add(Node);
  // end;

end;

procedure TForm1.PaintBox1DblClick(Sender: TObject);
begin
  if NodeSelectedIndex <> -1 then
  begin
    NodeMove := False;
    CalloutPanel1.Visible := True;
    Label2.Text := (NodeList[NodeSelectedIndex] as TNode).name;
    CalloutPanel1.Position.x := (NodeList[NodeSelectedIndex] as TNode).x - 85;
    CalloutPanel1.Position.y := (NodeList[NodeSelectedIndex] as TNode).y;
    ClearingEdit1.Text := (NodeList[NodeSelectedIndex] as TNode).name;
    ComboTrackBar1.Text :=
      FloatToStr((NodeList[NodeSelectedIndex] as TNode).value);
  end;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: single);
var
  I: integer;
begin
  // Reset Node Selection
  NodeSelectedIndex := -1;
  NodeMove := False;
  // Add node
  if StateAddNode = 1 then
  begin
    Node := TNode.Create(x, y, nodeW, nodeH, 'N' + IntToStr(NodeList.Count), 0);
    NodeList.Add(Node);
  end
  // Add Edge
  else if StateAddEdge = 1 then
    if NodeAddEdgeIndex1 = -1 then
    begin
      NodeAddEdgeIndex1 := isNode(x, y, NodeList);
      if NodeAddEdgeIndex1 <> -1 then
        Memo1.Text := 'Selected ' + (NodeList[NodeAddEdgeIndex1] as TNode).name
          + ' to add edge. Select next node to finish edge.';
    end
    else if NodeAddEdgeIndex2 = -1 then
    begin
      NodeAddEdgeIndex2 := isNode(x, y, NodeList);
      if NodeAddEdgeIndex2 <> -1 then
      begin
        EdgeList.Add(TEdge.Create(NodeAddEdgeIndex1, NodeAddEdgeIndex2));
        Memo1.Text := 'Added edge from ' +
          (NodeList[NodeAddEdgeIndex1] as TNode).name + ' to ' +
          (NodeList[NodeAddEdgeIndex2] as TNode).name + '.';
      end;
      NodeAddEdgeIndex1 := -1;
      NodeAddEdgeIndex2 := -1;
    end
    else
      NodeSelectedIndex := isNode(x, y, NodeList)
      // redundant not sure how to get ride of
  else
  begin
    NodeSelectedIndex := isNode(x, y, NodeList);
    if NodeSelectedIndex <> -1 then
    begin
      NodeMove := True;
      Memo1.Text := 'Selected ' + (NodeList[NodeSelectedIndex] as TNode).name;
    end
    else
    begin
      CalloutPanel1.Visible := False;
      Memo1.Text := '';
    end;
  end;
  PaintBox1.Repaint;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  x, y: single);
begin
  if (NodeSelectedIndex <> -1) and NodeMove then
  begin
    (NodeList[NodeSelectedIndex] as TNode).x := x;
    (NodeList[NodeSelectedIndex] as TNode).y := y;
    (NodeList[NodeSelectedIndex] as TNode).w := nodeW;
    (NodeList[NodeSelectedIndex] as TNode).h := nodeH;
    Memo1.Text := 'Dragging node to (' + FloatToStr(x) + ', ' +
      FloatToStr(y) + ')';
  end;
  PaintBox1.Repaint;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: single);
begin
  NodeMove := False;
  // NodeSelectedIndex := -1;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
var
  I: integer;
begin
  Canvas.Font.Style := Label1.Font.Style;
  Canvas.Font.Size := Label1.Font.Size;
  Canvas.Font.Family := Label1.Font.Family;
  for I := 0 to EdgeList.Count - 1 do
    (EdgeList[I] as TEdge).paint(Canvas, NodeList);
  for I := 0 to NodeList.Count - 1 do
    (NodeList[I] as TNode).paint(Canvas);
end;

end.
