within StreamConnectors.Interfaces;
connector FluidPort "Simple stream connector."
  Real p "Potential/effort variable";
  flow Real m_flow "Flow variable";
  stream Real h_outflow "Specific enthalpy";

  annotation (
    preferredView="info",
    defaultComponentName="port",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The simples possible stream connector using </p>
<ul>
<li><span style=\"color: #1c6cc8;\">mass flow rate</span> as &quot;flow&quot; variable (in a connection point &quot;flow&quot; variables are automatically summed to zero like Kirchhoff&apos;s current law)</li>
<li><span style=\"color: #1c6cc8;\">pressure</span> as &quot;potential&quot; (or &quot;effort&quot;) variable (in a connection point the potentials are equal)</li>
<li><span style=\"color: #1c6cc8;\">specific enthalpy</span> as &quot;stream&quot; variable (property carried with the direction of the flow)</li>
</ul>
<h4>Specific enthalpy vs. temperature</h4>
<p>Why use specific enthalpy instead of temperature as stream variable when temperature seems more intuitive?</p>
<p><br>The answer is &quot;automatic mixing equation&quot;: When you connect more than two stream connectors, the Modelica tool can automatically calculate the mixing enthalpy from knowledge of the flow directions, since m1*h1 + m2*h2 + ... + mN*hN = 0. This also means that it is <b>not strictly necessary</b> to create specific mixer/splitter components.</p>
<h4>Why &apos;h_outflow&apos;</h4>
<p>Why is the enthalpy named <code>h_outflow</code> and not just <code>h</code>?</p>
<p>The reason is, that the variable is only relevant when the flow &apos;goes out&apos; of the component to which the connector is attached. </p>
<p>Yes, really. If you want to know the value of the ingoing enthalpy after a simulation, you shold look at the value of <code>h_outflow</code> of the adjacent component (from which the mass flow &apos;goes out&apos;). </p>
<p>If a component needs to access the ingoing enthalpy it should use one of the functions <code>inStream()</code> or <code>actualStream()</code>.</p>
</html>"));

end FluidPort;
