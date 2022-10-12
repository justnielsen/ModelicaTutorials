within StreamConnectors.Components.MIMO;
model ForcedSplixing_nonPhysical
  "Forced splitting/mixing using non-physical equations"
  Interfaces.FluidPort port_a1 annotation (Placement(transformation(
          extent={{-110,50},{-90,70}}), iconTransformation(extent={{-120,50},
            {-100,70}})));
  Interfaces.FluidPort port_a2 annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-120,
            -10},{-100,10}})));
  Interfaces.FluidPort port_a3 annotation (Placement(transformation(
          extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-120,
            -70},{-100,-50}})));
  Interfaces.FluidPort port_b1 annotation (Placement(transformation(
          extent={{90,30},{110,50}}), iconTransformation(extent={{100,30},
            {120,50}})));
  Interfaces.FluidPort port_b2 annotation (Placement(transformation(
          extent={{90,-50},{110,-30}}), iconTransformation(extent={{100,-50},
            {120,-30}})));
equation
  // Mass balance, port_b1
  0 = port_b1.m_flow + 0.25*port_a1.m_flow + 0.5*port_a2.m_flow + 0.75*
    port_a3.m_flow;

  // Energy balance, port_b1
  0 = port_b1.m_flow*port_b1.h_outflow + 0.25*port_a1.m_flow*inStream(
    port_a1.h_outflow) + 0.5*port_a2.m_flow*inStream(port_a2.h_outflow) +
    0.75*port_a3.m_flow*inStream(port_a3.h_outflow);

  // Mass balance, port_b2
  0 = port_b2.m_flow + 0.75*port_a1.m_flow + 0.5*port_a2.m_flow + 0.25*
    port_a3.m_flow;

  // Energy balance, port_b2
  0 = port_b2.m_flow*port_b2.h_outflow + 0.75*port_a1.m_flow*inStream(
    port_a1.h_outflow) + 0.5*port_a2.m_flow*inStream(port_a2.h_outflow) +
    0.25*port_a3.m_flow*inStream(port_a3.h_outflow);

  // Momentum balances — no pressure drop
  // port_b1 and port_b2 pressures must not be equal, since connecting downstream
  // pressure boundaries will then over-determine equations.
  port_a1.p = port_b1.p;
  port_a2.p = port_b1.p;
  port_a3.p = port_b1.p;

  // dummy outflow assignments (flow never reverses)
  port_a1.h_outflow = 0;
  port_a2.h_outflow = 0;
  port_a3.h_outflow = 0;

  annotation (Icon(graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={28,108,200},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Line(points={{-80,-60},{60,
          40}}, color={28,108,200}),Line(points={{-80,60},{60,-40}},
          color={28,108,200}),Line(points={{40,40},{60,40},{54,22}},
          color={28,108,200}),Line(points={{54,-22},{60,-40},{40,-40}},
          color={28,108,200}),Line(points={{-80,0},{-14,0}}, color={28,108,
          200}),Line(points={{-34,10},{-14,0},{-34,-10}}, color={28,108,200})}),
      Diagram(graphics={Line(points={{-80,60},{80,40}}, color={244,125,35}),
          Line(points={{-80,0},{80,40}}, color={244,125,35}),Line(points={
          {-80,-60},{80,40}}, color={244,125,35}),Line(points={{-80,0},{80,
          -40}}, color={0,140,72}),Line(points={{-80,60},{80,-40}}, color=
          {0,140,72}),Line(points={{-80,-60},{80,-40}}, color={0,140,72}),
          Text( extent={{-14,70},{80,52}},
                lineColor={244,125,35},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                textString="mass flow and enthalpy leaving port_b1 only depends on mass flows
and enthalpies from ports a1–a3, not port_b2",
                horizontalAlignment=TextAlignment.Left),Text(
                extent={{-14,-50},{80,-68}},
                lineColor={0,140,72},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                horizontalAlignment=TextAlignment.Left,
                textString="mass flow and enthalpy leaving port_b2 only depends on mass flows
and enthalpies from ports a1–a3, not port_b1"),
                                           Text(
                extent={{30,8},{104,-8}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                horizontalAlignment=TextAlignment.Left,
                textString="port_b1 and port_b2 mass and energy balances can
be treated separately")}));
end ForcedSplixing_nonPhysical;
