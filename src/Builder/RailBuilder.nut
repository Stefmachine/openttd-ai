

class MBAi.Builder.RailBuilder
{
    static DIRECTIONS = {
        NONE = 0,
        NE_SW = 1, // X axis
        NW_SE = 2, // Y axis
        NW_NE = 4,
        SW_SE = 8,
        NW_SW = 16,
        NE_SE = 32
    };
    static CARDINALITIES = {
        N = 1,
        NE = 3,
        E = 2,
        SE = 10,
        S = 8,
        SW = 24,
        W = 16,
        NW = 17
    };
    static SIGNAL_TYPES = {
        NONE = 0,
        NORMAL = 1,
        ENTRY = 2,
        EXIT = 3,
        COMBO = 4,
        PBS = 5,
        PBS_OW = 6
    };

    cursor = 0;
    x = 0;
    y = 0;
    railsMap = [];
    depotMap = [];
    heightMap = [];

    constructor(_x, _y)
    {
        this.x = _x;
        this.y = _y;
        for (local i; i < _x * _y; i++) {
            this.railsMap.push(::MBAi.Builder.RailBuilder.DIRECTIONS.NONE);
            this.depotMap.push(null);
        }

        for (local i; i < (_x + 1) * (_y + 1); i++) {
            this.heightMap.push(null);
        }
    }

    at(_x, _y)
    {
        this.cursor = _y * this.x + _x;
        return this;
    }

    rail(_direction)
    {
        this.railsMap[this.cursor] = this.railsMap[this.cursor] | _direction;
        local cards = [
            ::MBAi.Builder.RailBuilder.CARDINALITIES.N,
            ::MBAi.Builder.RailBuilder.CARDINALITIES.E,
            ::MBAi.Builder.RailBuilder.CARDINALITIES.S,
            ::MBAi.Builder.RailBuilder.CARDINALITIES.W
        ];
        foreach (cardinality in cards) {
            if(this.getHeight(cardinality) == null){
                this.height(cardinality, 0);
            }
        }

        return this;
    }

    depot(_faceCardinality)
    {
        switch (_cardinality) {
            case ::MBAi.Builder.RailBuilder.CARDINALITIES.NE:
            case ::MBAi.Builder.RailBuilder.CARDINALITIES.SE:
            case ::MBAi.Builder.RailBuilder.CARDINALITIES.SW:
            case ::MBAi.Builder.RailBuilder.CARDINALITIES.NW:
                this.depotMap[this.cursor] = _cardinality;
        }

        return this;
    }

    height(_cardinality, _height)
    {
        if(_cardinality & ::MBAi.Builder.RailBuilder.CARDINALITIES.N){
            this.heightMap[this.cursor] = _height;
        }
        if(_cardinality & ::MBAi.Builder.RailBuilder.CARDINALITIES.E){
            this.heightMap[this.cursor + 1] = _height;
        }
        if(_cardinality & ::MBAi.Builder.RailBuilder.CARDINALITIES.S){
            this.heightMap[this.cursor + (this.x + 1) + 1] = _height;
        }
        if(_cardinality & ::MBAi.Builder.RailBuilder.CARDINALITIES.W){
            this.heightMap[this.cursor + (this.x + 1)] = _height;
        }

        return this;
    }

    getHeight(_cardinality)
    {
        switch (_cardinality) {
            case ::MBAi.Builder.RailBuilder.CARDINALITIES.N:
                return this.heightMap[this.cursor];
                break;
            case ::MBAi.Builder.RailBuilder.CARDINALITIES.E:
                return this.heightMap[this.cursor + 1];
                break;
            case ::MBAi.Builder.RailBuilder.CARDINALITIES.S:
                return this.heightMap[this.cursor + (this.x + 1) + 1];
                break;
            case ::MBAi.Builder.RailBuilder.CARDINALITIES.W:
                return this.heightMap[this.cursor + (this.x + 1)];
                break;
            default:
                return null;
                break;
        }
    }
}