# R Programming Assignment 2

# Begin by creating special "matrix" object that is able to cache its inverse

#Define makeCacheMatrix as fxn taking 3 arguments:x, nrow, and  ncol

# Note that only square matrices are invertible, therefore default values of ncol and nrow may
#be set as the square root of the length of vector x. We will still allow the user to input alternate 
# values, though later solving function will return an error
makeCachematrix<-function(x, nrow=sqrt(length(x)), ncol=sqrt(length(x))){
      # Create a matrix with arguments as defined in parent function arguments, assign to variable m
      m<-matrix(x, nrow=nrow,ncol=ncol)
      # Set original inverse value as equal to placeholder NULL
      inv<-NULL
      # Create function to set variable m in parent environment as equal to new input y,
      # Reset inv to NULL as will not have been calculated for new data input
      set<-function(y, nrow=sqrt(length(y)), ncol=sqrt(length(y))){
            # Once again users are able to supply differing values for nrow and ncol though only 
            # solvable inputs will be equal to defaults
            m<<-matrix(y, nrow=nrow, ncol=ncol)
            inv<<-NULL
      }
      # Get is fxn that returns m as specified through original arguments
      get<-function() m
      # setinv sets value of inv in parent environment to specified values
      # setinv should also create an n*n matrix by default as these are the only ones that are 
      #possibly invertible
      setinv<-function(z, ncol=sqrt(length(z)), nrow=sqrt(length(z))){
            inverse<-matrix(z, ncol=ncol, nrow=nrow)
            inv<<-inverse
      }
      # get inv returns the value of inv, initially set to NULL      
      getinv<-function() inv
      # Here create a list that will later be able to be referenced by other functions
      # Final output of original fxn is list, each element of which calls a fxn defined in
      #fxn makeCachematrix
      list(set=set,
           get=get,
           setinv=setinv,
           getinv=getinv)
           
}

# Now time to create second function to solve the matrix from the original makeCachematrix fxn. If 
# the matrix has already been cached, the function will retrieve the cached matrix and display 
#the string 'retriving cached matrix' instead

# Matrix takes input, input should a variable that the output of makeCachematrix
#is assigned to
cacheSolve<-function(x, ...){
      # Create internal variable m that retrieves value of getinv from list=input=x
      m<-x$getinv()
      # if (getinv = NULL) is false, i.e. if variable exists, send message
      # and retrieve data
      if(!is.null(m)){
            message("getting cached inverse")
            return(m)
      }
      # otherwise solve the matrix and set to list generated by makeCachematrix fxn
      mat<-x$get()
      inv<-solve(mat)
      x$setinv(inv)
      inv
}

# If user wants to validate that function operates correctly note that may assign values
# to results of functions get() and getinv() then matrix multiply using %*%. Result
# should be the identity matrix

