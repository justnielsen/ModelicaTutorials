within StreamConnectors.Examples.MIMO;
model ForcedSplitting_nonPhysical
  "Forced splitting using non-physical equations"
  extends Modelica.Icons.Example;

  replaceable Components.MIMO.ForcedSplitting_nonPhysical splitter
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Sources.MassFlowBoundary_h massFlowBoundary(m_flow=ramp.y, h=50)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Sources.PressureBoundary_h pressureBoundary_b
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Sources.PressureBoundary_h pressureBoundary_c
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=3,
    duration=10,
    offset=1,
    startTime=20)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(massFlowBoundary.port, splitter.port_a)
    annotation (Line(points={{-19,0},{9,0}}, color={0,0,0}));
  connect(splitter.port_b, pressureBoundary_b.port)
    annotation (Line(points={{31,6},{50,6},{50,30},{59,30}}, color={0,0,0}));
  connect(splitter.port_c, pressureBoundary_c.port) annotation (Line(points={{31,
          -6},{50,-6},{50,-30},{59,-30}}, color={0,0,0}));
  annotation (Diagram(graphics={                         Text(
          extent={{-98,98},{-40,92}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          textString="What to observe:",
          horizontalAlignment=TextAlignment.Left),Text(
          extent={{-98,92},{0,80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          horizontalAlignment=TextAlignment.Left,
          textString="- An inlet flow is applied. Outlet flows are 0.25 and 0.75 times the inlet flow respectively.
- After 20 seconds the inlet flow is increased: the flow split is maintained."),
        Line(
          points={{-56,0},{-42,0}},
          color={238,46,47},
          pattern=LinePattern.Dash)}), Documentation(info="<html>
<p><img src=\"modelica://StreamConnectors/Resources/Images/Examples/ForcedSplitting_nonPhysical.png\"/></p>
</html>"));
end ForcedSplitting_nonPhysical;
