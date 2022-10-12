within StreamConnectors.Components.MIMO;
model ForcedSplitting_nonPhysical
  "Forced splitting using non-physical equations"
  Interfaces.FluidPort port_a annotation (Placement(transformation(extent=
           {{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},
            {-100,10}})));
  Interfaces.FluidPort port_b annotation (Placement(transformation(extent=
           {{100,50},{120,70}}), iconTransformation(extent={{100,50},{120,
            70}})));
  Interfaces.FluidPort port_c annotation (Placement(transformation(extent=
           {{100,-70},{120,-50}}), iconTransformation(extent={{100,-70},{120,
            -50}})));
equation
  // Overall mass balance
  0 = port_a.m_flow + port_b.m_flow + port_c.m_flow;

  // Split mass balance
  0 = 0.25*port_a.m_flow + port_b.m_flow;

  // Enthalpy outflow assignments
  port_b.h_outflow = inStream(port_a.h_outflow);
  port_c.h_outflow = inStream(port_a.h_outflow);
  port_a.h_outflow = 0;
  // some dummy value, since flow never reverses

  // Pressure balance
  port_a.p = port_b.p;
  /* Note: only one pressure balance can be implemented. 
  Otherwise, equating all three port pressures will make the model overdetermined since:
  1) you cannot connect two pressure boundaries to port_b and port_c since their 
  fixed pressures will violate the internal pressure balances, saying that port_b = port_c.
  2) you cannot connect a pressure and a mass flow boundary to port_b and port_c
  since their fixed mass flow rates will violate the internal mass balances.
  */
  //port_a.p = port_c.p; // hence, this pressure balance is, arbitrarily, omitted.

  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
        graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={28,108,200},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Line(points={{-80,0},{-40,0},
          {0,60},{80,60}}, color={28,108,200}),Line(points={{-80,0},{-40,0},
          {0,-60},{80,-60}}, color={28,108,200}),Line(points={{66,66},{80,
          60},{66,54}}, color={28,108,200}),Line(points={{66,-54},{80,-60},
          {66,-66}}, color={28,108,200}),Text(
                extent={{20,50},{60,30}},
                lineColor={28,108,200},
                textString="x"),Text(
                extent={{20,-30},{60,-50}},
                lineColor={28,108,200},
                textString="y")}), Diagram(coordinateSystem(extent={{-100,
            -100},{100,100}})));
end ForcedSplitting_nonPhysical;
