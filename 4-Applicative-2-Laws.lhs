
1. (Tricky) One might imagine a variant of the interchange law that
says something about applying a pure function to an effectful
argument. Using the above laws, prove that

> pure f <*> x = pure (flip ($)) <*> x <*> pure f

Proof:

> pure (flip ($)) <*> x <*> pure f
> = -- interchange
> pure ($ f) <*> (pure (flip ($)) <*> x)
> = -- composition
> pure (.) <*> pure ($ f) <*> pure (flip ($)) <*> x
> = -- homomorphism
> pure (((.) ($ f)) (flip ($))) <*> x
> = -- pointfree.io
> pure f <*> x

(Worked on this one for a while, till finally looking online for an
idea. The first step is a great idea, the rest is pretty
straightforward. To summarize, the first step does whatever it takes
to get `f` to the left (over the left associativity). All my
long-winded previous attempts never even got that far.)
