-- [BRS] - [[ Information ]] --
-- `26/03/24`
-- ### Description
-- Stops any ongoing music and sets it to a new music to play for the next tick.
-- ### Used for
-- Managing which chimes / music plays,
-- ### @Input
-- ##### - `name` : `string` = property name of the music to play
-- ##### - `awaited` : `boolean` = if set to true when setting the music, choosing logic won't execute until its completely finished playing the music.
-- ### @Returns
-- Nothing
function setNewMusic(name, awaited)
    g_currentMusic = decodeMusic(property.getText(name))
    g_base64MusicCurrentBundle = 0
    g_base64MusicCurrentDelay = 0
    g_playingMusic = true

    -- [BRS] - Sets if the music will be fully waited after or not.
    -- The boot chime for example, is an awaited music, while ongoing alarms can be interrupted at any point.
    if awaited ~= nil then
        g_awaitedMusic = awaited
    else
        g_awaitedMusic = false
    end

    -- [BRS] - Clears all playing buzzers, so they can be heard again by the next music.
    for i=1,c_base64MusicResolution do
        output.setBool(i, false)
    end
end