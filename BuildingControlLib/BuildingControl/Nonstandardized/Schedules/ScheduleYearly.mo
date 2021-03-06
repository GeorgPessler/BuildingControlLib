within BuildingControlLib.BuildingControl.Nonstandardized.Schedules;
block ScheduleYearly "Model of a schedule with yearly periodicity"
  extends Modelica.Blocks.Interfaces.SO;

  /***   ***   ***   ***   ***   ***   ***   ***   ***   ***/
  // Components
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          offset = offset,
          startTime = startTime[1]*nSecondsPerDay + startTime[2]*nSecondsPerHour + startTime[3]*nSecondsPerMinute + startTime[4],
          table = table,
          extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic,
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  /***   ***   ***   ***   ***   ***   ***   ***   ***   ***/
  // Parameters
  parameter Real startTime[5] = {0,0,0,0,0.0}
    "Array with time/value pair for starting time, time format: {{days,hours,minutes,seconds,startValue}}";
  parameter Real endValue[5] = {365,0,0,0,startTime[5]}
    "Array needed to fix periodicity, here for daily periodicty it needs to restart on end of day i.e. 86400 s. Time format: {{days,hours,minutes,seconds,startValue}}";
  parameter Real offset[:]={0.0} "Offset of output signal";
  parameter Real inputIntervalsAndValue[:,5] = {
                            startTime,
                            {315,8,11,0,0.0},
                            {315,8,11,0,0.5},
                            {315,11,11,0,0.5},
                            {315,11,11,0,0.0},
                            endValue}
    "Array with time/value pairings. Format: {{days,hours,minutes,seconds,value}}. First days has value 0. Need to leave startTime parameter as first and endValue parameter as last item. Discontinuities allowed by introducing values in table twice.";

  /***   ***   ***   ***   ***   ***   ***   ***   ***   ***/
  // Internal parameters which must not be changed
protected
  parameter Modelica.SIunits.Conversions.NonSIunits.Time_hour nSecondsPerDay = 24*nSecondsPerMinute*nSecondsPerMinute
    "Numbers of hours for one day";
  parameter Modelica.SIunits.Conversions.NonSIunits.Time_minute nSecondsPerHour = nSecondsPerMinute*60
    "Numbers of minutes for one hour";
  parameter Modelica.SIunits.Time nSecondsPerMinute = 60
    "Numbers of seconds for one minute";
  parameter Real table[:,:] = {{inputIntervalsAndValue[i,1]*nSecondsPerDay + inputIntervalsAndValue[i,2]*nSecondsPerHour + inputIntervalsAndValue[i,3]*nSecondsPerMinute + inputIntervalsAndValue[i,4],  inputIntervalsAndValue[i,5]}  for i in 1:size(inputIntervalsAndValue,1)}
    "Compose table according to time/value pairings entered by user";

equation
  connect(combiTimeTable.y[1], y) annotation (Line(
      points={{22,0},{64,0},{64,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (experiment(StopTime=3.1536e+007, Interval=1000),
      __Dymola_experimentSetupOutput,
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
    Line(points={{-86,-90},{-86,68}},
                                  color={192,192,192}),
    Polygon(
      points={{-86,90},{-94,68},{-78,68},{-86,90}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-90,-86},{70,-86}},
                                  color={192,192,192}),
    Polygon(
      points={{92,-86},{70,-94},{70,-78},{92,-86}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
        Text(
          extent={{-30,-90},{18,-96}},
          lineColor={0,0,0},
          pattern=LinePattern.DashDot,
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          textString="time"),
        Text(
          extent={{-17,9},{17,-9}},
          lineColor={0,0,0},
          pattern=LinePattern.DashDot,
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          origin={-91,7},
          rotation=90,
          textString="Output signal"),
        Line(
          points={{-86,-50},{-76,-50},{-76,26},{-62,26},{-62,-50},{-54,-50},{-54,
              26},{-38,26},{-38,-52},{66,-52}},
          color={0,0,255},
          smooth=Smooth.None)}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Limitations</span></h4>
<p>Entering dates with day greater than 1 is illegal, e.g. {2,0,0,0,11.0} as this clashes with the periodicity definition. Simulation will fail.</p>
</html>", revisions="<html>
<ul>
<li>March 07, 2017&nbsp; by Georg Ferdinand Schneider &amp; Georg Ambrosius Pe&szlig;ler:<br>Implemented.</li>
</ul>
</html>
"));
end ScheduleYearly;
