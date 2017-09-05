within StreamConnectors.Examples;
model PumpCircuitNotWorking "Closed circuit to show how not to do"
  extends Modelica.Icons.Example;
  Components.Pump pump(N=750)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Components.Pipe pipe(dp_nominal=1, m_flow_nominal=10)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-76,-4},{-56,16}})));
  Sensors.MultiSensor multiSensor1
    annotation (Placement(transformation(extent={{-26,-4},{-6,16}})));
  Sensors.MultiSensor multiSensor2
    annotation (Placement(transformation(extent={{60,-4},{80,16}})));
  Components.Pipe pipe1(
    dp_nominal=1,
    m_flow_nominal=10,
    Q_flow=1) annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Sensors.MultiSensor multiSensor3
    annotation (Placement(transformation(extent={{34,-4},{54,16}})));
  Sensors.MultiSensor multiSensor4
    annotation (Placement(transformation(extent={{34,-34},{54,-14}})));
equation
  connect(multiSensor.port_b, pump.port_a)
    annotation (Line(points={{-63,0},{-51,0}}, color={0,0,0}));

  connect(pump.port_b, multiSensor1.port_a)
    annotation (Line(points={{-29,0},{-19,0}}, color={0,0,0}));
  connect(multiSensor1.port_b, pipe.port_a)
    annotation (Line(points={{-13,0},{9,0}}, color={0,0,0}));
  connect(multiSensor1.port_b, pipe1.port_a)
    annotation (Line(points={{-13,0},{0,0},{0,-30},{9,-30}}, color={0,0,0}));
  connect(pipe.port_b, multiSensor3.port_a)
    annotation (Line(points={{31,0},{41,0}}, color={0,0,0}));
  connect(multiSensor3.port_b, multiSensor2.port_a)
    annotation (Line(points={{47,0},{67,0}}, color={0,0,0}));
  connect(pipe1.port_b, multiSensor4.port_a)
    annotation (Line(points={{31,-30},{41,-30}}, color={0,0,0}));
  connect(multiSensor4.port_b, multiSensor2.port_a)
    annotation (Line(points={{47,-30},{60,-30},{60,0},{67,0}}, color={0,0,0}));
  connect(multiSensor.port_a, multiSensor2.port_b) annotation (Line(points={{-69,
          0},{-90,0},{-90,-70},{94,-70},{94,0},{73,0}}, color={0,0,0}));
  annotation (
    preferredView="diagram",
    Diagram(graphics={Text(
          extent={{-98,98},{-40,92}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          textString="What to observe:",
          horizontalAlignment=TextAlignment.Left),Text(
          extent={{-98,88},{0,68}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          horizontalAlignment=TextAlignment.Left,
          textString="- all components only deal with \"increase/reduction\" of pressure and enthalpy.
- no absolute reference values are defined for enthalpy and pressure.
- this corresponds to simulate an electric circuit without ground connection.
- heat is added to 'pipe1' but there is no heat removal from the circuit.
- the same would be the case for a pump with efficiency <100 %")}),
    Icon(graphics={Line(points={{-80,80},{80,-80}}, color={238,46,47}),Line(
            points={{80,80},{-80,-80}}, color={238,46,47})}));
end PumpCircuitNotWorking;
