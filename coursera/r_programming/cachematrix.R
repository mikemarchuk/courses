## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
    #initial value for inverse matrix
    inv_x <<- NULL
    #set function for matrix (constructor)
    set <- function(y) {
        #set matrix
        x <<- y
        #set inverse matrix
        inv_x <<- NULL
    }
    #get and return matrix
    get <- function() x
    #set inverse matrix
    set_inverse <- function(value) inv_x <<- value
    #get and return inverse matrix
    get_inverse <- function() inv_x
    #a special "vector", which is really a list containing a function
    list(set = set, get = get, set_inverse = set_inverse, get_inverse = get_inverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    #get the inverse matrix for x
    inverse_matrix <- x$get_inverse()
    #if the inverse matrix not null then print message that this inverse matrix getting from cache 
    #and return it
    if(!is.null(inverse_matrix)) {
        message("Getting cached data for inverse matrix")
        return(inverse_matrix)
    }
    #else get the matrix from x
    matrix <- x$get()
    #compute the inverse matrix
    inverse_matrix <- solve(matrix)
    #save it in x
    x$set_inverse(inverse_matrix)
    #and return it
    inverse_matrix
}