require("Functions.Base64.Music.binaryNoteToBooleanOutputs")
require("Variables.Base64.Music.Constants.status")
require("Variables.Base64.Music.Constants.bundles")
require("Variables.Base64.Music.globals")

-- [BRS] - [[ Information ]] --
-- `26/03/24`
-- ### Description
-- Plays a decoded BRS base64 music.
-- This function ONLY WORKS when 1 music is played at the time.
-- 
-- **WARNING**
-- 
-- This function assumes you declared a constant named `c_base64MusicResolution = x`
-- which defines how many boolean composite channels the music needs to be outputed on.
-- ### Used for
-- Playing sequences of buzzers without needing to code them or worse,
-- use capacitors. With this, the users can manually change chimes and
-- musics in their vehicles either through composite or property values.
-- ### @Input
-- ##### - `music` : `table` = Output of `decodeMusic` function
-- ### @Returns
-- ##### 1. `status` : `int`
-- - `c_base64MusicFinished`: music finished, will start again at the next tick.
-- - `c_base64MusicOngoing` : Music hasnt finished yet.
function playMusic(music)
    bundle = music[g_base64MusicCurrentBundle]

    -- [BRS] - There is a bundle to play at that index. The following handles the playing.
    if bundle~=nil then
        -- [BRS] - The waiting delay finished. Go to the next bundle or finish the ongoing music
        if g_base64MusicCurrentDelay <= 0 then
            g_base64MusicCurrentBundle = g_base64MusicCurrentBundle + 1
        
            -- [BRS] - All the bundles were exhausted. Music is finished.
            if g_base64MusicCurrentBundle > #music then
                return c_base64MusicFinished
            end
        
            g_base64MusicCurrentDelay = music[g_base64MusicCurrentBundle][c_base64MusicBundleDuration]
        end

        -- [BRS] - Output all the piano keys on the right composite channels
        outputs = binaryNoteToBooleanOutputs(bundle[c_base64MusicBundleBinary])
        for i=1,c_base64MusicResolution do
            output.setBool(i,outputs[(c_base64MusicResolution-1)-i])
        end

        g_base64MusicCurrentDelay = g_base64MusicCurrentDelay - 1
    else
        -- [BRS] - There's no bundles at that index. Music restarts automatically at the next tick.
        g_base64MusicCurrentBundle = 1
        g_base64MusicCurrentDelay = music[g_base64MusicCurrentBundle][c_base64MusicBundleDuration]
    end
    return c_base64MusicOngoing
end