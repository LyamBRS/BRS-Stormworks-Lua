------- [FUNCTIONS] - Background drawing
require("Projects.Roadworks.ElectricCharger.functions.background.handleAnimationEnd")
require("Projects.Roadworks.ElectricCharger.functions.background.handleColorAnimations")
require("Projects.Roadworks.ElectricCharger.functions.background.bezierPoints")
require("Projects.Roadworks.ElectricCharger.functions.background.drawBezier")
require("Projects.Roadworks.ElectricCharger.functions.background.createBackgroundAnimation")

------- [FUNCTIONS] - Station RGB status handling
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")

------- [FUNCTIONS] - Charger's state machine's States
require("Functions.Maths.mediumSignalStrengthToElectricStore")
require("Projects.Roadworks.ElectricCharger.functions.states.states")

------- [FUNCTIONS] - Animation framework
require("Functions.Animations.Framework.createAnimation")
require("Functions.Animations.Framework.setNewAnimationTarget")

------- [FUNCTIONS] - Drawing library
require("Functions.Drawing.Logo.brs_b")
require("Functions.Drawing.Logo.brs_r")
require("Functions.Drawing.Logo.brs_s")
require("Functions.Drawing.Gradiants.rounded45DegreeGradient")

------- [FUNCTIONS] - Element framework
require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Projects.Roadworks.ElectricCharger.functions.elements.handleAnimatedButtons")
require("Projects.Roadworks.ElectricCharger.functions.elements.drawTextOnSurface")