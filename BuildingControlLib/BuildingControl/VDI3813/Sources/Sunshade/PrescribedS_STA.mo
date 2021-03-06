within BuildingControlLib.BuildingControl.VDI3813.Sources.Sunshade;
model PrescribedS_STA
  "Model to interface Modelica Standard Library and StatusSunshade"
  extends Interfaces.Partial.PartialSource;
 Modelica.Blocks.Interfaces.RealInput u[2]
  annotation (Placement(transformation(extent={{-140,    -60},{-60,20}}), iconTransformation(extent={{-100,-20},{-60,20}})));
 BuildingControlLib.BuildingControl.VDI3813.Interfaces.Sunshade.StatusSunshadeOutput
 S_STA annotation (Placement(transformation(extent={{100,-20},{138,20}})));
equation
 u[1] = S_STA.statusSunshadePos;
 u[2] = S_STA.statusSunshadeSlatAngle;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics));
end PrescribedS_STA;
