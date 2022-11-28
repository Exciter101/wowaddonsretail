local myname, ns = ...

ns.hiddenConfig = {
    groupsHidden = true,
}

ns.groups["puzzlecache"] = "Caches of Creation"
ns.groups["lostovoid"] = "{item:190239:Lost Ovoid}"
ns.groups["soulshape"] = "Soulshapes"
ns.groups["coreless"] = "Coreless Automa"
ns.groups["junk"] = BAG_FILTER_JUNK

ns.defaults.profile.groupsHiddenByZone[1970] = {
    puzzlecache = true,
    coreless = true,
    junk = true,
}
ns.defaults.profile.achievementsHidden[15229] = true

-- After Sylvanas' epilogue in Penance and Renewal (65297)...
-- 65511 tracks listening to the Windrunner sisters 
-- 65607 tracks listening to Genn and Anduin in the Crucible
-- 65609 tracks listening to Lor'themar and Genn in the Crucible
-- 65612 tracks listening to Lor'themar and Baine in the Crucible
-- 65614 tracks listening to Arbiter Pelegos and Kleia in the Crucible
-- 65618 tracks listening to Bolvar and Mograine
-- 66316 tracks listening to Bolvar and Taelia