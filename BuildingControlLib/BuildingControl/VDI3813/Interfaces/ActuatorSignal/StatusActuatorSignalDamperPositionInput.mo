within BuildingControlLib.BuildingControl.VDI3813.Interfaces.ActuatorSignal;
connector StatusActuatorSignalDamperPositionInput
  "Input connector of StatusActuatorSignalDamperPosition"
 extends Partial.PartialInput;
 input
    BuildingControlLib.BuildingControl.VDI3813.Types.ActuatorSignal.StatusActuatorSignalDamperPosition
  statusActuatorSignalDamperPosition;
end StatusActuatorSignalDamperPositionInput;