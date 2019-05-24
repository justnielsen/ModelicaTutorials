within StreamConnectors.Sensors;
model MassFlow "Reads mass flow rate"

  Interfaces.FluidPort port_a annotation (Placement(transformation(extent={{-120,
            -10},{-100,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Interfaces.FluidPort port_b annotation (Placement(transformation(extent={{100,-10},
            {120,10}}),      iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput m annotation (Placement(transformation(
          extent={{-216,-2},{-196,18}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,90})));
equation
  // Balance equations
  port_a.m_flow + port_b.m_flow = 0;
  port_a.p = port_b.p;
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);


  m = port_a.m_flow;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{0,80},{0,20}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(points={{-100,0},{100,0}},   color={0,0,0}),
        Line(points={{-60,40},{-40,20},{42,20},{60,40}}, color={0,0,0}),
        Line(points={{-60,-40},{-40,-20},{42,-20},{60,-40}}, color={0,0,0})}),
                                                                    Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MassFlow;
