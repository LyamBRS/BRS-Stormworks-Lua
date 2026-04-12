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
These are the Base64 encoded music chimes, played with seatbelt buzzers, that the car uses in a bunch of different scenarios.
### Notes
Here's the base64 letters for each output of the seatbelt buzzers possible for the 4 available for prosty.
#### Bits
These are reminder of the order of each bits.
```
MSB                    LSB
highest, high, medium, low
```
#### Helper guide
This is there, so you dont have to count binary in your head every time, like a troglodite.
```lua
A:  0001    -- Only the lowest
B:  0010    -- Only medium
C:  0011
D:  0100    -- Only the high
E:  0101
F:  0110
G:  0111
H:  1000    -- Only the highest
I:  1001
J:  1010
K:  1011
L:  1100
M:  1101
N:  1110
O:  1111
P:  0000    -- Anything above plays nothing
```
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
A:D?P:E?A:X
```
### Opened access warning
Played when you're not in park, the car is on, and any access is opened.
```
D:F?F:o
```