within StreamConnectors.Functions;
function enthalpy_pT
  "Return specific enthalpy as a function of pressure and temperature"
  extends Modelica.Icons.Function;
  input Real p "Pressure [bar]";
  input Real T "Temperature [°C]";
  output Real h "Enthalpy [kJ/kg]";
protected
  parameter Real cp=4186 "Specific heat capacity";
  parameter Real rho=1000 "Density";
  parameter Real h0=-1143 "Reference enthalpy";
algorithm
  h := (cp*(T + 273.15) + 1e5*p/rho)/1000 + h0;
end enthalpy_pT;
