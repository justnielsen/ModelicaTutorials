within StreamConnectors.Components;
package MIMO "Thermo-hydraulic MIMO models — physical and non-physical"
  model ForcedSplixing_nonPhysical
    "Forced splitting/mixing using non-physical equations"
    Interfaces.FluidPort port_a1 annotation (Placement(transformation(extent={{-110,
              50},{-90,70}}), iconTransformation(extent={{-120,50},{-100,70}})));
    Interfaces.FluidPort port_a2 annotation (Placement(transformation(extent={{-110,
              -10},{-90,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Interfaces.FluidPort port_a3 annotation (Placement(transformation(extent={{-110,
              -70},{-90,-50}}), iconTransformation(extent={{-120,-70},{-100,-50}})));
    Interfaces.FluidPort port_b1 annotation (Placement(transformation(extent={{90,
              30},{110,50}}), iconTransformation(extent={{100,30},{120,50}})));
    Interfaces.FluidPort port_b2 annotation (Placement(transformation(extent={{90,
              -50},{110,-30}}), iconTransformation(extent={{100,-50},{120,-30}})));
  equation
    // Mass balance, port_b1
    0 = port_b1.m_flow + 0.25*port_a1.m_flow + 0.5*port_a2.m_flow + 0.75*
      port_a3.m_flow;

    // Energy balance, port_b1
    0 = port_b1.m_flow*port_b1.h_outflow + 0.25*port_a1.m_flow*inStream(port_a1.h_outflow)
       + 0.5*port_a2.m_flow*inStream(port_a2.h_outflow) + 0.75*port_a3.m_flow*
      inStream(port_a3.h_outflow);

    // Mass balance, port_b2
    0 = port_b2.m_flow + 0.75*port_a1.m_flow + 0.5*port_a2.m_flow + 0.25*
      port_a3.m_flow;

    // Energy balance, port_b2
    0 = port_b2.m_flow*port_b2.h_outflow + 0.75*port_a1.m_flow*inStream(port_a1.h_outflow)
       + 0.5*port_a2.m_flow*inStream(port_a2.h_outflow) + 0.25*port_a3.m_flow*
      inStream(port_a3.h_outflow);

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
          Line(points={{-34,10},{-14,0},{-34,-10}}, color={28,108,200})}),
        Diagram(graphics={Line(points={{-80,60},{80,40}}, color={244,125,35}),
            Line(points={{-80,0},{80,40}}, color={244,125,35}),Line(points={{-80,
            -60},{80,40}}, color={244,125,35}),Line(points={{-80,0},{80,-40}},
            color={0,140,72}),Line(points={{-80,60},{80,-40}}, color={0,140,72}),
            Line(points={{-80,-60},{80,-40}}, color={0,140,72}),Text(
              extent={{-14,70},{80,52}},
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
and enthalpies from ports a1–a3, not port_b1"),Text(
              extent={{30,8},{104,-8}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Left,
              textString="port_b1 and port_b2 mass and energy balances can
be treated separately")}));
  end ForcedSplixing_nonPhysical;

  model ForcedSplixing_physical
    "Forced splitting/mixing using physical components"
    Interfaces.FluidPort port_a1 annotation (Placement(transformation(extent={{-110,
              90},{-90,110}}), iconTransformation(extent={{-120,50},{-100,70}})));
    Interfaces.FluidPort port_a2 annotation (Placement(transformation(extent={{-110,
              30},{-90,50}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Interfaces.FluidPort port_a3 annotation (Placement(transformation(extent={{-110,
              -30},{-90,-10}}), iconTransformation(extent={{-120,-70},{-100,-50}})));
    Interfaces.FluidPort port_b1 annotation (Placement(transformation(extent={{90,
              30},{110,50}}), iconTransformation(extent={{100,30},{120,50}})));
    Interfaces.FluidPort port_b2 annotation (Placement(transformation(extent={{90,
              -110},{110,-90}}), iconTransformation(extent={{100,-50},{120,-30}})));
    Valve valve_a1b1(dp_nominal=1, m_flow_nominal=0.25)
      annotation (Placement(transformation(extent={{30,90},{50,110}})));
    Valve valve_a2b1(dp_nominal=1, m_flow_nominal=0.5)
      annotation (Placement(transformation(extent={{30,30},{50,50}})));
    Valve valve_a3b1(dp_nominal=1, m_flow_nominal=0.75)
      annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
    Sensors.MassFlow massFlow_a1
      annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
    Sensors.MassFlow massFlow_a2
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Sensors.MassFlow massFlow_a3
      annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
    Modelica.Blocks.Continuous.LimPID PID_a1b1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.InitPID.InitialOutput,
      y_start=0.5) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={0,130})));
    Modelica.Blocks.Math.Gain gain(k=0.25)
      annotation (Placement(transformation(extent={{-26,124},{-14,136}})));
    Modelica.Blocks.Math.Gain gain1(k=0.5)
      annotation (Placement(transformation(extent={{-26,64},{-14,76}})));
    Modelica.Blocks.Continuous.LimPID PID_a2b1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.InitPID.InitialOutput,
      y_start=0.5) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={0,70})));
    Modelica.Blocks.Math.Gain gain2(k=0.75)
      annotation (Placement(transformation(extent={{-26,4},{-14,16}})));
    Modelica.Blocks.Continuous.LimPID PID_a3b1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.InitPID.InitialOutput,
      y_start=0.5) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={0,10})));
    Valve valve_a1b2(dp_nominal=1, m_flow_nominal=0.75)
      annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
    Valve valve_a2b2(dp_nominal=1, m_flow_nominal=0.5)
      annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
    Valve valve_a3b2(dp_nominal=1, m_flow_nominal=0.25)
      annotation (Placement(transformation(extent={{30,-150},{50,-130}})));
    Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={40,-40})));
    Modelica.Blocks.Sources.Constant const1(k=1) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={40,-80})));
    Modelica.Blocks.Sources.Constant const2(k=1) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={40,-120})));
    Sensors.MassFlow massFlow_a3b1
      annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
    Sensors.MassFlow massFlow_a2b1
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
    Sensors.MassFlow massFlow_a1b1
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    Sensors.MassFlow massFlow_a3b2
      annotation (Placement(transformation(extent={{-10,-150},{10,-130}})));
    Sensors.MassFlow massFlow_a2b2
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Sensors.MassFlow massFlow_a1b2
      annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  equation

    connect(port_a1, massFlow_a1.port_a)
      annotation (Line(points={{-100,100},{-80,100}}, color={0,0,0}));
    connect(port_a3, massFlow_a3.port_a)
      annotation (Line(points={{-100,-20},{-80,-20}}, color={0,0,0}));
    connect(port_a2, massFlow_a2.port_a)
      annotation (Line(points={{-100,40},{-80,40}}, color={0,0,0}));
    connect(massFlow_a1.m, gain.u) annotation (Line(points={{-70,109},{-70,130},
            {-27.2,130}}, color={0,0,127}));
    connect(valve_a1b1.u, PID_a1b1.y)
      annotation (Line(points={{40,108},{40,130},{6.6,130}}, color={0,0,127}));
    connect(massFlow_a3.m, gain2.u) annotation (Line(points={{-70,-11},{-70,10},
            {-27.2,10}}, color={0,0,127}));
    connect(massFlow_a2.m, gain1.u) annotation (Line(points={{-70,49},{-70,70},{
            -27.2,70}}, color={0,0,127}));
    connect(PID_a2b1.y, valve_a2b1.u)
      annotation (Line(points={{6.6,70},{40,70},{40,48}}, color={0,0,127}));
    connect(PID_a3b1.y, valve_a3b1.u)
      annotation (Line(points={{6.6,10},{40,10},{40,-12}}, color={0,0,127}));
    connect(valve_a1b2.u, const.y) annotation (Line(points={{40,-52},{42,-52},{42,
            -50},{40,-50},{40,-46.6}}, color={0,0,127}));
    connect(valve_a2b2.u, const1.y) annotation (Line(points={{40,-92},{42,-92},{
            42,-90},{40,-90},{40,-86.6}}, color={0,0,127}));
    connect(valve_a3b2.u, const2.y) annotation (Line(points={{40,-132},{42,-132},
            {42,-130},{40,-130},{40,-126.6}}, color={0,0,127}));
    connect(massFlow_a1.port_b, massFlow_a1b1.port_a)
      annotation (Line(points={{-60,100},{-10,100}}, color={0,0,0}));
    connect(massFlow_a1b1.port_b, valve_a1b1.port_a)
      annotation (Line(points={{10,100},{29,100}}, color={0,0,0}));
    connect(massFlow_a2.port_b, massFlow_a2b1.port_a)
      annotation (Line(points={{-60,40},{-10,40}}, color={0,0,0}));
    connect(massFlow_a2b1.port_b, valve_a2b1.port_a)
      annotation (Line(points={{10,40},{29,40}}, color={0,0,0}));
    connect(massFlow_a3.port_b, massFlow_a3b1.port_a)
      annotation (Line(points={{-60,-20},{-10,-20}}, color={0,0,0}));
    connect(massFlow_a3b1.port_b, valve_a3b1.port_a)
      annotation (Line(points={{10,-20},{29,-20}}, color={0,0,0}));
    connect(massFlow_a3.port_b, massFlow_a3b2.port_a) annotation (Line(points={{
            -60,-20},{-44,-20},{-44,-140},{-10,-140}}, color={0,0,0}));
    connect(massFlow_a3b2.port_b, valve_a3b2.port_a)
      annotation (Line(points={{10,-140},{29,-140}}, color={0,0,0}));
    connect(massFlow_a2.port_b, massFlow_a2b2.port_a) annotation (Line(points={{
            -60,40},{-40,40},{-40,-100},{-10,-100}}, color={0,0,0}));
    connect(massFlow_a2b2.port_b, valve_a2b2.port_a)
      annotation (Line(points={{10,-100},{29,-100}}, color={0,0,0}));
    connect(massFlow_a1.port_b, massFlow_a1b2.port_a) annotation (Line(points={{
            -60,100},{-36,100},{-36,-60},{-10,-60}}, color={0,0,0}));
    connect(massFlow_a1b2.port_b, valve_a1b2.port_a)
      annotation (Line(points={{10,-60},{29,-60}}, color={0,0,0}));
    connect(valve_a1b1.port_b, port_b1) annotation (Line(points={{51,100},{70,100},
            {70,40},{100,40}}, color={0,0,0}));
    connect(valve_a2b1.port_b, port_b1)
      annotation (Line(points={{51,40},{100,40}}, color={0,0,0}));
    connect(valve_a3b1.port_b, port_b1) annotation (Line(points={{51,-20},{70,-20},
            {70,40},{100,40}}, color={0,0,0}));
    connect(gain1.y, PID_a2b1.u_s)
      annotation (Line(points={{-13.4,70},{-7.2,70}}, color={0,0,127}));
    connect(PID_a1b1.u_s, gain.y)
      annotation (Line(points={{-7.2,130},{-13.4,130}}, color={0,0,127}));
    connect(PID_a3b1.u_s, gain2.y)
      annotation (Line(points={{-7.2,10},{-13.4,10}}, color={0,0,127}));
    connect(massFlow_a2b1.m, PID_a2b1.u_m)
      annotation (Line(points={{0,49},{0,62.8}}, color={0,0,127}));
    connect(massFlow_a1b1.m, PID_a1b1.u_m)
      annotation (Line(points={{0,109},{0,122.8}}, color={0,0,127}));
    connect(massFlow_a3b1.m, PID_a3b1.u_m)
      annotation (Line(points={{0,-11},{0,2.8}}, color={0,0,127}));
    connect(valve_a2b2.port_b, port_b2)
      annotation (Line(points={{51,-100},{100,-100}}, color={0,0,0}));
    connect(valve_a1b2.port_b, port_b2) annotation (Line(points={{51,-60},{70,-60},
            {70,-100},{100,-100}}, color={0,0,0}));
    connect(valve_a3b2.port_b, port_b2) annotation (Line(points={{51,-140},{70,-140},
            {70,-100},{100,-100}}, color={0,0,0}));
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
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
          Line(points={{-34,10},{-14,0},{-34,-10}}, color={28,108,200})}),
        Diagram(coordinateSystem(extent={{-100,-160},{100,160}})));
  end ForcedSplixing_physical;

  model ForcedSplitting_nonPhysical
    "Forced splitting using non-physical equations"
    Interfaces.FluidPort port_a annotation (Placement(transformation(extent={{-120,
              -10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Interfaces.FluidPort port_b annotation (Placement(transformation(extent={{100,
              50},{120,70}}), iconTransformation(extent={{100,50},{120,70}})));
    Interfaces.FluidPort port_c annotation (Placement(transformation(extent={{100,
              -70},{120,-50}}), iconTransformation(extent={{100,-70},{120,-50}})));
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

    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{-40,0},{0,60},{80,60}}, color={28,108,200}),
          Line(points={{-80,0},{-40,0},{0,-60},{80,-60}}, color={28,108,200}),
          Line(points={{66,66},{80,60},{66,54}}, color={28,108,200}),
          Line(points={{66,-54},{80,-60},{66,-66}}, color={28,108,200}),
          Text(
            extent={{20,50},{60,30}},
            lineColor={28,108,200},
            textString="x"),
          Text(
            extent={{20,-30},{60,-50}},
            lineColor={28,108,200},
            textString="y")}), Diagram(coordinateSystem(extent={{-100,-100},{100,
              100}})));
  end ForcedSplitting_nonPhysical;

  model ForcedSplitting_physical
    "Forced splitting using physical components"
    Interfaces.FluidPort port_a annotation (Placement(transformation(extent={{-120,
              -10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Interfaces.FluidPort port_b annotation (Placement(transformation(extent={{100,
              50},{120,70}}), iconTransformation(extent={{100,50},{120,70}})));
    Interfaces.FluidPort port_c annotation (Placement(transformation(extent={{100,
              -70},{120,-50}}), iconTransformation(extent={{100,-70},{120,-50}})));
    Valve valve_b(
      dp_nominal=1,
      m_flow_nominal=0.25,
      u_nominal=0.5)
      annotation (Placement(transformation(extent={{50,10},{70,30}})));
    Sensors.MassFlow massFlow_a
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Modelica.Blocks.Continuous.LimPID pid(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.InitPID.InitialOutput,
      y_start=0) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={10,50})));
    Modelica.Blocks.Math.Gain gain(k=0.25)
      annotation (Placement(transformation(extent={{-36,44},{-24,56}})));
    Valve valve_c(dp_nominal=1, m_flow_nominal=0.75)
      annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
    Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={60,-40})));
    Sensors.MassFlow massFlow_b
      annotation (Placement(transformation(extent={{0,10},{20,30}})));
    Sensors.MassFlow massFlow_c
      annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  equation

    connect(port_a, massFlow_a.port_a)
      annotation (Line(points={{-110,0},{-80,0}}, color={0,0,0}));
    connect(massFlow_a.m, gain.u)
      annotation (Line(points={{-70,9},{-70,50},{-37.2,50}}, color={0,0,127}));
    connect(valve_c.u, const.y)
      annotation (Line(points={{60,-52},{60,-46.6}}, color={0,0,127}));
    connect(gain.y, pid.u_s)
      annotation (Line(points={{-23.4,50},{2.8,50}}, color={0,0,127}));
    connect(massFlow_a.port_b, massFlow_b.port_a) annotation (Line(points={{-60,
            0},{-30,0},{-30,20},{0,20}}, color={0,0,0}));
    connect(massFlow_b.port_b, valve_b.port_a)
      annotation (Line(points={{20,20},{49,20}}, color={0,0,0}));
    connect(massFlow_a.port_b, massFlow_c.port_a) annotation (Line(points={{-60,
            0},{-30,0},{-30,-60},{0,-60}}, color={0,0,0}));
    connect(massFlow_c.port_b, valve_c.port_a)
      annotation (Line(points={{20,-60},{49,-60}}, color={0,0,0}));
    connect(massFlow_b.m, pid.u_m)
      annotation (Line(points={{10,29},{10,42.8}}, color={0,0,127}));
    connect(valve_c.port_b, port_c) annotation (Line(points={{71,-60},{90,-60},{
            90,-60},{110,-60}}, color={0,0,0}));
    connect(valve_b.port_b, port_b) annotation (Line(points={{71,20},{90,20},{90,
            60},{110,60}}, color={0,0,0}));
    connect(pid.y, valve_b.u)
      annotation (Line(points={{16.6,50},{60,50},{60,28}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{-40,0},{0,60},{80,60}}, color={28,108,200}),
          Line(points={{-80,0},{-40,0},{0,-60},{80,-60}}, color={28,108,200}),
          Line(points={{66,66},{80,60},{66,54}}, color={28,108,200}),
          Line(points={{66,-54},{80,-60},{66,-66}}, color={28,108,200}),
          Text(
            extent={{20,50},{60,30}},
            lineColor={28,108,200},
            textString="x"),
          Text(
            extent={{20,-30},{60,-50}},
            lineColor={28,108,200},
            textString="y")}), Diagram(coordinateSystem(extent={{-100,-100},{100,
              100}})));
  end ForcedSplitting_physical;

  annotation (preferredView="info", Documentation(info="<html>
<p>It is often tempting to construct ad hoc thermo-hydraulic MIMO blocks for splitting/mixing mass flows, scaling a pressure or otherwise manipulating a number of fluid streams. Here it is important to distinguish between <b>physical</b> and <b>non-physical</b> models.</p>
<h4>Physical MIMO models</h4>
<p>Physical MIMO models will typically be enclosed models containing well-known physical <i>components</i> such as valves, pumps, mixing volumes and <i>sensors</i> and <i>controllers</i>. The controllers will actuate the valves, pumps etc. to obtain the goal of the MIMO block, e.g. splitting a stream in a fixed ratio. Using <i>physical</i> component models will also imply that flows are driven by pressure differences, pressure differences can be created by pumps and that added heat will be driven by temperature differences.</p>
<p>When one connects the physical MIMO model to pressure or mass flow boundary components (sources/sinks if you like) the simulated system will only work with physically reasonable boundary values. </p>
<h4>Non-physical MIMO models</h4>
<p>Often, one wants to obtain a simple goal such as splitting an ingoing mass flow by 40/60 &percnt; on two outgoing flows and only few equations are needed for this. However, when you add a constraining equation in a splitter model, e.g. <span style=\"font-family: Courier New;\">m_flow_b = 0.4*m_flow_a</span>, the additional equation will over-constrain the component model and you ask yourself the question: &quot;<i>which other equation should I remove?</i>&quot;.</p>
<h4>MIMO sub-package</h4>
<p>This sub-package contains examples of forced splitting and splitting/mixing MIMO components implemented both with physical components and non-physical equations. </p>
<p>The non-physical components can only be used with certain source/sink configurations since their mass flows are <b>not</b> related to the pressure drop. Hence, mass flow sources are applied to the upstream connectors whereas pressure sinks are applied to the downstream connectors.</p>
<p>The physical components assume a positive pressure drop to drive the mass flow. That way it is sufficient to control the flow with a valve. Otherwise, one should implement both a controlled pump and a valve to be able to handle pressure increase across the component.</p>
</html>"));
end MIMO;
