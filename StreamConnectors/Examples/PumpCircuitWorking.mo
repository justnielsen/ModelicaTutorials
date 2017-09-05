within StreamConnectors.Examples;
model PumpCircuitWorking "Closed circuit to show how to fix problem"
  extends Modelica.Icons.Example;
  Components.Pump pump(N=750)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Components.Pipe pipe(dp_nominal=1, m_flow_nominal=10)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-66,-4},{-46,16}})));
  Sensors.MultiSensor multiSensor1
    annotation (Placement(transformation(extent={{-16,-4},{4,16}})));
  Sensors.MultiSensor multiSensor2
    annotation (Placement(transformation(extent={{70,-4},{90,16}})));
  Components.Pipe pipe1(dp_nominal=1,m_flow_nominal=10)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Sensors.MultiSensor multiSensor3
    annotation (Placement(transformation(extent={{44,-4},{64,16}})));
  Sensors.MultiSensor multiSensor4
    annotation (Placement(transformation(extent={{44,-34},{64,-14}})));
  Sources.PressureBoundary_h pressureBoundary_h
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
equation
  connect(multiSensor.port_b, pump.port_a)
    annotation (Line(points={{-53,0},{-41,0}}, color={0,0,0}));

  connect(pump.port_b, multiSensor1.port_a)
    annotation (Line(points={{-19,0},{-9,0}}, color={0,0,0}));
  connect(multiSensor1.port_b, pipe.port_a)
    annotation (Line(points={{-3,0},{19,0}}, color={0,0,0}));
  connect(multiSensor1.port_b, pipe1.port_a)
    annotation (Line(points={{-3,0},{10,0},{10,-30},{19,-30}}, color={0,0,0}));
  connect(pipe.port_b, multiSensor3.port_a)
    annotation (Line(points={{41,0},{51,0}}, color={0,0,0}));
  connect(multiSensor3.port_b, multiSensor2.port_a)
    annotation (Line(points={{57,0},{77,0}}, color={0,0,0}));
  connect(pipe1.port_b, multiSensor4.port_a)
    annotation (Line(points={{41,-30},{51,-30}}, color={0,0,0}));
  connect(multiSensor4.port_b, multiSensor2.port_a)
    annotation (Line(points={{57,-30},{70,-30},{70,0},{77,0}}, color={0,0,0}));
  connect(multiSensor.port_a, multiSensor2.port_b) annotation (Line(points={{-59,
          0},{-80,0},{-80,-70},{100,-70},{100,0},{83,0}}, color={0,0,0}));
  connect(pressureBoundary_h.port, multiSensor.port_a)
    annotation (Line(points={{-99,0},{-59,0}}, color={0,0,0}));
  annotation (preferredView="diagram", Diagram(coordinateSystem(extent={{-120,-100},
            {120,100}}, initialScale=0.1), graphics={Text(
          extent={{-118,98},{-60,92}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          textString="What to observe:",
          horizontalAlignment=TextAlignment.Left),Text(
          extent={{-118,88},{-20,68}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          horizontalAlignment=TextAlignment.Left,
          textString="- An absolute pressure reference is added
- No heat is added to the circuit
- Since no flow leaves the pressure boundary component, the enthalpy is not fixed at this point.
- An absolute enthalpy/temperature can be fixed (not in this simple model) by controlling the outlet temperature of one pipe with the added heat. 
  Then another component (radiator) should remove the heat added to the system.")}));
end PumpCircuitWorking;
