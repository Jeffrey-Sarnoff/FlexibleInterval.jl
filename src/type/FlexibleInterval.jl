MaybeFunction = Nullable{Function}
const nullFunction = MaybeFunction()
typealias AkoFunction Union{Function, MaybeFunction}

Base.isnull(x::MaybeFunction) = x.isnull
Base.isnull(x::Function)      = false


abstract  Multivalued

abstract  Surface
abstract  SurfaceAction        <: Surface
abstract  Boundary
abstract  BoundaryMaterial     <: Boundary


abstract  MateralBounding      <: Boundary
abstract  Wood                 <: MaterialBounding
abstract  Clay                 <: MaterialBounding

abstract  BoundingContext      <: Boundary
abstract  Imprecise            <: BoundingContext
abstract  Precise              <: Imprecise
abstract  Inaccurate           <: BoundingContext
abstract  Accurate             <: Inaccurate

abstract  BoundingCoverness    <: Boundary
abstract  Spread               <: BoundingCoverness
abstract  Shared               <: Spread
abstract  Throughout           <: BoundingCoverness
abstract  Approached           <: Throughout



abstract  AnyBoundaries        <: Boundary




abstract  OneBoundary          <: AnyBoundaries
abstract  TwoBoundaries        <: AnyBoundaries
abstract  ThreeBoundaries      <: AnyBoundaries



abstract          
AbsInterval{          Surface,       Tension                  } <: Number

                #   type covering   configures     perceptual
                #   value-context   boundaries     values map

abstract  
AbsFlexibleInterval{  Surface,       Tension,        Action   } <: AbsInterval{ Surface, Tension }


immutable 
FlexibleInterval{     Surface <: Real, 
                      Tension <: AnyBoundaries, 
                      Action  <: FunctionMaybe  } <: AbsFlexibleInterval{ Surface, Tension, Action }
    lo::Surface
    hi::Surface
    
    FlexibleInterval{S}(lo::S,hi::S) = (lo <= hi) ? new(lo,hi) : new(hi,lo)
end




FlexibleInterval{S<:Real,T<:AnyBoundaries,A<:FunctionMaybe}(boundaries::T, action::A, lo::S,hi::S) =
    FlexibleInterval{S,T,A}(lo,hi)

FlexibleInterval{S,T<:AnyBoundaries,A<:FunctionMaybe}(::Type{T}, ::Type{A}, lo::S, hi::S) = FlexibleInterval(lo,hi)
FlexibleInterval{S,T<:AnyBoundaries}(::Type{T}, lo::S, hi::S) = FlexibleInterval(T, nullFunction, lo, hi)
FlexibleInterval{S,A<:FunctionMaybe}(::Type{A}, lo::S, hi::S) = FlexibleInterval(ClosedCloseD, A, lo, hi)
FlexibleInterval{S}(lo::S, hi::S)   = FlexibleInterval(ClosedCloseD, nullFunction, lo, hi)



