within StreamConnectors.Components;
package MIMO "Thermo-hydraulic MIMO models — physical and non-physical"
  annotation (preferredView="info", Documentation(info="<html>
<p>It is often tempting to construct ad hoc thermo-hydraulic MIMO blocks for splitting/mixing mass flows, scaling a pressure or otherwise manipulating a number of fluid streams. Here it is important to distinguish between <b>physical</b> and <b>non-physical</b> models.</p>
<h4>Physical MIMO models</h4>
<p>Physical MIMO models will typically be enclosed models containing well-known physical <i>components</i> such as valves, pumps, mixing volumes and <i>sensors</i> and <i>controllers</i>. The controllers will actuate the valves, pumps etc. to obtain the goal of the MIMO block, e.g. splitting a stream in a fixed ratio. Using <i>physical</i> component models will also imply that flows are driven by pressure differences, pressure differences can be created by pumps and that added heat will be driven by temperature differences.</p>
<p>When one connects the physical MIMO model to pressure or mass flow boundary components (sources/sinks if you like) the simulated system will only work with physically reasonable boundary values. </p>
<h4>Non-physical MIMO models</h4>
<p>Often, one wants to obtain a simple goal such as splitting an ingoing mass flow by 40/60 &percnt; on two outgoing flows and only few equations are needed for this. However, when you add a constraining equation in a splitter model, e.g. <span style=\"font-family: Courier New;\">m_flow_b = 0.4*m_flow_a</span>, the additional equation will over-constrain the component model and you ask yourself the question: &quot;<i>which other equation should I remove?</i>&quot;.</p>
<h4>MIMO sub-package</h4>
<p>This sub-package contains examples of forced splitting and splitting/mixing MIMO components implemented both with physical components and non-physical equations. </p>
<p>The non-physical components can only be used with certain source/sink configurations since their mass flows are <b>not</b> related to the pressure drop. Hence, mass flow sources are applied to the upstream connectors whereas pressure sinks are applied to the downstream connectors.</p>
<p>The physical components assume a positive pressure drop to drive the mass flow. That way it is sufficient to control the flow with a valve. Otherwise, one should implement both a controlled pump and a valve to be able to handle pressure increase across the component.</p>
</html>"));
end MIMO;
