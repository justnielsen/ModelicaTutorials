within StreamConnectors.Sources;
model MassFlowBoundary_h
  "Boundary value component with fixed mass flow rate and enthalpy"

  input Real m_flow "Mass flow rate [kg/s]" annotation(Dialog);
  input Real h
    "Specific enthalpy (only relevant if fluid leaves this component) [kJ/kg]" annotation(Dialog);

  Interfaces.FluidPort port annotation (Placement(transformation(extent={{100,-10},
            {120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
equation
  port.m_flow = -m_flow;
  port.h_outflow = h;

  annotation (
    preferredView="info",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),Text(
          extent={{-80,60},{80,-60}},
          lineColor={255,255,255},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="(m,h)")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Note that it is not necessary to specify if the boundary component is a source or a sink. The enthalpy is only relevant when the component acts as a source, i.e. when the mass flow leaves the component.</p>
<p>However, if you look in the equation section you&apos;ll se that the default direction of the mass flow is out of the component.</p>
</html>"));
end MassFlowBoundary_h;
