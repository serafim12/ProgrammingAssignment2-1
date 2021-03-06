
makeCacheMatrix <- function(x = matrix()) {
        cache <- NULL
        set <- function(y) {
                x <<- y
                cache <<- NULL
        }
        get <- function() x
        setMatrix <- function(inverse) cache <<- inverse
        getInverse <- function() cache
        list(set = set, get = get,
             setMatrix = setMatrix,
             getInverse = getInverse)
}
cacheSolve <- function(x, ...) {
        cache <- x$getInverse()
        if (!is.null(cache)) {
                message("getting cached data")

                # display matrix in console
                return(cache)
        }

        matrix <- x$get()
        tryCatch( {
        cache <- solve(matrix, ...)
        },
        error = function(e) {
                message("Error:")
                message(e)
                return(NA)
        },
        warning = function(e) {
                message("Warning:")
                message(e)
                return(NA)
        },
        finally = {
               x$setMatrix(cache)
        } )
        return (cache)
}