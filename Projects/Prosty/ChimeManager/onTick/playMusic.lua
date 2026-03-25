-- [BRS] - [[ INFORMATIONS ]] -
-- onTick logic managing the playing of the current music.

if g_playingMusic then
    playStatus = playMusic(g_currentMusic)
    if playStatus == c_base64MusicFinished then
        g_awaitedMusic = false  -- Resume logic operations
        g_playingMusic = false
    end
end

