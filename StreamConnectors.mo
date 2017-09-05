within ;
package StreamConnectors
  "A simple library to learn the basics of stream connectors"
  package Interfaces
    extends Modelica.Icons.InterfacesPackage;
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
  end Interfaces;

  package Sources
    extends Modelica.Icons.SourcesPackage;
    model PressureBoundary_h
      "Boundary value component with fixed pressure and enthalpy"

      parameter Real p "Pressure";
      parameter Real h
        "Specific enthalpy (only relevant if fluid leaves this component)";

      Interfaces.FluidPort port annotation (Placement(transformation(extent={{
                100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
                10}})));
    equation
      port.p = p;
      port.h_outflow = h;

      annotation (
        preferredView="info",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid), Text(
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

    model MassFlowBoundary_h
      "Boundary value component with fixed mass flow rate and enthalpy"

      parameter Real m_flow "Mass flow rate";
      parameter Real h
        "Specific enthalpy (only relevant if fluid leaves this component)";

      Interfaces.FluidPort port annotation (Placement(transformation(extent={{
                100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
                10}})));
    equation
      port.m_flow = -m_flow;
      port.h_outflow = h;

      annotation (
        preferredView="info",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid), Text(
              extent={{-80,60},{80,-60}},
              lineColor={255,255,255},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              textString="(p,h)")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Note that it is not necessary to specify if the boundary component is a source or a sink. The enthalpy is only relevant when the component acts as a source, i.e. when the mass flow leaves the component.</p>
<p>However, if you look in the equation section you&apos;ll se that the default direction of the mass flow is out of the component.</p>
</html>"));
    end MassFlowBoundary_h;
  end Sources;

  package Components
    model Pipe "A simple pipe with fixed heating/cooling"
      parameter Real Q_flow=0 "Heat flow rate into the pipe";
      parameter Real K=0.5
        "Linear pressure drop coefficient. 1 kg/s results in 0.5 bar pressure drop";

      Interfaces.FluidPort port_a annotation (Placement(transformation(extent={
                {-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{
                -100,10}})));
      Interfaces.FluidPort port_b annotation (Placement(transformation(extent={
                {100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
                10}})));
    equation
      // Mass balance
      port_a.m_flow + port_b.m_flow = 0;

      // Momentum balance
      port_a.p - port_b.p = K*port_a.m_flow;

      // Energy balance
      0 = port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow*
        actualStream(port_b.h_outflow) + Q_flow;
      port_a.h_outflow = port_b.h_outflow;

      // Alternative to the two equations describing the energy balance you could write (commented below)
      //   0 = port_a.m_flow*inStream(port_a.h_outflow) + port_b.m_flow*port_b.h_outflow +
      //     Q_flow "This equation is only 'active' when flow enters port_a and leaves port_b";
      //   0 = port_a.m_flow*port_a.h_outflow + port_b.m_flow*inStream(port_b.h_outflow) +
      //     Q_flow "This equation is only 'active' when flow enters port_b and leaves port_a";
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
              fillPattern=FillPattern.Backward)}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>This is probably the simplest model of a heated/cooled pipe.</p>
<h4>Governing equations</h4>
<p>The equations &quot;on paper&quot; are:</p>
<p style=\"margin-left: 30px;\">m<sub>in</sub> = m<sub>out</sub></p>
<p style=\"margin-left: 30px;\">p<sub>in</sub> - p<sub>out</sub> = deltaP=f(m<sub>in</sub>)</p>
<p style=\"margin-left: 30px;\">m<sub>out</sub>*h<sub>out</sub> = m<sub>in</sub>*h<sub>in</sub> + Q</p>
<p>Representing the conservation of <i>mass</i>, <i>momentum</i> and <i>energy</i>.</p>
<h4>Implementation</h4>
<p>To understand the implementation and the concept of stream connectors:</p>
<ol>
<li>comment all code in the <code>equation</code> section.</li>
<li>&apos;check&apos; the model (in Dymola, hit the <b>F8</b> key). The code checker will say that the model is unbalanced with <b>six</b> unknowns and <b>two</b> equations.</li>
<li>try to understand why <b>four</b> equations are needed when the model can be described with only <b>three</b> equations on paper.</li>
</ol>
<p><br>The fact is that in Modelica, for each stream connector you need to provide a value for the outgoing stream variable (<code>h_outflow</code> in this case) when or if the mass flow leaves the connector.</p>
</html>"));
    end Pipe;
  end Components;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(Modelica(version="3.2.2")));
end StreamConnectors;
