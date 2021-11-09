local blueprint = ::MBAi.Builder.RailBuilder(9, 3);

local DIR = blueprint.DIRECTIONS;
local CARD = blueprint.CARDINALITIES;
local SIG = blueprint.SIGNAL_TYPES;

blueprint
    .at(0, 1).rail(DIR.NW_SE)
        .signal(SIG.NORMAL, CARD.NW)
//        .height(-1, CARD.N)
//        .depot(CARD.SW)
    .at(1, 1).rail(DIR.NW_SE)
        .rail(DIR.NW_NE)
        .rail(DIR.NW_SW)
    .at(2, 1).rail(DIR.NW_SE)
    .at(3, 1).rail(DIR.NW_SE)
    .at(4, 1).rail(DIR.NW_SE)
    .at(5, 1).rail(DIR.NW_SE)
    .at(6, 1).rail(DIR.NW_SE)
    .at(7, 1).rail(DIR.NW_SE)
        .rail(DIR.NE_SE)
        .rail(DIR.SW_SE)
    .at(8, 1).rail(DIR.NW_SE)
        .signal(SIG.NORMAL, CARD.NW)

    .at(1, 0).rail(DIR.SW_SE)
        .signal(SIG.NORMAL, CARD.NE)
    .at(2, 0).station(DIR.NW_SE)
    .at(3, 0).station(DIR.NW_SE)
    .at(4, 0).station(DIR.NW_SE)
    .at(5, 0).station(DIR.NW_SE)
    .at(6, 0).station(DIR.NW_SE)
    .at(7, 0).rail(DIR.NW_SW)
        .signal(SIG.NORMAL, CARD.NW)

    .at(1, 2).rail(DIR.NE_SE)
        .signal(SIG.NORMAL, CARD.SW)
    .at(2, 2).station(DIR.NW_SE)
    .at(3, 2).station(DIR.NW_SE)
    .at(4, 2).station(DIR.NW_SE)
    .at(5, 2).station(DIR.NW_SE)
    .at(6, 2).station(DIR.NW_SE)
    .at(7, 2).rail(DIR.NW_NE)
        .signal(SIG.NORMAL, CARD.NW)
;

::MBAi.Resource.register("blueprint.rails.station", blueprint);
// local transform = Transform().translate(-1, 0).rotate(90).flipNWSE()
// blueprint.build(Tile(50), transform);