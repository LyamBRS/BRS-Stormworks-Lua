# BRS 1x3 Lua dashboard
## Introductions
### What is this project?
It's supposed to be a simple car / truck dashboard that uses a 1x3 monitor, for when I don't want to fiddle with more complex OS.
It's goal isn't to control anything *yet* but to simply be a status reader, of what's going on in your vehicle.

This dashboard is targetted specifically towards BRS vehicles and as such may not be as modular as expected.
Inspirations were taken from Lucid Motors dashboard.

## File managements
```
.
├── beforeScript/
│   └── Code executed when the microcontroller boots up.
├── constants/
│   └── BRS constants style declarations, for minifications. Like an enum.
├── functions/
│   └── All the custom dedicated functions created for the dashboard.
├── onDraw/
│   └── Executed steps in onDraw, dividing the logic up in sections
└── onTick/
    └── Executed steps of onTick
```

## BRIO Base64 images.
### Speed unit
#### K
```lua
CCB@A:AABDBBCBDABBDCBB
```
#### P
```lua
CCB@A:AAECACBB
```
#### H
```lua
CCB@A:AABDDABDBBCB
```
#### KPH in one
```lua
CCB@A:AABDBBCBDABBDCBBFAECFCBBKABDNABDLBCB
```
### Blinkers
#### Hazard icon
```lua
/AA@A:BACBABEC
```
### Gears (4x5)
#### Reverse
```lua
///@A:AAEBDBBBCCBBDDBCAEBBACBB
```
#### Parked
```lua
///@A:AAEBDBBBACEBADBC
```
#### Neutral
```lua
///@A:AABFDABCBCBBCDBBDEBB
```
#### In drive
```lua
///@A:AADBDBBDAEDBACBB
```

## Known bugs
### Booted screen
3. Animation direction of speed dial flipped for one of the layers
4. Speed dial's current speed stuck on display when speed is 0.