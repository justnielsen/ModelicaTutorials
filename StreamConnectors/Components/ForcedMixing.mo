within StreamConnectors.Components;
model ForcedMixing
  Interfaces.FluidPort port_a1 annotation (Placement(
        transformation(extent={{-110,50},{-90,70}}),  iconTransformation(extent=
           {{-120,50},{-100,70}})));
  Interfaces.FluidPort port_a2 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent=
           {{-120,-10},{-100,10}})));
  Interfaces.FluidPort port_a3 annotation (Placement(
        transformation(extent={{-110,-70},{-90,-50}}),iconTransformation(extent=
           {{-120,-70},{-100,-50}})));
  Interfaces.FluidPort port_b1 annotation (Placement(
        transformation(extent={{90,30},{110,50}}),    iconTransformation(extent=
           {{100,30},{120,50}})));
  Interfaces.FluidPort port_b2 annotation (Placement(
        transformation(extent={{90,-50},{110,-30}}),  iconTransformation(extent=
           {{100,-50},{120,-30}})));
equation
  // pressures
  port_a1.p = port_a2.p;
  port_a1.p = port_a3.p;

  // mass
//   0 = port_a1.m_flow + port_a2.m_flow + port_a2.m_flow + port_b1.m_flow +
//     port_b2.m_flow;

   port_b1.m_flow = 0.25*port_a1.m_flow + 0.5*port_a2.m_flow + 0.75*port_a3.m_flow;
   port_b2.m_flow = 0.75*port_a1.m_flow + 0.5*port_a2.m_flow + 0.25*port_a3.m_flow;

  // energy
  0 = port_a1.m_flow*actualStream(port_a1.h_outflow) + port_a2.m_flow*
    actualStream(port_a2.h_outflow) + port_a2.m_flow*actualStream(port_a3.h_outflow)
     + port_b1.m_flow*actualStream(port_b1.h_outflow) + port_b2.m_flow*
    actualStream(port_b2.h_outflow);

  // outflow
  port_a1.h_outflow = port_b1.h_outflow;
  port_a2.h_outflow = port_b1.h_outflow;
  port_a2.h_outflow = port_b1.h_outflow;
  port_b2.h_outflow = port_b1.h_outflow;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-60},{60,40}}, color={28,108,200}),
        Line(points={{-80,60},{60,-40}}, color={28,108,200}),
        Line(points={{40,40},{60,40},{54,22}}, color={28,108,200}),
        Line(points={{54,-22},{60,-40},{40,-40}}, color={28,108,200}),
        Line(points={{-80,0},{-14,0}}, color={28,108,200}),
        Line(points={{-34,10},{-14,0},{-34,-10}}, color={28,108,200})}));
end ForcedMixing;
