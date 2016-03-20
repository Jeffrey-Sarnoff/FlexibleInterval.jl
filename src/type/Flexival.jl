

abstract       AnyInterval{     Surface,       Tension                      } <: Number

        #                     type covering   configures     perceptual
        #                     value-context   boundaries     values map

abstract       AnyFlexival{     Surface,       Tension,        Action       } <: AnyInterval{ Surface, Tension }


immutable FlexibleInterval{ Surface<:Real, Tension<:Tuple, Action:<Function } <: AnyFlexival{Surface,Tension,Action}



