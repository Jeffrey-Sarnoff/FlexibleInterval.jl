MaybeFunction = Nullable{Function}
nullFunction  = MaybeFunction()
typealias       maybeFunction Union{Function, MaybeFunction}

Base.isnull(x::Function) = false


abstract AnyBoundaries
abstract  OneBoundary          <: AnyBoundaries
abstract  TwoBoundaries        <: AnyBoundaries
abstract  ThreeBoundaries      <: AnyBoundaries

abstract   Opened              <: OneBoundary
abstract   Closed              <: OneBoundary

abstract   OpenedOpened        <: TwoBoundaries
abstract   OpenedClosed        <: TwoBoundaries
abstract   ClosedOpened        <: TwoBoundaries
abstract   ClosedClosed        <: TwoBoundaries

abstract   OpenedOpenedOpened  <: ThreeBoundaries
abstract   OpenedOpenedClosed  <: ThreeBoundaries
abstract   OpenedClosedOpened  <: ThreeBoundaries
abstract   OpenedClosedClosed  <: ThreeBoundaries
abstract   ClosedOpenedOpened  <: ThreeBoundaries
abstract   ClosedOpenedClosed  <: ThreeBoundaries
abstract   ClosedClosedOpened  <: ThreeBoundaries
abstract   ClosedClosedClosed  <: ThreeBoundaries



abstract          AbsInterval{     Surface,       Tension                      } <: Number

                             #   type covering   configures     perceptual
                             #   value-context   boundaries     values map

abstract  AbsFlexibleInterval{     Surface,       Tension,        Action       } <: AbsInterval{ Surface, Tension }


immutable FlexibleInterval{ Surface <: Real, 
                            Tension <: Tuple, 
                            Action  <: MaybeFunction } <: AbsFlexibleInterval{Surface,Tension,Action}
    lo::Surface
    hi::Surface
    
    FlexibleInterval{S}(lo::S,hi::S) = (lo <= hi) ? new(lo,hi) : new(hi,lo)
end



FlexibleInterval{S,T,A}(::Type{T}, ::Type{A}, lo::S, hi::S) = FlexibleInterval{S,T,A}(lo,hi)
FlexibleInterval{S,T}(::Type{T}, lo::S, hi::S) = FlexibleInterval{S,T,A}(T, nullFunction, lo, hi)
FlexibleInterval{S,A}(::Type{A}, lo::S, hi::S) = FlexibleInterval{S,T,A}(T, nullFunction, lo, hi)




