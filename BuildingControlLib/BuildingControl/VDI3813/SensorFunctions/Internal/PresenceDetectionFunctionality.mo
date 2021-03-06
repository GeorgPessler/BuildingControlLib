within BuildingControlLib.BuildingControl.VDI3813.SensorFunctions.Internal;
block PresenceDetectionFunctionality
  "Algorithm model to provide functionality of PresenceDetection"

  extends
    BuildingControlLib.BuildingControl.VDI3813.Interfaces.Partial.PartialFunctionality;

  /***   ***   ***   ***   ***   ***   ***   ***   ***   ***/
  // Connectors
  BuildingControlLib.BuildingControl.VDI3813.Interfaces.Physical.ValuePhysicalPresenceInput
    P
    "Physical signal of presence detection(true = presence detected / false = no presence detected)."   annotation (Placement(transformation(extent={{-20,80},{20,120}}),
        iconTransformation(extent={{-20,80},{20,120}})));
  BuildingControlLib.BuildingControl.VDI3813.Interfaces.Presence.ValuePresenceSensorOutput
    P_AUTO
    "Boolean presence state in a room which comes from a sensor(true = occupied / false = unoccupied)." annotation (Placement(transformation(extent={{100,-20},{160,20}}),
        iconTransformation(extent={{100,-20},{160,20}})));
  /***   ***   ***   ***   ***   ***   ***   ***   ***   ***/
  // Parameter definition
  parameter Modelica.SIunits.Time PAR_HOLD = 500
    "Holding time of presence state after a detection in seconds (i.e. 500 results in of presence activation after detection)";
  parameter Boolean holdingActive = false
    "Flag for the presence holding process (true = holding is activated / false = holding is deactivated)";

  /***   ***   ***   ***   ***   ***   ***   ***   ***   ***/
  // Components

  Modelica.StateGraph.InitialStep initialStep(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,90})));
  Modelica.StateGraph.StepWithSignal holdingIsActive
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={2,-48})));
  Modelica.StateGraph.StepWithSignal holdingNotActive
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-38,-48})));
  Modelica.StateGraph.Transition t1(condition=not holdingActive and P.valuePhysicalPresence)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-38,-18})));
  Modelica.StateGraph.Transition t3(
    enableTimer=true,
    waitTime=PAR_HOLD,
    condition=not P.valuePhysicalPresence) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={2,-78})));
  Modelica.StateGraph.Transition t2(condition=holdingActive and P.valuePhysicalPresence)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={2,-18})));
  Modelica.StateGraph.Transition t4(
    waitTime=500,
    enableTimer=false,
    condition=not P.valuePhysicalPresence) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-38,-78})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{68,66},{88,86}})));
  Modelica.StateGraph.StepWithSignal evaluateHoldingActive(nIn=3, nOut=2)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-20,32})));
  Modelica.StateGraph.Transition t5(condition=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,72})));
  Sources.Presence.PrescribedP_AUTO prescribedP_AUTO
    annotation (Placement(transformation(extent={{56,-40},{76,-20}})));
  Modelica.Blocks.MathBoolean.Or or1(nu=3)
    annotation (Placement(transformation(extent={{26,-36},{38,-24}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
equation

  connect(t1.outPort, holdingNotActive.inPort[1]) annotation (Line(
      points={{-38,-19.5},{-38,-37}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t2.outPort, holdingIsActive.inPort[1]) annotation (Line(
      points={{2,-19.5},{2,-37}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t3.inPort, holdingIsActive.outPort[1]) annotation (Line(
      points={{2,-74},{2,-58.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t4.inPort, holdingNotActive.outPort[1]) annotation (Line(
      points={{-38,-74},{-38,-58.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(initialStep.outPort[1], t5.inPort) annotation (Line(
      points={{-70,79.5},{-70,76}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(evaluateHoldingActive.outPort[1], t1.inPort) annotation (Line(
      points={{-20.25,21.5},{-20.25,2},{-38,2},{-38,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(evaluateHoldingActive.outPort[2], t2.inPort) annotation (Line(
      points={{-19.75,21.5},{-19.75,12},{-20,12},{-20,2},{2,2},{2,-14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t5.outPort, evaluateHoldingActive.inPort[1]) annotation (Line(
      points={{-70,70.5},{-70,70.5},{-70,60},{-20,60},{-20,43},{-20.6667,43}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t4.outPort, evaluateHoldingActive.inPort[2]) annotation (Line(
      points={{-38,-79.5},{-38,-94},{-74,-94},{-74,60},{-20,60},{-20,43}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(t3.outPort, evaluateHoldingActive.inPort[3]) annotation (Line(
      points={{2,-79.5},{2,-96},{40,-96},{40,60},{-20,60},{-20,43},{-19.3333,43}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(prescribedP_AUTO.P_AUTO, P_AUTO) annotation (Line(
      points={{77.9,-30},{92.95,-30},{92.95,0},{130,0}},
      color={0,0,0},
      thickness=1,
      smooth=Smooth.None));
  connect(or1.y, prescribedP_AUTO.u) annotation (Line(
      points={{38.9,-30},{58,-30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(or1.u[1], holdingIsActive.active) annotation (Line(
      points={{26,-27.2},{18,-27.2},{18,-48},{13,-48}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(holdingNotActive.active, or1.u[2]) annotation (Line(
      points={{-27,-48},{-22,-48},{-22,12},{18,12},{18,-26},{18,-26},{18,-30},{26,
          -30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(evaluateHoldingActive.active, not1.u) annotation (Line(
      points={{-9,32},{-6,32},{-6,30},{-2,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.y, or1.u[3]) annotation (Line(
      points={{21,30},{24,30},{24,-32.8},{26,-32.8}},
      color={255,0,255},
      smooth=Smooth.None));
   annotation (preferredView="info",Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Block that implements the functionality of &QUOT;Presence detection&QUOT; from VDI 3813 <a href=\"modelica://BuildingControlLib.UsersGuide.References\">[1, section 6.1.2, p. 10-11]</a>. </p>
<h4><span style=\"color:#008000\">Functional Description</span></h4>
<p>&QUOT;The sensor function <i>Presence detection</i> (RA-FL section 2, column 1, see Section 7.3, Bild 61; informative function block Figure 3) automatically detects the presence of persons in the room and passes the output information of either the &ldquo;present&rdquo; or the &ldquo;absent&rdquo; state to those application functions whose response is determined by the room occupancy state. Due to the use in connection with lighting functions, the output information must be generated without any delay when the status of the evaluation unit changes.&QUOT; <a href=\"modelica://BuildingControlLib.UsersGuide.References\">[1, section 6.1.2, p. 10-11]</a></p>
<h4><span style=\"color:#008000\">Input Variables</span></h4>
<p><b>Tab . 1: </b>The following table presents the input variables of the function as specified in the standard. Because in the standard is no definition of the logic level, it has been defined in this case to take the positive logic, which means &QUOT;true = presence detected&QUOT; and &QUOT;false = no presence detected&QUOT;.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Acronym</h4></p></td>
<td><p align=\"center\"><h4>Datatype VDI3813</h4></p></td>
<td><p align=\"center\"><h4>Semantic data type</h4></p></td>
<td><p align=\"center\"><h4>Signal flow direction</h4></p></td>
<td><p align=\"center\"><h4>Description</h4></p></td>
</tr>
<tr>
<td valign=\"top\"><p>P</p></td>
<td valign=\"top\"><p>Binary</p></td>
<td valign=\"top\"><p><a href=\"modelica://BuildingControlLib.BuildingControl.VDI3813.Interfaces.Physical.ValuePhysicalPresenceInput\">ValuePhysicalPresence</a></p></td>
<td valign=\"top\"><p>Input</p></td>
<td valign=\"top\"><p>Physical&nbsp;signal&nbsp;of&nbsp;presence&nbsp;detection (true = presence detected / false = no presence detected).</p></td>
</tr>
</table>
<p><br><h4><span style=\"color:#008000\">Output Variables</span></h4></p>
<p><b>Tab . 2: </b>The following table presents the output variables of the function as specified in the standard. Because in the standard is no definition of the logic level, it has been defined in this case to take the positive logic, which means &QUOT;true = occupied&QUOT; and &QUOT;false = unoccupied&QUOT;.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Acronym</h4></p></td>
<td><p align=\"center\"><h4>Datatype VDI3813</h4></p></td>
<td><p align=\"center\"><h4>Semantic data type</h4></p></td>
<td><p align=\"center\"><h4>Signal flow direction</h4></p></td>
<td><p align=\"center\"><h4>Description</h4></p></td>
</tr>
<tr>
<td valign=\"top\"><p>P_AUTO</p></td>
<td valign=\"top\"><p>Presence</p></td>
<td valign=\"top\"><p><a href=\"modelica://BuildingControlLib.BuildingControl.VDI3813.Interfaces.Presence.ValuePresenceSensorOutput\">ValuePresenceSensor</a></p></td>
<td valign=\"top\"><p>Output</p></td>
<td valign=\"top\"><p>Boolean&nbsp;presence&nbsp;state&nbsp;in&nbsp;a&nbsp;room&nbsp;which&nbsp;comes&nbsp;from&nbsp;a&nbsp;sensor (true&nbsp;=&nbsp;occupied&nbsp;/&nbsp;false&nbsp;=&nbsp;unoccupied).</p></td>
</tr>
</table>
<p><br><h4><span style=\"color:#008000\">Parameters</span></h4></p>
<p><b>Tab . 3: </b>The following table presents the parameters of the function. PAR_HOLD is specified in the standard. The parameter holdingActive is not specified in the standard. The purpose is to switch on and off the use of holding time in simulation. A positive logic is used.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Acronym</h4></p></td>
<td><p align=\"center\"><h4>Description</h4></p></td>
</tr>
<tr>
<td valign=\"top\"><p>PAR_HOLD</p></td>
<td valign=\"top\"><p>Holding time in seconds for presence state, when presence has been detected.</p></td>
</tr>
<tr>
<td valign=\"top\"><p>holdingActive</p></td>
<td valign=\"top\"><p>Flag for the presence holding process (true = holding is activated / false = holding is deactivated)</p></td>
</tr>
</table>
</html>", revisions="<html>
<ul>
<li>March 07, 2017&nbsp; by Georg Ferdinand Schneider &amp; Georg Ambrosius Pe&szlig;ler:<br>Implemented.</li>
</ul>
</html>"));
end PresenceDetectionFunctionality;
