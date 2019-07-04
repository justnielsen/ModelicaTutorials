within StreamConnectors.Examples.MIMO;
model ForcedSplitting_physical
  "Forced splitting using physical components"
  extends ForcedSplitting_nonPhysical(redeclare
      StreamConnectors.Components.MIMO.ForcedSplitting_physical
      splitter);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
                                                         Text(
          extent={{-98,98},{-40,92}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          textString="What to observe:",
          horizontalAlignment=TextAlignment.Left),
        Line(
          points={{-56,0},{-42,0}},
          color={238,46,47},
          pattern=LinePattern.Dash),              Text(
          extent={{-98,86},{28,76}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.None,
          horizontalAlignment=TextAlignment.Left,
          textString="- A PI controller controls the flow splitting, starting with a control signal of zero. Thus the initial transient behaviour.")}),
    experiment(StopTime=50),
    Documentation(info="<html>
<p><img src=\"modelica://StreamConnectors/Resources/Images/Examples/ForcedSplitting_physical.png\"/></p>
</html>"));

end ForcedSplitting_physical;
