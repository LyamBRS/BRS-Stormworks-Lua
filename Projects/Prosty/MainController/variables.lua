-- [BRS] - Gears
selectedGear = 0
park = 0
reverse = -1
neutral = 1
drive = 2

-- [BRS] - Beams
off = 0
drl = 1
auto = 2
low = 3
high = 4
outputBeam = off
selectedBeam = off

-- [BRS] - Spotlight
spotlight = false
spotlightTiltLeft = 0
spotlightTiltRight = 0

highTilt = 0
lowTilt = -.70
highYaw = .5
lowYaw = -.25

spotlightYawRight = 0
spotlightYawLeft = 0

-- [BRS] - Blinkers & blinking
selectedBlinker = off
blinking = false
blinkLeft = 1
blinkRight = 2
blinkBoth = 3

-- [BRS] - Seat double tap prevention
previousSeatCycleBeams = false
previousUpDown = 0
previousHazards = false
previousLR = 0

-- [BRS] - Maneuverability
brakes = 0
throttle = 0
steeringLeft = 0
steeringRight = 0

-- [BRS] - Doors
locked = false
driverDoorPressed = {}
passengerDoorPressed = {}
hoodPressed = {}
trunkPressed = {}
closeAllPressed = {}

driverDoorPivot = -1
passengerDoorPivot = -1
trunkPivot = 0
hoodPivot = 0

-- [BRS] - Brake light velocity management
checkStage = 0
oldVelocity = 0
delta = 0
timeAbove = 0

brakeLight = false
reverseLight = false