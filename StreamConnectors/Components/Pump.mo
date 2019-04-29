within StreamConnectors.Components;
model Pump "A simple pump model"
  parameter Real N_nominal=1500 "Nominal pump speed [RPM]"
    annotation (Dialog(group="Nominal pump values (characteristics)"));
  parameter Real m_flow_nominal=10 "Nominal mass flow [kg/s]"
    annotation (Dialog(group="Nominal pump values (characteristics)"));
  parameter Real dp_nominal=2 "Nominal pressure increase [bar]"
    annotation (Dialog(group="Nominal pump values (characteristics)"));

  input Real N=1500 "Actual pump speed [RPM]";

  Real dp "Pressure increase [bar]";

  Interfaces.FluidPort port_a annotation (Placement(transformation(extent={{-120,
            -10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  Interfaces.FluidPort port_b annotation (Placement(transformation(extent={{100,
            -10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
equation
  // Mass balance
  port_a.m_flow + port_b.m_flow = 0;

  // Momentum balance
  port_a.p - port_b.p = dp;

  // Energy balance
  0 = port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow*actualStream(
    port_b.h_outflow);
  port_a.h_outflow = port_b.h_outflow;

  // Pump characateristic (affinity law)
  dp/dp_nominal = Modelica.Fluid.Utilities.regSquare(N/N_nominal) -
    Modelica.Fluid.Utilities.regSquare(port_a.m_flow/m_flow_nominal);

  annotation (
    preferredView="info",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
          points={{-100,-100},{100,-100},{60,-60},{-60,-60},{-100,-100}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),Polygon(
          points={{90,0},{-50,70},{-40,0},{-50,-70},{90,0}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>A simple pump model.</p>
<p>The pump speed is controlled (parameter) and the resulting flow and pressure increase is determined by the components connected to the pump (the &quot;system characteristics&quot;).</p>
<p>The affinity law is used to scale the pump curve (relation between flow and pressure increase) with the pump speed.</p>
</html>"));
end Pump;
