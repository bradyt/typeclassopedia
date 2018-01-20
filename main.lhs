Exercises

1. Implement `Functor` instances for `Either e` and `((->) e)`.

> instance Functor (Either e) where
>   fmap :: (a -> b) -> Either e a -> Either e b
>   fmap _ (Left x)  = Left x
>   fmap f (Right y) = Right (f y)

Need to check

``` haskell
fmap id = id
fmap (f . g) = fmap f . fmap g
```



2. Implement `Functor` instances for `((,) e)` and for `Pair`, defined as

``` 
data Pair a = Pair a a
```

Explain their similarities and differences.

3. Implement a `Functor` instance for the type `ITree`, defined as

``` data ITree a = Leaf (Int -> a) 
| Node [ITree a]
```

4. Give an example of a type of kind `* -> *` which cannot be made an
instance of `Functor` (without using `undefined`).

5. Is this statement true or false?

> The composition of two `Functor`s is also a `Functor`.

If false, give a counterexample; if true, prove it by exhibiting some
appropriate Haskell code.
