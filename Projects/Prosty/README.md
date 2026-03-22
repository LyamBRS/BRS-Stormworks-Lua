## Known bugs
### Main controller
1. Unstable steering while in reverse
2. Car can be used without it being booted on (gears functions)
3. Steering velocity cancels at high speed causing PID wiggle
4. Brakelight status not working the same in MP as it does in SP
### Monitor lights
1. Invisible rgb lights stay on when car boots off
2. Small intermitent tick flicker due to usage of OnDraw
3. Hard to use in the fog
4. No color correction used. Might be worth checking