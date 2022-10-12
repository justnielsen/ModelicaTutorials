within StreamConnectors.Components.MIMO;
model ForcedSplixing_physical
  "Forced splitting/mixing using physical components"
  Interfaces.FluidPort port_a1 annotation (Placement(transformation(
          extent={{-110,90},{-90,110}}), iconTransformation(extent={{-120,
            50},{-100,70}})));
  Interfaces.FluidPort port_a2 annotation (Placement(transformation(
          extent={{-110,30},{-90,50}}), iconTransformation(extent={{-120,-10},
            {-100,10}})));
  Interfaces.FluidPort port_a3 annotation (Placement(transformation(
          extent={{-110,-30},{-90,-10}}), iconTransformation(extent={{-120,
            -70},{-100,-50}})));
  Interfaces.FluidPort port_b1 annotation (Placement(transformation(
          extent={{90,30},{110,50}}), iconTransformation(extent={{100,30},
            {120,50}})));
  Interfaces.FluidPort port_b2 annotation (Placement(transformation(
          extent={{90,-110},{110,-90}}), iconTransformation(extent={{100,-50},
            {120,-30}})));
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
    initType=Modelica.Blocks.Types.Init.InitialOutput,
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
    initType=Modelica.Blocks.Types.Init.InitialOutput,
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
    initType=Modelica.Blocks.Types.Init.InitialOutput,
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
  connect(valve_a1b1.u, PID_a1b1.y) annotation (Line(points={{40,108},{40,
          130},{6.6,130}}, color={0,0,127}));
  connect(massFlow_a3.m, gain2.u) annotation (Line(points={{-70,-11},{-70,
          10},{-27.2,10}}, color={0,0,127}));
  connect(massFlow_a2.m, gain1.u) annotation (Line(points={{-70,49},{-70,70},
          {-27.2,70}}, color={0,0,127}));
  connect(PID_a2b1.y, valve_a2b1.u) annotation (Line(points={{6.6,70},{40,
          70},{40,48}}, color={0,0,127}));
  connect(PID_a3b1.y, valve_a3b1.u) annotation (Line(points={{6.6,10},{40,
          10},{40,-12}}, color={0,0,127}));
  connect(valve_a1b2.u, const.y) annotation (Line(points={{40,-52},{42,-52},
          {42,-50},{40,-50},{40,-46.6}}, color={0,0,127}));
  connect(valve_a2b2.u, const1.y) annotation (Line(points={{40,-92},{42,-92},
          {42,-90},{40,-90},{40,-86.6}}, color={0,0,127}));
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
  connect(massFlow_a3.port_b, massFlow_a3b2.port_a) annotation (Line(
        points={{-60,-20},{-44,-20},{-44,-140},{-10,-140}}, color={0,0,0}));
  connect(massFlow_a3b2.port_b, valve_a3b2.port_a)
    annotation (Line(points={{10,-140},{29,-140}}, color={0,0,0}));
  connect(massFlow_a2.port_b, massFlow_a2b2.port_a) annotation (Line(
        points={{-60,40},{-40,40},{-40,-100},{-10,-100}}, color={0,0,0}));
  connect(massFlow_a2b2.port_b, valve_a2b2.port_a)
    annotation (Line(points={{10,-100},{29,-100}}, color={0,0,0}));
  connect(massFlow_a1.port_b, massFlow_a1b2.port_a) annotation (Line(
        points={{-60,100},{-36,100},{-36,-60},{-10,-60}}, color={0,0,0}));
  connect(massFlow_a1b2.port_b, valve_a1b2.port_a)
    annotation (Line(points={{10,-60},{29,-60}}, color={0,0,0}));
  connect(valve_a1b1.port_b, port_b1) annotation (Line(points={{51,100},{70,
          100},{70,40},{100,40}}, color={0,0,0}));
  connect(valve_a2b1.port_b, port_b1)
    annotation (Line(points={{51,40},{100,40}}, color={0,0,0}));
  connect(valve_a3b1.port_b, port_b1) annotation (Line(points={{51,-20},{70,
          -20},{70,40},{100,40}}, color={0,0,0}));
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
  connect(valve_a1b2.port_b, port_b2) annotation (Line(points={{51,-60},{70,
          -60},{70,-100},{100,-100}}, color={0,0,0}));
  connect(valve_a3b2.port_b, port_b2) annotation (Line(points={{51,-140},{
          70,-140},{70,-100},{100,-100}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
        graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={28,108,200},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Line(points={{-80,-60},{60,
          40}}, color={28,108,200}),Line(points={{-80,60},{60,-40}},
          color={28,108,200}),Line(points={{40,40},{60,40},{54,22}},
          color={28,108,200}),Line(points={{54,-22},{60,-40},{40,-40}},
          color={28,108,200}),Line(points={{-80,0},{-14,0}}, color={28,108,
          200}),Line(points={{-34,10},{-14,0},{-34,-10}}, color={28,108,200})}),
      Diagram(coordinateSystem(extent={{-100,-160},{100,160}})));
end ForcedSplixing_physical;
