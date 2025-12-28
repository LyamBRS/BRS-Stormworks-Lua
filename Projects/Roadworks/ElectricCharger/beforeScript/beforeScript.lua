
------- [BEFORE SCRIPT] -- Drawings
--- Logo
require("Projects.Roadworks.ElectricCharger.beforeScript.logoAnimations")
--- Background
require("Projects.Roadworks.ElectricCharger.beforeScript.createBezierCurves")

------- [BEFORE SCRIPT] -- System outputs
require("Projects.Roadworks.ElectricCharger.beforeScript.initialOutputs")

------- [BEFORE SCRIPT] -- State machine
require("Projects.Roadworks.ElectricCharger.beforeScript.initialState")

------- [BEFORE SCRIPT] -- Monitor variable initial values
require("Variables.Monitor.Touch.coords")
require("Variables.Monitor.Touch.pressing")

------- [BEFORE SCRIPT] -- UI Elements
require("Projects.Roadworks.ElectricCharger.beforeScript.mainMenuElements")
require("Projects.Roadworks.ElectricCharger.beforeScript.awaitVehicleConnectionElements")