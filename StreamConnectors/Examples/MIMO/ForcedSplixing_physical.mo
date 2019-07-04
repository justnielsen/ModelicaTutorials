within StreamConnectors.Examples.MIMO;
model ForcedSplixing_physical
  "Forced splitting/mixing using physical components"
  extends ForcedSplixing_nonPhysical(redeclare
      StreamConnectors.Components.MIMO.ForcedSplixing_physical
      splitterMixer);
  annotation (Documentation(info="<html>
<p><img src=\"modelica://StreamConnectors/Resources/Images/Examples/ForcedSplixing_Physical.png\"/></p>
</html>"));
end ForcedSplixing_physical;
