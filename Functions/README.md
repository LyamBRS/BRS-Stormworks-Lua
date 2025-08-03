# Functions

This folder contains sub-folders that groups all the universally usable Lua functions I've created for things like BRIO, image encoding, and much more. Hopefully I get to a point where I unit test them to ensure that no matter what I do, their behavior stays the same.

Some functions utilize global variables. I know that's the worse coding practice there is (not really) but writing "local" wastes a lot of the very limited characters we have in Stormworks when writing Lua scripts.