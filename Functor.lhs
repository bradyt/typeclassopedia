1. Implement `Functor` instances for `Either e` and `((->) e)`.

> instance Functor (Either e) where
>   fmap :: (a -> b) -> Either e a -> Either e b
>   fmap _ (Left x)  = Left x
>   fmap f (Right y) = Right (f y)

Prove the following:

> fmap id = id
> fmap (f . g) = fmap f . fmap g

First we check `id`.

> fmap id (Left x) = Left x = id (Left x)
> fmap id (Right y) = Right (id y) = Right y = id (Right y)

Then `(f . g)`.

> fmap (f . g) Left x = Left x
> (fmap f . fmap g) (Left x) = fmap f (Left x) = Left x

> fmap (f . g) Right y = Right (f (g y))
> (fmap f . fmap g) (Right y) = fmap f (Right (g y)) = Right (f (g y))

> instance Functor ((->) e) where
>   fmap :: (a -> b) -> (e -> a) -> (e -> b)
>   fmap f g = f . g

> fmap id f = id . f = f = id f
> fmap (f . g) h = f . g . h
> (fmap f . fmap g) h = fmap f (g . h) = f . g . h

2. Implement `Functor` instances for `((,) e)` and for `Pair`, defined as

> data Pair a = Pair a a

> instance Functor ((,) e) where
>   fmap :: (a -> b) -> (e, a) -> (e, b)
>   fmap f (x, y) = (x, f y)

> fmap id (x, y) = (x, id y) = (x, y) = id (x, y)
> fmap (f . g) (x, y) = (x, f (g y))
> (fmap f . fmap g) (x, y) = fmap f (x, g y) = (x, f (g y))

> instance Functor Pair where
>   fmap :: (a -> b) -> Pair a -> Pair b
>   fmap f (Pair x y) = Pair (f x) (f y)

> fmap id (Pair x y) = Pair (id x) (id y) = Pair x y = id (Pair x y)
> fmap (f . g) (Pair x y) = Pair (f (g x)) (f (g y))
> (fmap f . fmap g) (Pair x y) = fmap f (Pair (g x) (g y))
>   = Pair (f (g x)) (f (g y))

Explain their similarities and differences.

3. Implement a `Functor` instance for the type `ITree`, defined as

> data ITree a = Leaf (Int -> a) | Node [ITree a]

> instance Functor ITree where
>   fmap :: (a -> b) -> ITree a -> ITree b
>   fmap f (Leaf g) = Leaf (f . g)
>   fmap f (Node xs) = Node $ map (fmap f) xs

> fmap id (Leaf f) = Leaf (id . f) = Leaf f = id (Leaf f)
> fmap id (Node xs) = Node $ map (fmap id) xs = Node xs = id (Node xs)

> fmap (f . g) (Leaf h) = Leaf (f . g . h)
> (fmap f . fmap g) (Leaf h) = fmap f (fmap g (Leaf h))
>   = fmap f (Leaf (g . h)) = Leaf (f . g . h)

> fmap (f . g) (Node xs) = Node $ map (fmap (f . g)) xs
> (fmap f . fmap g) (Node xs) = fmap f (fmap g (Node xs))
>   = fmap f (Node $ map (fmap g) xs)
>   = Node $ map (fmap f) (map (fmap g) xs)

4. Give an example of a type of kind `* -> *` which cannot be made an
instance of `Functor` (without using `undefined`).

5. Is this statement true or false?

The composition of two `Functor`s is also a `Functor`.

If false, give a counterexample; if true, prove it by exhibiting some
appropriate Haskell code.
