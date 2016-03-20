FunctionMaybe = Nullable{Function}
nullFunction  = FunctionMaybe()
typealias       MaybeFunction Union{Function, FunctionMaybe}

Base.isnull(x::Function) = false


abstract  AnyBoundaries
abstract  OneBoundary          <: AnyBoundaries
abstract  TwoBoundaries        <: AnyBoundaries
abstract  ThreeBoundaries      <: AnyBoundaries

immutable  OpeneD              <: OneBoundary     end; Opened             = OpeneD()
immutable  CloseD              <: OneBoundary     end; Closed             = CloseD()

immutable  OpenedOpeneD        <: TwoBoundaries   end; OpenedOpened       = OpenedOpeneD()      
immutable  OpenedCloseD        <: TwoBoundaries   end; OpenedClosed       = OpenedCloseD()      
immutable  ClosedOpeneD        <: TwoBoundaries   end; ClosedOpened       = ClosedOpeneD()      
immutable  ClosedCloseD        <: TwoBoundaries   end; ClosedClosed       = ClosedCloseD()      

immutable  OpenedOpenedOpeneD  <: ThreeBoundaries end; OpenedOpenedOpened = OpenedOpenedOpeneD()
immutable  OpenedOpenedCloseD  <: ThreeBoundaries end; OpenedOpenedClosed = OpenedOpenedCloseD()
immutable  OpenedClosedOpeneD  <: ThreeBoundaries end; OpenedClosedOpened = OpenedClosedOpeneD()
immutable  OpenedClosedCloseD  <: ThreeBoundaries end; OpenedClosedClosed = OpenedClosedCloseD()
immutable  ClosedOpenedOpeneD  <: ThreeBoundaries end; ClosedOpenedOpened = ClosedOpenedOpeneD()
immutable  ClosedOpenedCloseD  <: ThreeBoundaries end; ClosedOpenedClosed = ClosedOpenedCloseD()
immutable  ClosedClosedOpeneD  <: ThreeBoundaries end; ClosedClosedOpened = ClosedClosedOpeneD()
immutable  ClosedClosedCloseD  <: ThreeBoundaries end; ClosedClosedClosed = ClosedClosedCloseD()



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



