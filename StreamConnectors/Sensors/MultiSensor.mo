within StreamConnectors.Sensors;
model MultiSensor "Displays {p,T,m,h}"
  Real p, T, m, h;

  Interfaces.FluidPort port_a annotation (Placement(transformation(extent={{-120,
            -10},{-100,10}}),iconTransformation(extent={{-40,-70},{-20,-50}})));
  Interfaces.FluidPort port_b annotation (Placement(transformation(extent={{100,-10},
            {120,10}}),      iconTransformation(extent={{20,-70},{40,-50}})));
equation
  // Balance equations
  port_a.m_flow + port_b.m_flow = 0;
  port_a.p = port_b.p;
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  h = Modelica.Fluid.Utilities.regStep(
    m,
    port_b.h_outflow,
    port_a.h_outflow);
  m = port_a.m_flow;
  p = port_a.p;
  T = Functions.temperature_ph(p, h);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-20,-60},{20,-60}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{-100,100},{0,60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,100},{100,60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,60},{100,20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,60},{0,20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,20},{0,-60}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-94,98},{-2,62}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString=DynamicSelect("p [bar]", String(p, significantDigits=4))),
        Text(
          extent={{2,98},{96,62}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString=DynamicSelect("h [kJ/kg]", String(h, significantDigits=4))),
        Text(
          extent={{-94,56},{-2,20}},
          lineColor=DynamicSelect({0,0,0}, if m < 0 then {255,0,0} else {0,0,0}),
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString=DynamicSelect("m [kg/s]", String(m, significantDigits=4))),
        Text(
          extent={{2,56},{96,20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString=DynamicSelect("T [°C]", String(T, significantDigits=4))),
        Line(points={{-20,-80},{20,-80}}, color={0,0,0}),
        Line(points={{10,-74},{20,-80},{10,-86}}, color={0,0,0})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultiSensor;
