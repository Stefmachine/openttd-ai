class MBAi.Utils
{
    function deepClone(_container){
        // container must not have circular references
        switch(typeof(_container)){
            case "table":
                local result = clone _container;
                foreach( k,v in _container){
                    result[k] = ::MBAi.Utils.deepClone(v);
                }
                return result;
            case "array":
                return ::MBAi.Utils.Array.map(_container, function(_value, _index, _array){
                    return ::MBAi.Utils.deepClone(_value);
                });
            default:
                return _container;
        }
    }

    function toDebugString(_data)
    {
        switch(typeof(_data)){
            case "table":
                local values = [];
                foreach(k, v in _data){
                    values.push(k+": "+::MBAi.Utils.toDebugString(v));
                }
                return "{"+::MBAi.Utils.Array.join(values, ", ")+"}";
            case "array":
                return "["+::MBAi.Utils.Array.join(::MBAi.Utils.Array.map(_data, function(_value, _index, _array){
                     return ::MBAi.Utils.toDebugString(_value);
                }), ", ")+"]";
            case "bool":
                return _data ? "true" : "false";
            case "integer":
            case "float":
                return ""+_data;
            case "string":
                return "\""+_data+"\"";
            case "null":
                return "null";
            default:
                return _data+"";
        }
    }
}

class MBAi.Utils.Array
{
    function join(_array, _separator = "")
    {
        local string = "";
        foreach (index,value in _array) {
            string += value.tostring();
            if(index != _array.len() - 1){
                string += _separator;
            }
        }

        return string;
    }

    function indexOf(_array, _element)
    {
        foreach (index,value in _array) {
            if(value == _element){
                return index;
            }
        }

        return -1;
    }

    function map(_array, _mapFunction)
    {
        local mapped = [];
        foreach (index, value in _array) {
            mapped.push(_mapFunction(value, index, _array));
        }

        return mapped;
    }

    function filter(_array, _filterFunction)
    {
        local filtered = [];
        foreach (index, value in _array) {
            if(_filterFunction(value, index, _array)){
                filtered.push(value);
            }
        }

        return filtered;
    }

    function find(_array, _findFunction)
    {
        foreach (index, value in _array) {
            if(_findFunction(value, index, _array)){
                return value;
            }
        }

        return null;
    }
}

class MBAi.Utils.Statement
{
    function coalesce(...)
    {
        for (local i = 0; i < vargc; i++) {
            if(vargv[i] != null){
                return vargv[i];
            }
        }
        return null;
    }
}

class MBAi.Utils.String
{
    function split(_string, _separator = "")
    {
        local parts = [];
        if (_separator != "") {
            for (local index = _string.find(_separator); index != null; index = _string.find(_separator)) {
                parts.append(_string.slice(0, index));
                _string = _string.slice(index + _separator.len());
            }
            parts.append(_string);
        } else {
            for (local index = 0; index < _string.len(); index++) {
                parts.append(_string.slice(index, index));
            }
        }

        return parts;
    }

    function replace(_string, _search, _replacement)
    {
        return ::MBAi.Utils.Array.join(::MBAi.Utils.String.split(_string, _search), _replacement);
    }

    function pad(_string, _length, _padString, _left = true)
    {
        if(_padString.len() == 0){
            throw "Pad string must be at least one character long.";
        }

        _string = _string + "";
        _padString = _padString + "";

        while(_string.len() < _length){
            _string = (_left ? _padString + _string : _string + _padString);
        }

        return _string.len() > _length ? (_left ? _string.slice(-_length) : _string.slice(0, _length)) : _string
    }
}

class MBAi.Utils.Date
{
    function format(_date)
    {
        local day = MBAi.Utils.String.pad(::AIDate.GetDayOfMonth(_date), 2, "0");
        local month = MBAi.Utils.String.pad(::AIDate.GetMonth(_date), 2, "0");

        return day+"-"+month+"-"+::AIDate.GetYear(_date)
    }

    function dateToYear(_date, _year)
    {
        return ::AIDate.GetDate(_year, ::AIDate.GetMonth(_date), ::AIDate.GetDayOfMonth(_date));
    }

