unit uEdges;

interface

uses FMX_Types, System.Types,contnrs, uNodes;

type
  TEdge = class(TObject)
    n1, n2: integer;
    procedure paint(Canvas: TCanvas; NodeList: TObjectList);
    constructor Create(n1, n2: integer);
  end;

implementation

constructor TEdge.Create(n1, n2: integer);
begin
  self.n1 := n1;
  self.n2 := n2;
end;

procedure TEdge.paint(Canvas: TCanvas; NodeList: TObjectList);
var
  p1, p2: TPointF;
  x1, y1, x2, y2: single;
begin
  Canvas.Stroke.Color := claBlue;
  Canvas.Stroke.Kind := TBrushKind.bkSolid;
  Canvas.StrokeThickness := 2;
  // Canvas.DrawEllipse(TRectF.Create (x, y, x+w, y+h), 0);
  x1 := (NodeList[n1] as TNode).x;
  y1 := (NodeList[n1] as TNode).y;
  x2 := (NodeList[n2] as TNode).x;
  y2 := (NodeList[n2] as TNode).y;
  p1 := TPointF.Create(x1, y1);
  p2 := TPointF.Create(x2, y2);

  Canvas.DrawLine(p1, p2, 100);

  // Canvas.FillRect(RectF(x, y, w, h), 4, 4, AllCorners, 50);
end;

end.
