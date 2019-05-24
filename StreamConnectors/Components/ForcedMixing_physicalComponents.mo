within StreamConnectors.Components;
model ForcedMixing_physicalComponents
  "Implementation with physical components"
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
  Valve valve annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Valve valve1
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Valve valve2
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Sensors.MassFlow massFlow
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Sensors.MassFlow massFlow1
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sensors.MassFlow massFlow2
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Continuous.LimPID
                                PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-30,80})));
  Sensors.MassFlow massFlow3
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Sensors.MassFlow massFlow6
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Sensors.MassFlow massFlow7
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Blocks.Math.Gain gain(k=0.25)
    annotation (Placement(transformation(extent={{-58,86},{-46,98}})));
  Modelica.Blocks.Math.Gain gain1(k=0.5)
    annotation (Placement(transformation(extent={{-58,26},{-46,38}})));
  Modelica.Blocks.Continuous.LimPID
                                PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-30,20})));
  Modelica.Blocks.Math.Gain gain2(k=0.75)
    annotation (Placement(transformation(extent={{-58,-34},{-46,-22}})));
  Modelica.Blocks.Continuous.LimPID
                                PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-30,-40})));
equation

  connect(port_a1, massFlow.port_a)
    annotation (Line(points={{-100,60},{-80,60}}, color={0,0,0}));
  connect(massFlow.port_b, valve.port_a)
    annotation (Line(points={{-60,60},{-41,60}}, color={0,0,0}));
  connect(port_a3, massFlow2.port_a)
    annotation (Line(points={{-100,-60},{-80,-60}}, color={0,0,0}));
  connect(port_a2, massFlow1.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,0,0}));
  connect(massFlow1.port_b, valve1.port_a)
    annotation (Line(points={{-60,0},{-41,0}}, color={0,0,0}));
  connect(massFlow2.port_b, valve2.port_a)
    annotation (Line(points={{-60,-60},{-41,-60}}, color={0,0,0}));
  connect(valve2.port_b, massFlow3.port_a)
    annotation (Line(points={{-19,-60},{0,-60}}, color={0,0,0}));
  connect(massFlow3.port_b, port_b1) annotation (Line(points={{20,-60},{40,-60},
          {40,40},{100,40}}, color={0,0,0}));
  connect(valve1.port_b, massFlow6.port_a)
    annotation (Line(points={{-19,0},{0,0}}, color={0,0,0}));
  connect(massFlow6.port_b, port_b1)
    annotation (Line(points={{20,0},{40,0},{40,40},{100,40}}, color={0,0,0}));
  connect(valve.port_b, massFlow7.port_a)
    annotation (Line(points={{-19,60},{0,60}}, color={0,0,0}));
  connect(massFlow7.port_b, port_b1) annotation (Line(points={{20,60},{40,60},{40,
          40},{100,40}}, color={0,0,0}));
  connect(PID.u_s, gain.y) annotation (Line(points={{-30,87.2},{-30,92},{-45.4,92}},
        color={0,0,127}));
  connect(massFlow.m, gain.u)
    annotation (Line(points={{-70,69},{-70,92},{-59.2,92}}, color={0,0,127}));
  connect(valve.u, PID.y)
    annotation (Line(points={{-30,68},{-30,73.4}}, color={0,0,127}));
  connect(massFlow7.m, PID.u_m)
    annotation (Line(points={{10,69},{10,80},{-22.8,80}}, color={0,0,127}));
  connect(massFlow2.m, gain2.u) annotation (Line(points={{-70,-51},{-70,-28},{-59.2,
          -28}}, color={0,0,127}));
  connect(massFlow1.m, gain1.u)
    annotation (Line(points={{-70,9},{-70,32},{-59.2,32}}, color={0,0,127}));
  connect(gain1.y, PID1.u_s) annotation (Line(points={{-45.4,32},{-30,32},{-30,27.2}},
        color={0,0,127}));
  connect(PID1.y, valve1.u)
    annotation (Line(points={{-30,13.4},{-30,8}}, color={0,0,127}));
  connect(gain2.y, PID2.u_s) annotation (Line(points={{-45.4,-28},{-30,-28},{-30,
          -32.8}}, color={0,0,127}));
  connect(PID2.y, valve2.u)
    annotation (Line(points={{-30,-46.6},{-30,-52}}, color={0,0,127}));
  connect(massFlow3.m, PID2.u_m)
    annotation (Line(points={{10,-51},{10,-40},{-22.8,-40}}, color={0,0,127}));
  connect(massFlow6.m, PID1.u_m)
    annotation (Line(points={{10,9},{10,20},{-22.8,20}}, color={0,0,127}));
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
end ForcedMixing_physicalComponents;
