within StreamConnectors.Components.MIMO;
model ForcedSplitting_physical
  "Forced splitting using physical components"
  Interfaces.FluidPort port_a annotation (Placement(transformation(extent=
           {{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},
            {-100,10}})));
  Interfaces.FluidPort port_b annotation (Placement(transformation(extent=
           {{100,50},{120,70}}), iconTransformation(extent={{100,50},{120,
            70}})));
  Interfaces.FluidPort port_c annotation (Placement(transformation(extent=
           {{100,-70},{120,-50}}), iconTransformation(extent={{100,-70},{120,
            -50}})));
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
    initType=Modelica.Blocks.Types.Init.InitialOutput,
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
  connect(massFlow_a.m, gain.u) annotation (Line(points={{-70,9},{-70,50},
          {-37.2,50}}, color={0,0,127}));
  connect(valve_c.u, const.y)
    annotation (Line(points={{60,-52},{60,-46.6}}, color={0,0,127}));
  connect(gain.y, pid.u_s)
    annotation (Line(points={{-23.4,50},{2.8,50}}, color={0,0,127}));
  connect(massFlow_a.port_b, massFlow_b.port_a) annotation (Line(points={{
          -60,0},{-30,0},{-30,20},{0,20}}, color={0,0,0}));
  connect(massFlow_b.port_b, valve_b.port_a)
    annotation (Line(points={{20,20},{49,20}}, color={0,0,0}));
  connect(massFlow_a.port_b, massFlow_c.port_a) annotation (Line(points={{
          -60,0},{-30,0},{-30,-60},{0,-60}}, color={0,0,0}));
  connect(massFlow_c.port_b, valve_c.port_a)
    annotation (Line(points={{20,-60},{49,-60}}, color={0,0,0}));
  connect(massFlow_b.m, pid.u_m)
    annotation (Line(points={{10,29},{10,42.8}}, color={0,0,127}));
  connect(valve_c.port_b, port_c) annotation (Line(points={{71,-60},{90,-60},
          {90,-60},{110,-60}}, color={0,0,0}));
  connect(valve_b.port_b, port_b) annotation (Line(points={{71,20},{90,20},
          {90,60},{110,60}}, color={0,0,0}));
  connect(pid.y, valve_b.u) annotation (Line(points={{16.6,50},{60,50},{60,
          28}}, color={0,0,127}));
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
end ForcedSplitting_physical;
