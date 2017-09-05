within StreamConnectors.Sources;
model PressureBoundary_h
  "Boundary value component with fixed pressure and enthalpy"

  parameter Real p=1 "Pressure [bar]";
  parameter Real h=100
    "Specific enthalpy (only relevant if fluid leaves this component) [kJ/kg]";

  Interfaces.FluidPort port annotation (Placement(transformation(extent={{100,-10},
            {120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
equation
  port.p = p;
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
          textString="(p,h)")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Note that it is not necessary to specify if the boundary component is a source or a sink. The enthalpy is only relevant when the component acts as a source, i.e. when the mass flow leaves the component.</p>
</html>"));
end PressureBoundary_h;
