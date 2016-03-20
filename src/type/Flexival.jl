FunctionMaybe = Nullable{Function}
nullFunction  = FunctionMaybe()
typealias       MaybeFunction Union{Function, FunctionMaybe}

Base.isnull(x::Function) = false


abstract  AnyBoundaries
abstract  OneBoundary          <: AnyBoundaries
abstract  TwoBoundaries        <: AnyBoundaries
abstract  ThreeBoundaries      <: AnyBoundaries

immutable  OpeneD              <: OneBoundary     ; Opened             = OpeneD()
immutable  CloseD              <: OneBoundary     ; Closed             = CloseD()

immutable  OpenedOpeneD        <: TwoBoundaries   ; OpenedOpened       = OpenedOpeneD()      
immutable  OpenedCloseD        <: TwoBoundaries   ; OpenedClosed       = OpenedCloseD()      
immutable  ClosedOpeneD        <: TwoBoundaries   ; ClosedOpened       = ClosedOpeneD()      
immutable  ClosedCloseD        <: TwoBoundaries   ; ClosedClosed       = ClosedCloseD()      

immutable  OpenedOpenedOpeneD  <: ThreeBoundaries ; OpenedOpenedOpened = OpenedOpenedOpeneD()
immutable  OpenedOpenedCloseD  <: ThreeBoundaries ; OpenedOpenedClosed = OpenedOpenedCloseD()
immutable  OpenedClosedOpeneD  <: ThreeBoundaries ; OpenedClosedOpened = OpenedClosedOpeneD()
immutable  OpenedClosedCloseD  <: ThreeBoundaries ; OpenedClosedClosed = OpenedClosedCloseD()
immutable  ClosedOpenedOpeneD  <: ThreeBoundaries ; ClosedOpenedOpened = ClosedOpenedOpeneD()
immutable  ClosedOpenedCloseD  <: ThreeBoundaries ; ClosedOpenedClosed = ClosedOpenedCloseD()
immutable  ClosedClosedOpeneD  <: ThreeBoundaries ; ClosedClosedOpened = ClosedClosedOpeneD()
immutable  ClosedClosedCloseD  <: ThreeBoundaries ; ClosedClosedClosed = ClosedClosedCloseD()



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
FlexibleInterval{S,A}(::Type{A}, lo::S, hi::S) = FlexibleInterval{S,T,A}(ClosedCloseD, A, lo, hi)
FlexibleInterval{S}(::Type{A}, lo::S, hi::S)   = FlexibleInterval{S,T,A}(ClosedCloseD, nullFunction, lo, hi)



