newtype StateIO s a = StIO { runStIO :: s -> IO (a, s) }

# ----- Inciso a ----- #
return :: a -> StateIo s a
(>>=) :: StateIo s a -> (a -> StateIo s b) -> StateIO s b

instance Monad (StateIo s) where
  return x = StIO (\s -> return (x, s))
  (StIO h) >>= f = StIO (\s -> do (x, s') <- h s
                                  runStIo (f x) s')


# ----- Inciso b ----- #
getS :: StateIo s s
getS = StIO (\s -> return (s, s))

updateS :: (s -> s) -> StateIO s ()
updateS f = StIO(\s -> return ((), f s))

liftIO :: IO a -> StateIO s a
liftIO m = StIO (\s -> do res <- m
                          return (res, s))

# ----- Inciso c ----- #
