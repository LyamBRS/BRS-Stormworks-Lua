require("Functions.Strings.split")
require("Functions.Base64.Conversions.letterToNumber")
require("Variables.Base64.Music.Constants.bundles")
require("Variables.Base64.Music.Constants.seperators")
-- [BRS] - [[ Information ]] --
-- `26/03/24`
-- ### Description
-- This function decodes BRS base64 encoded, multi channel musics into playable music
-- that can be played with buzzers. The music encoding goes as follows:
--
-- - music = bundles?bundles?bundles
-- - bundle = binaryPianoKeys : tick duration
-- ### Used for
-- Decoding received music strings or property values into playable bus music.
-- ### @Input
-- ##### - `music` : `string` = input base64 string to decode.
-- ### @Returns
-- ##### 1. `notes` : `table`
-- {{binary, ticks},{binary, ticks},{binary, ticks},{binary, ticks}}
function decodeMusic(music)
    notes = {}
	chunks = split(music, c_base64MusicNoteSeperator)

    for i=1, #chunks do
        currentChunk = chunks[i]
    	if string.find(currentChunk, c_base64MusicBundleSeperator) then
    		bundle = split(currentChunk,c_base64MusicBundleSeperator)
    		bundle[c_base64MusicBundleBinary] = numberFromBase64(bundle[c_base64MusicBundleBinary])
       		bundle[c_base64MusicBundleDuration] = numberFromBase64(bundle[c_base64MusicBundleDuration])
    		notes[#notes+1] = bundle
    	else
    		notes[#notes+1] = notes[numberFromBase64(currentChunk)+1]
    	end
    end
    return notes
end
