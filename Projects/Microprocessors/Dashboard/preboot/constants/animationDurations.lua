require("Projects.Microprocessors.Dashboard.global.constants.animations.durations.mainDuration")

-- How many ticks the first letter needs to animate
c_durationBaseVehicleNameLetterPreBoot = c_animationDurationLong  -- Going from booted to preboot
c_durationBaseVehicleNameLetterBooted = c_animationDurationNormal -- Going from preboot to booted
c_durationBaseVehicleNameLetterOff = c_animationDurationLongest   -- Going from preboot to off

-- How many ticks each following letter's animations are offset by.
c_durationVehicleNameLetter = c_animationDurationShortest