within StreamConnectors.Examples.MIMO;
model ForcedSplixing_nonPhysical
  "Forced splitting/mixing using non-physical equations"
  extends Modelica.Icons.Example;
  replaceable Components.MIMO.ForcedSplixing_nonPhysical splitterMixer
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Sources.MassFlowBoundary_h massFlowBoundary_h(m_flow=ramp_a1.y,
                                                          h=50)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Sources.MassFlowBoundary_h massFlowBoundary_h1(m_flow=ramp_a2.y,
                                                           h=60)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Sources.MassFlowBoundary_h massFlowBoundary_h2(m_flow=ramp_a3.y,
                                                           h=40)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Sources.PressureBoundary_h pressureBoundary_h
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Sources.PressureBoundary_h pressureBoundary_h1
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Modelica.Blocks.Sources.Ramp ramp_a1(
    height=1,
    duration=10,
    offset=1,
    startTime=20)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Ramp ramp_a2(
    height=2,
    duration=10,
    offset=2,
    startTime=20)
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  Modelica.Blocks.Sources.Ramp ramp_a3(
    height=4,
    duration=10,
    offset=4,
    startTime=20)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
equation
  connect(massFlowBoundary_h.port, splitterMixer.port_a1)
    annotation (Line(points={{-19,50},{-10,50},{-10,6},{9,6}}, color={0,0,0}));
  connect(massFlowBoundary_h1.port, splitterMixer.port_a2)
    annotation (Line(points={{-19,0},{9,0}}, color={0,0,0}));
  connect(massFlowBoundary_h2.port, splitterMixer.port_a3) annotation (Line(
        points={{-19,-50},{-10,-50},{-10,-6},{9,-6}}, color={0,0,0}));
  connect(splitterMixer.port_b1, pressureBoundary_h.port)
    annotation (Line(points={{31,4},{50,4},{50,30},{59,30}}, color={0,0,0}));
  connect(splitterMixer.port_b2, pressureBoundary_h1.port) annotation (Line(
        points={{31,-4},{50,-4},{50,-30},{59,-30}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-56,50},{-42,50}},
          color={238,46,47},
          pattern=LinePattern.Dash),
        Line(
          points={{-56,50},{-42,50}},
          color={238,46,47},
          pattern=LinePattern.Dash),
        Line(
          points={{-58,0},{-44,0}},
          color={238,46,47},
          pattern=LinePattern.Dash),
        Line(
          points={{-58,0},{-44,0}},
          color={238,46,47},
          pattern=LinePattern.Dash),
        Line(
          points={{-56,-50},{-42,-50}},
          color={238,46,47},
          pattern=LinePattern.Dash),
        Line(
          points={{-56,-50},{-42,-50}},
          color={238,46,47},
          pattern=LinePattern.Dash)}),
    experiment(StopTime=100),
    Documentation(info="<html>
<p><img src=\"modelica://StreamConnectors/Resources/Images/Examples/ForcedSplixing_nonPhysical.png\"/></p>
</html>"));
end ForcedSplixing_nonPhysical;
