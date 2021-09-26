using("MBAi.Company.Division.Division");
using("MBAi.Company.Division.Task.EvaluateProjectCost");
using("MBAi.Company.Division.Task.EvaluateProjectFeasibility");

import("pathfinder.rail", "RailPathFinder", 1); // Wrap that

class MBAi.Company.Division.Logistics extends MBAi.Company.Division.Division
{
    static TASK_EVALUATE_PROJECT_COST = ::MBAi.Company.Division.Task.EvaluateProjectCost;
    static TASK_EVALUATE_PROJECT_FEASIBILITY = ::MBAi.Company.Division.Task.EvaluateProjectFeasibility

    function getName()
    {
        return "logistics";
    }

    function createTasksFromEvent(_event)
    {

    }

    function createTasks()
    {

    }

    function getTasksOperations()
    {
        return [
            this.TASK_EVALUATE_PROJECT_COST(this.company),
            this.TASK_EVALUATE_PROJECT_FEASIBILITY(this.company)
        ];
    }

    function evaluateProject(_project)
    {
        foreach(destination in destinations) {

        }
    }

    function guessBestTransportMethod(_destinations)
    {
        return "trains";
    }

    function buildProject(_project)
    {
        local pathfinder = RailPathFinder();
        local startTile = _project.destinationTiles[0];
        local endTile = _project.destinationTiles[1];
        pathfinder.InitializePath([
            [startTile, startTile + ::AIMap.GetTileIndex(-1, 0)]
        ], [
            [endTile + ::AIMap.GetTileIndex(-1, 0), endTile]
        ]);

        ::AILog.Info("Calculating path.");
        local path = pathfinder.FindPath(10000);

        if(!path){
            ::AILog.Warning("No path found.");
            return;
        }

        local prev = null;
        local prevprev = null;
        ::AILog.Info("Starting to build rails.");
        while (path != null) {
            if (prevprev != null) {
                if (::AIMap.DistanceManhattan(prev, path.GetTile()) > 1) {
                    if (::AITunnel.GetOtherTunnelEnd(prev) == path.GetTile()) {
                        ::AITunnel.BuildTunnel(::AIVehicle.VT_RAIL, prev);
                    } else {
                        local bridge_list = ::AIBridgeList_Length(::AIMap.DistanceManhattan(path.GetTile(), prev) + 1);
                        bridge_list.Valuate(::AIBridge.GetMaxSpeed);
                        bridge_list.Sort(::AIAbstractList.SORT_BY_VALUE, false);
                        ::AIBridge.BuildBridge(::AIVehicle.VT_RAIL, bridge_list.Begin(), prev, path.GetTile());
                    }
                    prevprev = prev;
                    prev = path.GetTile();
                    path = path.GetParent();
                } else {
                    ::AIRail.BuildRail(prevprev, prev, path.GetTile());
                }
            }
            if (path != null) {
                prevprev = prev;
                prev = path.GetTile();
                path = path.GetParent();
            }
        }
        ::AILog.Info("Finished building rails.");
    }
}