within BuildingControlLib.BuildingControl.VDI3814.StateGraph;
model ReturnToState
  "Is used when a state is already defined. Allows to jump from one state to already defined one."

  /* ***   ***   ***   ***   ***   ***   ***   ***   ***   */
  // Connectors
      Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,100}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={48,60})));
 /* ***   ***   ***   ***   ***   ***   ***   ***   ***   */
  // Parameters
  parameter Integer nNumberingOfTargetState = 11;
  parameter Integer nout = 1;

  Modelica.StateGraph.Interfaces.Transition_in transition_in annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={2,80})));
  Modelica.StateGraph.Interfaces.Step_out outport[1] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-94}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-82})));
  Modelica.StateGraph.Step step(nIn=1, nOut=1)
                                annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,-40})));
  Modelica.StateGraph.TransitionWithSignal
                                 transition annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=270,
        origin={3.55271e-015,40})));
equation
  connect(transition.outPort, step.inPort[1]) annotation (Line(
      points={{-5.55112e-016,37},{-5.55112e-016,-18},{3.9968e-015,-18}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(transition.inPort, transition_in) annotation (Line(
      points={{0,48},{0,100}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(step.outPort[1], outport[1]) annotation (Line(
      points={{0,-61},{0,-94}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(u, transition.condition) annotation (Line(
      points={{60,100},{60,100},{60,40},{24,40}},
      color={255,0,255},
      smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                             graphics), Icon(coordinateSystem(
        preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,70},{76,-72}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-44,24},{48,-24}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%nNumberingOfTargetState")}),
    Documentation(revisions="<html>
<ul>
<li>November 11, 2017&nbsp; by Georg Ferdinand Schneider:<br>Implemented.</li>
</ul>
</html>"));
end ReturnToState;
