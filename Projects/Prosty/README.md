## Known bugs
### Main controller
1. Unstable steering while in reverse
3. Steering velocity cancels at high speed causing PID wiggle
4. Brakelight status not working the same in MP as it does in SP
### Monitor lights
2. Small intermitent tick flicker due to usage of OnDraw
3. Hard to use in the fog
4. No color correction used. Might be worth checking

## Chimes
### Boot chimes
#### Starting the vehicle
```
A:E?C:E?B:E?F:E?D:a
```
#### Shutting down the vehicle
```
D:H?F:H?B:H?C:H?A:a
```
### Seatbelt warnings
#### Low warning
```
A:E?P:G?A:o
```
#### High warning
```
```