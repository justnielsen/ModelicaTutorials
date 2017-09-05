within StreamConnectors.Examples;
model BranchingPipes "Branching pipes and prescribes mass flow rate"
  extends Modelica.Icons.Example;
  Sources.PressureBoundary_h sink(p=1)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Components.Pipe pipe(
    dp_nominal=1,
    m_flow_nominal=3,
    Q_flow=-0.25)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Sources.MassFlowBoundary_h source(h=Functions.enthalpy_pT(1, 25), m_flow=10)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-72,-4},{-52,16}})));
  Sensors.MultiSensor multiSensor1
    annotation (Placement(transformation(extent={{8,-4},{28,16}})));
  Sensors.MultiSensor multiSensor2
    annotation (Placement(transformation(extent={{50,-4},{70,16}})));
  Components.Pipe pipe1(
    dp_nominal=3,
    m_flow_nominal=3,
    Q_flow=2)
    annotation (Placement(transformation(extent={{-50,-88},{-30,-68}})));
  Components.Pipe pipe2(
    dp_nominal=2,
    m_flow_nominal=7,
    Q_flow=0.5)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Components.Pipe pipe3(dp_nominal=1, m_flow_nominal=3) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-40})));
  Components.Pipe pipe4(dp_nominal=1, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Sensors.MultiSensor multiSensor3
    annotation (Placement(transformation(extent={{-72,-82},{-52,-62}})));
  Sensors.MultiSensor multiSensor4
    annotation (Placement(transformation(extent={{50,36},{70,56}})));
  Sensors.MultiSensor multiSensor5
    annotation (Placement(transformation(extent={{8,36},{28,56}})));
  Sensors.MultiSensor multiSensor6
    annotation (Placement(transformation(extent={{-28,-4},{-8,16}})));
  Sensors.MultiSensor multiSensor7 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={6,-62})));
  Sensors.MultiSensor multiSensor8 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={6,-18})));
  Sensors.MultiSensor multiSensor9
    annotation (Placement(transformation(extent={{-28,-82},{-8,-62}})));
  Sensors.MultiSensor multiSensor10
    annotation (Placement(transformation(extent={{40,-82},{60,-62}})));
equation
  connect(source.port, multiSensor.port_a)
    annotation (Line(points={{-79,0},{-65,0}}, color={0,0,0}));

  connect(multiSensor1.port_b, pipe.port_a)
    annotation (Line(points={{21,0},{29,0}},color={0,0,0}));
  connect(pipe.port_b, multiSensor2.port_a)
    annotation (Line(points={{51,0},{57,0}}, color={0,0,0}));
  connect(multiSensor2.port_b, sink.port)
    annotation (Line(points={{63,0},{79,0}}, color={0,0,0}));
  connect(pipe1.port_a, multiSensor3.port_b)
    annotation (Line(points={{-51,-78},{-59,-78}}, color={0,0,0}));
  connect(source.port, multiSensor3.port_a) annotation (Line(points={{-79,0},{
          -74,0},{-74,-78},{-65,-78}}, color={0,0,0}));
  connect(multiSensor.port_b, pipe2.port_a)
    annotation (Line(points={{-59,0},{-51,0}}, color={0,0,0}));
  connect(pipe4.port_b, multiSensor4.port_a)
    annotation (Line(points={{51,40},{57,40}}, color={0,0,0}));
  connect(multiSensor4.port_b, sink.port)
    annotation (Line(points={{63,40},{72,40},{72,0},{79,0}}, color={0,0,0}));
  connect(multiSensor5.port_b, pipe4.port_a)
    annotation (Line(points={{21,40},{29,40}}, color={0,0,0}));
  connect(pipe2.port_b, multiSensor6.port_a)
    annotation (Line(points={{-29,0},{-21,0}}, color={0,0,0}));
  connect(pipe3.port_a, multiSensor7.port_b) annotation (Line(points={{
          -7.21645e-016,-51},{0,-51},{0,-59}}, color={0,0,0}));
  connect(multiSensor6.port_b, multiSensor1.port_a)
    annotation (Line(points={{-15,0},{15,0}}, color={0,0,0}));
  connect(multiSensor6.port_b, multiSensor8.port_b)
    annotation (Line(points={{-15,0},{0,0},{0,-15}}, color={0,0,0}));
  connect(multiSensor6.port_b, multiSensor5.port_a)
    annotation (Line(points={{-15,0},{0,0},{0,40},{15,40}}, color={0,0,0}));
  connect(pipe3.port_b, multiSensor8.port_a)
    annotation (Line(points={{0,-29},{0,-21}}, color={0,0,0}));
  connect(multiSensor10.port_b, sink.port)
    annotation (Line(points={{53,-78},{72,-78},{72,0},{79,0}}, color={0,0,0}));
  connect(pipe1.port_b, multiSensor9.port_a)
    annotation (Line(points={{-29,-78},{-21,-78}}, color={0,0,0}));
  connect(multiSensor9.port_b, multiSensor7.port_a)
    annotation (Line(points={{-15,-78},{0,-78},{0,-65}}, color={0,0,0}));
  connect(multiSensor9.port_b, multiSensor10.port_a)
    annotation (Line(points={{-15,-78},{47,-78}}, color={0,0,0}));
  annotation (preferredView="diagram", Diagram(graphics={Text(
          extent={{-98,98},{-40,92}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          textString="What to observe:",
          horizontalAlignment=TextAlignment.Left),Text(
          extent={{-98,92},{0,80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          horizontalAlignment=TextAlignment.Left,
          textString="- prescribed upstream mass flow
- pressure builds up \"backwards\"
- mixing enthalpies are calculated \"automatically\"
- reverse flow (in pipe3) is handled")}));
end BranchingPipes;
