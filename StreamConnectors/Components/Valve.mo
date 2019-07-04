within StreamConnectors.Components;
model Valve "Simple model of a valve"
  parameter Real K=m_flow_nominal/(sqrt(dp_nominal)*u_nominal) "Pressure drop coefficient";
  parameter Real dp_nominal=0.5 "Nominal pressure drop (at opening = 'u_nominal') [bar]"
    annotation (Dialog(group="Nominal values"));
  parameter Real m_flow_nominal=1 "Nominal mass flow rate (at opening = 'u_nominal') [kg/s]"
    annotation (Dialog(group="Nominal values"));
  parameter Real u_nominal=1.0 "Nominal valve opening [-]"
    annotation (Dialog(group="Nominal values"));

  Interfaces.FluidPort port_a annotation (Placement(transformation(extent={{-120,
            -10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  Interfaces.FluidPort port_b annotation (Placement(transformation(extent={{100,
            -10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
          extent={{-228,38},{-188,78}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
equation
  // Mass balance
  port_a.m_flow + port_b.m_flow = 0;

  // Momentum balance
  port_a.m_flow = u*K*Modelica.Fluid.Utilities.regRoot(port_a.p - port_b.p);

  // Energy balance
  port_b.h_outflow = inStream(port_a.h_outflow);
  port_a.h_outflow = inStream(port_b.h_outflow);

  annotation (
    preferredView="info",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
          points={{-100,40},{100,-40},{100,40},{-100,-40},{-100,40}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid), Line(points={{0,60},{0,0}}, color={0,0,
              0})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is probably the simplest model of a heated/cooled pipe.</p>
<h4>Governing equations</h4>
<p>The equations &quot;on paper&quot; are:</p>
<p style=\"margin-left: 30px;\">m<sub>in</sub> = m<sub>out</sub></p>
<p style=\"margin-left: 30px;\">p<sub>in</sub> - p<sub>out</sub> = deltaP=u<sup>.</sup>K<sup>.</sup>m<sub>in</sub>|m<sub>in</sub>|</p>
<p style=\"margin-left: 30px;\">m<sub>out<sup>.</sup>h<sub>out</sub> = m<sub>in<sup>.</sup>h<sub>in</sub> + Q</p>
<p>Representing the conservation of <i>mass</i>, <i>momentum</i> and <i>energy</i>.</p>
<h4>Implementation</h4>
<p>To understand the implementation and the concept of stream connectors:</p>
<ol>
<li>comment all code in the <span style=\"font-family: Courier New;\">equation</span> section.</li>
<li>&apos;check&apos; the model (in Dymola, hit the <b>F8</b> key). The code checker will say that the model is unbalanced with <b>six</b> unknowns and <b>two</b> equations.</li>
<li>try to understand why <b>four</b> equations are needed when the model can be described with only <b>three</b> equations on paper.</li>
</ol>
<p><br>The fact is that in Modelica, for each stream connector you need to provide a value for the outgoing stream variable (<span style=\"font-family: Courier New;\">h_outflow</span> in this case) when or if the mass flow leaves the connector. </p>
<p>In the pipe case it means that you must provide an expression for <span style=\"font-family: Courier New;\">port_b.h_outflow</span> (obviously) and <span style=\"font-family: Courier New;\">port_a.h_outflow</span> (for the case of flow reversal).</p>
<p>On the Github Wiki page on <a href=\"https://github.com/justnielsen/ModelicaTutorials/wiki/Stream-connectors\">Stream connectors</a>, I&apos;ve provided one more example similar to this.</p>
</html>"));
end Valve;