    function startOfMonth(_date)
    {
        return ::AIDate.GetDate(::AIDate.GetYear(_date), ::AIDate.GetMonth(_date), 1);
    }

    function startOfYear(_date)
    {
        return ::AIDate.GetDate(::AIDate.GetYear(_date), 1, 1);
    }
}

class MBAi.Utils.Event
{
    function getEventClass(_type)
    {
        if(!("EVENT_CLASSES" in ::MBAi.Utils.Event)){
            ::MBAi.Utils.Event.EVENT_CLASSES <- {
                [::AIEvent.ET_SUBSIDY_OFFER] = ::AIEventSubsidyOffer,
                [::AIEvent.ET_SUBSIDY_OFFER_EXPIRED] = ::AIEventSubsidyOfferExpired,
                [::AIEvent.ET_SUBSIDY_AWARDED] = ::AIEventSubsidyAwarded,
                [::AIEvent.ET_SUBSIDY_EXPIRED] = ::AIEventSubsidyExpired,
                [::AIEvent.ET_ENGINE_PREVIEW] = ::AIEventEnginePreview,
                [::AIEvent.ET_COMPANY_NEW] = ::AIEventCompanyNew,
                [::AIEvent.ET_COMPANY_IN_TROUBLE] = ::AIEventCompanyInTrouble,
                [::AIEvent.ET_COMPANY_ASK_MERGER] = ::AIEventCompanyAskMerger,
                [::AIEvent.ET_COMPANY_MERGER] = ::AIEventCompanyMerger,
                [::AIEvent.ET_COMPANY_BANKRUPT] = ::AIEventCompanyBankrupt,
                [::AIEvent.ET_VEHICLE_CRASHED] = ::AIEventVehicleCrashed,
                [::AIEvent.ET_VEHICLE_LOST] = ::AIEventVehicleLost,
                [::AIEvent.ET_VEHICLE_WAITING_IN_DEPOT] = ::AIEventVehicleWaitingInDepot,
                [::AIEvent.ET_VEHICLE_UNPROFITABLE] = ::AIEventVehicleUnprofitable,
                [::AIEvent.ET_INDUSTRY_OPEN] = ::AIEventIndustryOpen,
                [::AIEvent.ET_INDUSTRY_CLOSE] = ::AIEventIndustryClose,
                [::AIEvent.ET_ENGINE_AVAILABLE] = ::AIEventEngineAvailable,
                [::AIEvent.ET_STATION_FIRST_VEHICLE] = ::AIEventStationFirstVehicle,
                [::AIEvent.ET_DISASTER_ZEPPELINER_CRASHED] = ::AIEventDisasterZeppelinerCrashed,
                [::AIEvent.ET_DISASTER_ZEPPELINER_CLEARED] = ::AIEventDisasterZeppelinerCleared,
                [::AIEvent.ET_TOWN_FOUNDED] = ::AIEventTownFounded,
                [::AIEvent.ET_AIRCRAFT_DEST_TOO_FAR] = ::AIEventAircraftDestTooFar,
                [::AIEvent.ET_EXCLUSIVE_TRANSPORT_RIGHTS] = ::AIEventExclusiveTransportRights,
                [::AIEvent.ET_ROAD_RECONSTRUCTION] = ::AIEventRoadReconstruction,
                [::AIEvent.ET_VEHICLE_AUTOREPLACED] = ::AIEventVehicleAutoReplaced,
            }
        }

        return (type in ::MBAi.Utils.Event.EVENT_CLASSES) ? ::MBAi.Utils.Event.EVENT_CLASSES[_type] : null;
    }

    function convert(_event)
    {
        if(_event instanceof ::AIEvent){
            local type = _event.GetEventType();
            local convertClass = ::MBAi.Utils.Event.getEventClass(type);
            if(convertClass != null){
                _event = convertClass.Convert(_event);
            }

            return _event;
        }

        MBAI.Logger.error("Event convertion expected valid event type.", {type = type})
        return null;
    }
}