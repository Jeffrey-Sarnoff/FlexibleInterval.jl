FunctionMayBe  = Nullable{Function};  typealias  MaybeFunction Union{Function, FunctionMayBe}
FunctionalNull = FunctionMayBe()

Base.isnull(x::FunctionMayBe) = x.isnull
Base.isnull(x::Function)      = false



abstract  AnyBoundaries
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



FlexibleInterval{S<:Real,T<:AnyBoundaries,A<:FunctionMaybe}(boundaries::T, action::A, lo::S,hi::S) =
    FlexibleInterval{S,T,A}(lo,hi)

FlexibleInterval{S,T<:AnyBoundaries,A<:FunctionMaybe}(::Type{T}, ::Type{A}, lo::S, hi::S) = FlexibleInterval(lo,hi)
FlexibleInterval{S,T<:AnyBoundaries}(::Type{T}, lo::S, hi::S) = FlexibleInterval(T, nullFunction, lo, hi)
FlexibleInterval{S,A<:FunctionMaybe}(::Type{A}, lo::S, hi::S) = FlexibleInterval(ClosedCloseD, A, lo, hi)
FlexibleInterval{S}(lo::S, hi::S)   = FlexibleInterval(ClosedCloseD, nullFunction, lo, hi)



