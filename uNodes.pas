unit uNodes;

interface

uses FMX_Types, Types;

type
  TNode = class(TObject)
    name: string; // name
    x, y: single; // center
    w, h: single; // height and width
    value: double; // concentration or amount
    procedure paint(Canvas: TCanvas);
    constructor Create(x, y, w, h: single; name: string; value: double);
  end;

implementation

constructor TNode.Create(x, y, w, h: single; name: string; value: double);
begin
  self.x := x;
  self.y := y;
  self.w := w;
  self.h := h;
  self.name := name;
  self.value := value;
end;

procedure TNode.paint(Canvas: TCanvas);
begin
  // Canvas.Stroke.Color := claBlue;
  Canvas.Fill.Kind := TBrushKind.bkSolid;
  Canvas.Fill.Color := claRed; // TAlphaColors.Red;
  // Canvas.Fill.Kind := TBrushKind.bkGradient;
  // Canvas.Fill.Gradient.Points := TGradientPoints(TGradientPoint.Create();
  // Canvas.Fill.Gradient.Color := TAlphaColorRec.Beige;
  // Canvas.Fill.Gradient.Color1 := TAlphaColorRec.Red;

  // Canvas.Fill.Gradient.Style := TGradientStyle.gsRadial;
  // Canvas.FillEllipse(RectF(x, y, w, h), 50);
  Canvas.StrokeThickness := 2;
  Canvas.Stroke.Kind := TBrushKind.bkSolid;
  Canvas.StrokeDash := TStrokeDash.sdSolid;
  Canvas.Stroke.Color := claBlack; // TAlphaColors.Black;
  // Canvas.FillRect(RectF(x - w, y - h, x + w, y + h), 4, 4, AllCorners, 50);
  // Canvas.DrawRect(RectF(x - w, y - h, x + w, y + h), 4, 4, AllCorners, 50);
  Canvas.FillEllipse(RectF(x - w, y - h, x + w, y + h), 50);
  Canvas.DrawEllipse(RectF(x - w, y - h, x + w, y + h), 50);

  Canvas.Fill.Color := claBlack; // TAlphaColors.Black;

  Canvas.Fill.Kind := TBrushKind.bkSolid;
  Canvas.FillText(RectF(x - w, y - h, x + w, y + h), name, True, 100, [],
    TTextAlign.taCenter, TTextAlign.taCenter);
  // Canvas.FillText(RectF(x - w, y - h, x + w, y + h), name, True, 100,
  // TFillTextFlags(TFillTextFlag.ftRightToLeft));

end;

end.
