within StreamConnectors.Functions;
function temperature_ph
  "Return temperature as a function of pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input Real p "Pressure [bar]";
  input Real h "Enthalpy [kJ/kg]";
  output Real T "Temperature [°C]";
protected
  parameter Real cp=4186 "Specific heat capacity";
  parameter Real rho=1000 "Density";
  parameter Real h0=-1143 "Reference enthalpy";
algorithm
  T := ((h - h0)*1000 - 1e5*p/rho)/cp - 273.15;

end temperature_ph;
