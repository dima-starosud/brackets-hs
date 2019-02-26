# brackets-hs

Solution inspired by [Ed's talk](https://youtu.be/Txf7swrcLYs?t=504) to checking whether brackets in the text are properly balanced.

    >>> parse "]{}(<"
    [B [Square] [],B [] [Curly],B [Curly] [],B [] [Round],B [] [Angle]]

    >>> Brackets.concat $ parse "]{}(<"
    Just (B [Square] [Angle,Round])

    >>> isValid "]{}(<"
    False

    >>> isValid "[]{}(<>)"
    True
