within StreamConnectors.Examples;
model Valve "Test of valve model"
  extends Modelica.Icons.Example;
  Sources.PressureBoundary_h sink(p=1)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Sources.PressureBoundary_h source(p=2, h=Functions.enthalpy_pT(1, 25))
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-50,-4},{-30,16}})));
  Sensors.MultiSensor multiSensor2
    annotation (Placement(transformation(extent={{30,-4},{50,16}})));
  Components.Valve valve(dp_nominal=1, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp ramp(duration=0.8, startTime=0.1)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
equation
  connect(source.port, multiSensor.port_a)
    annotation (Line(points={{-59,0},{-43,0}}, color={0,0,0}));

  connect(multiSensor2.port_b, sink.port)
    annotation (Line(points={{43,0},{59,0}}, color={0,0,0}));
  connect(multiSensor.port_b, valve.port_a)
    annotation (Line(points={{-37,0},{-11,0}}, color={0,0,0}));
  connect(valve.port_b, multiSensor2.port_a)
    annotation (Line(points={{11,0},{37,0}}, color={0,0,0}));
  connect(ramp.y, valve.u)
    annotation (Line(points={{-19,40},{0,40},{0,8}}, color={0,0,127}));
  annotation (preferredView="diagram");
end Valve;
