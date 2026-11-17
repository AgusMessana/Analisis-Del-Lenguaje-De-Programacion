getChars :: Int -> IO String
getChars n = sequenceA (replicate n getChar)