# Demands like BEVs, where there is some flexbility, but also hard constraints.


# Import modules.
using Dates, TimeSeries


"""
Detailed representation of a flexible, mobile demand.  Typically, this may represent single or multiple battery-electric vehicles.

This records the location of the demand and its consumption of its stored energy (i.e., its battery) as a function of time, along with physical parameters and constraints: storage capacity, charge/discharge effiency, maximum charge/discharge rate, and temporal boundary conditions.  Charging represents grid-to-vehicle transfer of energy and discharging represents vehicle-to-grid transfer.

# Type parameters
- `T <: TimeType`: timestamp
- `L`            : network location

# Fields
- `locations`          : time/event series of locations of the vehicle, and their maximum charging rate [energy/time]
- `consumptions`       : time/event series of consumption rate of the vehicle [energy/time]
- `batterymin`         : constraint on minimum battery level [energy]
- `batterymax`         : constraint on maximum battery level [energy]
- `timeboundary`       : `nothing` for cyclic boundary conditions in time, or a tuple of minimum and maximum battery level allowed at the time boundaries [energy]
- `chargeratemax`      : constraint on maximum charging rate of the battery [energy/time]
- `dischargeratemax`   : constraint on maximum discharge rate of the battery, for V2G [energy/time]
- `chargeefficiency`   : efficiency of charging the battery [energy/energy]
- `dischargeefficiency`: efficiency of discharging the battery, for V2G [energy/energy]

# Example
```
example = BevDemand(
    TimeArray(
        [Time(0)          , Time(8)         , Time(9)              , Time(17)       , Time(18)         ], # [h]
        [("Home #23", 1.4), ("Road #14", 0.), ("Workplace #3", 7.7), ("Road #9", 0.), ("Home #23", 1.4)]  # [kW]
    ),
    TimeArray(
        [Time(0), Time(8), Time(9), Time(17), Time(18)],
        [     0.,     10.,      0.,      11.,       0.] # [kW]
    ),
    0., 40., # [kWh]
    nothing,
    6.6, 0.,  # [kW]
    0.90, 0.90 # [kWh/kWh]
)
```
"""
struct BevDemand{T,L} <: FlexibleDemand{T,L}
    locations           :: MobileDemand{T,Tuple{L,Float64}}
    consumptions        :: TemporalDemand{T}
    batterymin          :: Float64
    batterymax          :: Float64
    timeboundary        :: Union{Tuple{Float64,Float64},Nothing}
    chargeratemax       :: Float64
    dischargeratemax    :: Float64
    chargeefficiency    :: Float64 # FIXME: Technically, this is a joint property of the EVSE and the BEV.
    dischargeefficiency :: Float64
end


"""
The "envelope" of minimum and maximum allowable demands at each time pont, with a location for the demand.

# Arguments
- `demand :: BevDemand{T,L}`: the demand
"""
function envelope(demand :: BevDemand{T,L}) :: LocatedEnvelope{T,L} where L where T <: TimeType
    error("TO BE IMPLEMENTED")
end


"""
The demand if charging takes place as early as possible.

    # Arguments
    - `demand :: BevDemand{T,L}`: the demand
"""
function earliestdemands(demand :: BevDemand{T,L}) :: TemporalDemand{T,L} where L where T <: TimeType
    error("TO BE IMPLEMENTED")
end


"""
The demand if charging takes place as late as possible.

    # Arguments
    - `demand :: BevDemand{T,L}`: the demand
"""
function lastestdemands(demand :: BevDemand{T,L}) :: TemporalDemand{T,L} where L where T <: TimeType
    error("TO BE IMPLEMENTED")
end
