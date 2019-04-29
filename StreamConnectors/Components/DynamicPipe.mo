within StreamConnectors.Components;
model DynamicPipe "A simple dynamic pipe with heating/cooling"
  input Real Q_flow=0 "Heat flow rate into the pipe [kW]" annotation(Dialog(group="Heat input"));
  parameter Real K=dp_nominal/m_flow_nominal^2 "Pressure drop coefficient";
  parameter Real dp_nominal=0.5 "Nominal pressure drop [bar]"
    annotation (Dialog(group="Nominal values"));
  parameter Real m_flow_nominal=1 "Nominal mass flow rate [kg/s]"
    annotation (Dialog(group="Nominal values"));
    parameter Real V=0.1 "Volume of stored fluid [m3]";

  Real U "Internal energy [kJ]";
  Real u "Specific internal energy — a fluid property [kJ/kg]";
  Real m "Mass of stored fluid [kg]";
  Real p "Pressure of fluid leaving the pipe [bar]";
  Real h "Specific enthalpy of fluid leaving the pipe";

  constant Real rho=1000 "Density of fluid — assumed constant for simplicity [kg/m3]";

  Interfaces.FluidPort port_a annotation (Placement(transformation(extent={{-120,
            -10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  Interfaces.FluidPort port_b annotation (Placement(transformation(extent={{100,
            -10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
initial equation
  // steady state initialization
  der(U) = 0;
equation
  // Mass balance
  port_a.m_flow + port_b.m_flow = 0;

  // Momentum balance
  port_a.p - port_b.p = K*port_a.m_flow*abs(port_a.m_flow);

  // Energy balance
  der(U) = port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow*actualStream(
    port_b.h_outflow) + Q_flow;
  port_a.h_outflow = port_b.h_outflow;

  // Definition of internal energy
  U = m*u;
  m = rho*V;
  u = h - 1e2*p/rho "Incl. conversion from bar and to kJ/kg";

  // Considering the flow direction, define pressure/enthalpy of outgoing fluid
  // with built-in functions. Thus, flow reversal is supported
  p = Modelica.Fluid.Utilities.regStep(port_a.m_flow, port_b.p, port_a.p);
  h = Modelica.Fluid.Utilities.regStep(port_a.m_flow, port_b.h_outflow, port_a.h_outflow);

  annotation (
    preferredView="info",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,60},{100,40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-40},{100,-60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Backward),
        Line(points={{-40,-80},{40,-80}}, color={0,0,0}),
        Line(points={{30,-74},{40,-80},{30,-86}}, color={0,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is probably the simplest model of a dynamic heated/cooled pipe.</p>
<h4>Governing equations</h4>
<p>The equations &quot;on paper&quot; are:</p>
<p style=\"margin-left: 30px;\">m<sub>in</sub> = m<sub>out</sub></p>
<p style=\"margin-left: 30px;\">p<sub>in</sub> - p<sub>out</sub> = deltaP=K<sup>.</sup>m<sub>in</sub>|m<sub>in</sub>|</p>
<p style=\"margin-left: 30px;\">dU/dt = m<sub>out<sup>.</sup>h<sub>out</sub> - m<sub>in<sup>.</sup>h<sub>in</sub> + Q</p>
<p>Representing the conservation of <i>mass</i>, <i>momentum</i> and <i>energy</i> where</p>
<p style=\"margin-left: 30px;\">U = m<sup>.</sup>u is the internal energy</p>
<p style=\"margin-left: 30px;\">m is the mass of the fluid inside the pipe</p>
<p style=\"margin-left: 30px;\">u is the specific internal energy defined as c<sub>p<sup>.</sup>T or h - p/rho</p>
<h4>Assumptions</h4>
<ul>
<li>The fluid is incompressible (constant density) and thus the mass balance is static.</li>
<li>The specific enthalpy of the fluid leaving the pipe is defined without considering the fluid velocity term.</li>
</ul>
</html>"));
end DynamicPipe;
