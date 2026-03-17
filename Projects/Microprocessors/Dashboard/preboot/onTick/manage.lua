-- [BRS] - 
if g_showUI ~= g_previousShowUI then
    g_previousShowUI = g_showUI

    if g_managerState == c_stateGoToBooted then
        i = 0
        for _,v in pairs(g_vehicleNameElements) do
            setNewQuadAnimationTarget(
                v[c_elementSurface],
                i * c_companyFontFullWidth + g_centeredVehicleNameX,
                c_positionVehicleNameBootedY,
                c_companyFontWidth,
                c_companyFontHeight,
                i * c_durationVehicleNameLetter + c_durationBaseVehicleNameLetterBooted
            )

            setNewQuadAnimationTarget(
                v[c_elementColors][1],
                c_colorVehicleNameBootedR,
                c_colorVehicleNameBootedG,
                c_colorVehicleNameBootedB,
                c_colorVehicleNameBootedA,
                i * c_durationVehicleNameLetter + c_durationBaseVehicleNameLetterBooted
            )

            i=i+1
        end
    end

    if g_managerState == c_stateGoToPreboot or g_managerState == c_stateOnlyPreboot then
        i = 0
        for _,v in pairs(g_vehicleNameElements) do
            setNewQuadAnimationTarget(
                v[c_elementSurface],
                i * c_companyFontFullWidth + g_centeredVehicleNameX,
                c_positionVehicleNameShownY,
                c_companyFontWidth,
                c_companyFontHeight,
                i * c_durationVehicleNameLetter + c_durationBaseVehicleNameLetterPreBoot
            )

            setNewQuadAnimationTarget(
                v[c_elementColors][1],
                c_colorVehicleNameShownR,
                c_colorVehicleNameShownG,
                c_colorVehicleNameShownB,
                c_colorVehicleNameShownA,
                i * c_durationVehicleNameLetter + c_durationBaseVehicleNameLetterPreBoot
            )

            i=i+1
        end
    end

    if g_managerState == c_stateOff then
        i = 0
        for _,v in pairs(g_vehicleNameElements) do
            setNewQuadAnimationTarget(
                v[c_elementSurface],
                i * c_companyFontFullWidth + g_centeredVehicleNameX,
                c_positionVehicleNameOffY,
                c_companyFontWidth,
                c_companyFontHeight,
                i * c_durationVehicleNameLetter + c_durationBaseVehicleNameLetterOff
            )

            setNewQuadAnimationTarget(
                v[c_elementColors][1],
                c_colorVehicleNameOffR,
                c_colorVehicleNameOffG,
                c_colorVehicleNameOffB,
                c_colorVehicleNameOffA,
                i * c_durationVehicleNameLetter + c_durationBaseVehicleNameLetterOff
            )

            i=i+1
        end
    end
end
