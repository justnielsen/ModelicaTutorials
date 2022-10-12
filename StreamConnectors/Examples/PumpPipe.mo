within StreamConnectors.Examples;
model PumpPipe
  "A pump raises the flow and upstream pressure of a pipe by increasing pump speed"
  extends Modelica.Icons.Example;
  Components.Pump pump(N=750)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Sources.PressureBoundary_h sink(p=1)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Components.Pipe pipe(dp_nominal=1, m_flow_nominal=10)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Sources.PressureBoundary_h source(p=1, h=Functions.enthalpy_pT(1, 25))
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-56,-4},{-36,16}})));
  Sensors.MultiSensor multiSensor1
    annotation (Placement(transformation(extent={{-6,-4},{14,16}})));
  Sensors.MultiSensor multiSensor2
    annotation (Placement(transformation(extent={{40,-4},{60,16}})));
equation
  connect(source.port, multiSensor.port_a)
    annotation (Line(points={{-59,0},{-49,0}}, color={0,0,0}));
  connect(multiSensor.port_b, pump.port_a)
    annotation (Line(points={{-43,0},{-31,0}}, color={0,0,0}));

  connect(pump.port_b, multiSensor1.port_a)
    annotation (Line(points={{-9,0},{1,0}}, color={0,0,0}));
  connect(multiSensor1.port_b, pipe.port_a)
    annotation (Line(points={{7,0},{19,0}}, color={0,0,0}));
  connect(pipe.port_b, multiSensor2.port_a)
    annotation (Line(points={{41,0},{47,0}}, color={0,0,0}));
  connect(multiSensor2.port_b, sink.port)
    annotation (Line(points={{53,0},{59,0}}, color={0,0,0}));
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
              textString="- both boundary pressures are 1 bar (atmospheric pressure)
- pressure/flow after pump is a function of the \"system characteristics\" and not prescribed by the pump.")}));
end PumpPipe;
