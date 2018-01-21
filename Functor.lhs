1. Implement `Functor` instances for `Either e` and `((->) e)`.

Solution for `Either e`:

> instance Functor (Either e) where
>   fmap :: (a -> b) -> Either e a -> Either e b
>   fmap _ (Left x)  = Left x
>   fmap f (Right y) = Right (f y)

Proof:

To prove implementation is correct, we need to prove the following.

> fmap id = id

> fmap id (Left x) = Left x = id (Left x)
> fmap id (Right y) = Right (id y) = Right y = id (Right y)

Solution for `((->) e)`.

> instance Functor ((->) e) where
>   fmap :: (a -> b) -> (e -> a) -> (e -> b)
>   fmap f g = f . g

Proof:

> fmap id f = id . f = f = id f

2. Implement `Functor` instances for `((,) e)` and for `Pair`, defined as

> data Pair a = Pair a a

Solution for `((,) e)`:

> instance Functor ((,) e) where
>   fmap :: (a -> b) -> (e, a) -> (e, b)
>   fmap f (x, y) = (x, f y)

Proof:

> fmap id (x, y) = (x, id y) = (x, y) = id (x, y)

Solution for `Pair`:

> instance Functor Pair where
>   fmap :: (a -> b) -> Pair a -> Pair b
>   fmap f (Pair x y) = Pair (f x) (f y)

Proof:

> fmap id (Pair x y) = Pair (id x) (id y) = Pair x y = id (Pair x y)

Explain their similarities and differences.

3. Implement a `Functor` instance for the type `ITree`, defined as

> data ITree a = Leaf (Int -> a) | Node [ITree a]

Solution:

> instance Functor ITree where
>   fmap :: (a -> b) -> ITree a -> ITree b
>   fmap f (Leaf g) = Leaf (f . g)
>   fmap f (Node xs) = Node $ map (fmap f) xs

Proof:

> fmap id (Leaf f) = Leaf (id . f) = Leaf f = id (Leaf f)
> fmap id (Node xs) = Node $ map (fmap id) xs = Node xs = id (Node xs)

The second to last equality can by proven by structural induction.

4. Give an example of a type of kind `* -> *` which cannot be made an
instance of `Functor` (without using `undefined`).

Draft:

> data X
> 
> instance Functor X where
>   fmap :: (a -> b) -> X a -> X b
>   fmap f (X x) = X (f x)

> fmap id (X x) = X (id x) = X x = id (X x)

5. Is this statement true or false?

The composition of two `Functor`s is also a `Functor`.

If false, give a counterexample; if true, prove it by exhibiting some
appropriate Haskell code.

Draft:

> instance Functor f where
>   fmap_f :: (a -> b) -> f a -> f b

> instance Functor g where
>   fmap_g :: (a -> b) -> g a -> g b

> instance Functor (f g) where
>   fmap :: (a -> b) -> (f g) a -> (f g) b
