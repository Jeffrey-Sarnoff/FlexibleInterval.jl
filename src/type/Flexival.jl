FunctionMaybe = Nullable{Function}
nullFunction  = FunctionMaybe()
typealias       MaybeFunction Union{Function, FunctionMaybe}

Base.isnull(x::Function) = false


abstract  AnyBoundaries
abstract  OneBoundary          <: AnyBoundaries
abstract  TwoBoundaries        <: AnyBoundaries
abstract  ThreeBoundaries      <: AnyBoundaries

immutable  OPened              <: OneBoundary     ; Opened             = OPened()
immutable  CLosed              <: OneBoundary     ; Closed             = CLosed()

immutable  OPenedOPened        <: TwoBoundaries   ; OpenedOpened       = OPenedOPened()      
immutable  OPenedCLosed        <: TwoBoundaries   ; OpenedClosed       = OPenedCLosed()      
immutable  CLosedOPened        <: TwoBoundaries   ; ClosedOpened       = CLosedOPened()      
immutable  CLosedCLosed        <: TwoBoundaries   ; ClosedClosed       = CLosedCLosed()      

immutable  OPenedOPenedOPened  <: ThreeBoundaries ; OpenedOpenedOpened = OPenedOPenedOPened()
immutable  OPenedOPenedCLosed  <: ThreeBoundaries ; OpenedOpenedClosed = OPenedOPenedCLosed()
immutable  OPenedCLosedOPened  <: ThreeBoundaries ; OpenedClosedOpened = OPenedCLosedOPened()
immutable  OPenedCLosedCLosed  <: ThreeBoundaries ; OpenedClosedClosed = OPenedCLosedCLosed()
immutable  CLosedOPenedOPened  <: ThreeBoundaries ; ClosedOpenedOpened = CLosedOPenedOPened()
immutable  CLosedOPenedCLosed  <: ThreeBoundaries ; ClosedOpenedClosed = CLosedOPenedCLosed()
immutable  CLosedCLosedOPened  <: ThreeBoundaries ; ClosedClosedOpened = CLosedCLosedOPened()
immutable  CLosedCLosedCLosed  <: ThreeBoundaries ; ClosedClosedClosed = CLosedCLosedCLosed()



abstract          AbsInterval{     Surface,       Tension                  } <: Number

                             #   type covering   configures     perceptual
                             #   value-context   boundaries     values map

abstract  AbsFlexibleInterval{     Surface,       Tension,        Action   } <: AbsInterval{ Surface, Tension }


immutable FlexibleInterval{ Surface <: Real, 
                            Tension <: AnyBoundaries, 
                            Action  <: MaybeFunction } <: AbsFlexibleInterval{Surface,Tension,Action}
    lo::Surface
    hi::Surface
    
    FlexibleInterval{S}(lo::S,hi::S) = (lo <= hi) ? new(lo,hi) : new(hi,lo)
end






FlexibleInterval{S,T,A}(::Type{T}, ::Type{A}, lo::S, hi::S) = FlexibleInterval{S,T,A}(lo,hi)
FlexibleInterval{S,T}(::Type{T}, lo::S, hi::S) = FlexibleInterval{S,T,A}(T, nullFunction, lo, hi)
FlexibleInterval{S,A}(::Type{A}, lo::S, hi::S) = FlexibleInterval{S,T,A}(T, nullFunction, lo, hi)




