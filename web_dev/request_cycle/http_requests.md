What are some common HTTP status codes?
---2xx - Succesful request
200 OK - successfully completed HTTP request
---3xx - redirected request
300 Multiple Choices - the resource being requested had more than one possibility
301 Moved Permanently - Requested resource has a different reference now (change future requests)
302 Found - Requested resource temporarily has a different reference (don't change future requests)
304 Not Modified - If the page had no changes after a successful conditional GET request.
307 Temporary Redirect - like 302 but not
---4xx -  Client-side error
400 Bad Request - client request doesn't make any sense
401 Unauthorized - client request requires authentication before successful retrieval
403 Forbidden - client request understood but even authentication won't retrieve the resource
404 Not Found - requested resource does not exist
410 Gone - requested resource no longer exists at this request location
--- 5xx - Server-side error
500 Internal Server Error - request stopped by unexpected condition
501 Not Implemented - server can not fulfill the request because some method isn't recognized
503 Service Unavailable - request cannot  be handled temporarily
550 Permission denied - like 401 but user has access to server


What is the difference between a GET request and a POST request? When might each be used?
A GET request is sent from the client to the server in an attempt to retrieve information from the server. A POST request is sent from the client to the server in an attempt to store information on the server. GET is useful when just accessing a website without making any changes to it or submitting information to it. Any time you fill out a form or submit a comment you would be doing a POST request so the information is then stored on the websites server.


Optional bonus question: What is a cookie (the technical kind, not the delicious kind)? How does it relate to HTTP requests? cookies are a string of information that can help define a session between a server and a client. when the server first receives a request from a client it can respond with information containing a cookie. The browser will store the cookie and the cookie authenticates that it is the same suer throughout the session. The cookie can then present a security issue if a foreign entity it able to get your cookies as they are accessible to your other web dealings. 