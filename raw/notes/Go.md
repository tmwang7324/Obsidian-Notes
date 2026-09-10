
# Go Project

# Winter Break Course

- Microservice/Distributed Environment
- Matches Job Description with distributed services, microservices, Docker, Kubernetes

![image.png](image.png)

We will be using Golang

LeetCode

System Design

### Why Golang

- Golang is very popular right now
- Not many schools teach Golang
- 

```python
    #, sccount+=1][][  rootIndexrootIndexdfs(count = 0mat[rootIndex+1][rootIndex-1]=+1  
            if mat[sr+1][sc] != 0:
                
            if mat             #starts = set()print(i)            
            
        
        #interval <#newInterava#newIntervals = []#   ##print(intervals)if i == len(intervals):#breaki+=1#print(i)print(intervals[1])baseInterval and i != len(intervals)=intervals.pop(i)                     baseInterval = intervals[i]            
                            
            

        newInterval[1] >= intervals[i][1]:   
```

# Go and Stuff

### Shallow Copying vs Deep Copy

shallow copy allows another object to modify the variable it copied

Primitive types are not affected

```python

```

### Pointers

- Passing by value vs. Passing by reference
- All function parameters are passed by value by default,
- If a parameter is passed by value, then its value is copied and passed into the function **(IMMUTABLE)**
- If a parameter is passed by reference using a pointer, then you can modify the parameter itself in the function
- 

```go
func addOne(int *x) {
	*x++
}

func main() {
	x := 10
	fmt.Println(x) => 10
	addOne(&x)
	fmt.Println(x) => 11
}
	
```

Angular View.js

# Go backend

![image.png](image%202.png)

### go.sum vs go.mod

Checks the integrity of the libraries you imported

Changes when library is modified

### Starting a server

```go
webPort := ":3000"
srv:= &http.Server {
	Addr: fmt.Sprintf(":%s", webPort)
	Handler: http.HandlerFunc(basicHandlerFunction)
	Handler: chi.newRouter()	
}
err:= srv.ListenAndServe()
if err != nil {
	log.Panic(err)
}
func basicHandlerFunction(w http.ResponseWriter, r *http.Request) {
	w.write([]byte("Welcome to Broker Page")
}	
```

### Why is Request a Pointer in HandlerFuncs

There will be multiple instances of requests in a program (multiple get/post functions), thus a pointer would allow me to access the correct memory address and possibly change it.
With no pointer, a parameter creates a copy of the request object value

### Why use byte for Response

Size of byte arrays are small → efficient

Bytes in Go are in binary:

Strings become ASCII

### Go Heartbeat

Show a server is available by periodically sending a message to all the other servers.

### Go Chi

- Cors
- Routers - automatically conforms to the http.Handler interface
- Middleware

# Running every file in a package

```bash
PS C:\Users\jw300\winterproject\broker-service> go run ./cmd/api
```

```bash

```

1. go mod init github.com/sammy/randomI don’t understand the Config class

### 

## Go SQL

```go
//User object
type User struct {
	ID 	 int64  `json:"id"`
	Email string `json:"email"`
	FirstName string `json:"first_name,omitempty"`
	LastName string `json:"last_name,omitempty"`
	Password string `json:"-"`
	Active int `json:"active"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}

type Models struct {
	User User
}

// New is the function used to create an instance of the data package. It returns the type
// Model, which embeds all the types we want to be available to our application.
// Used to retrieve information
// Does not structure the database into Models and User Types
func New(dbPool *sql.DB) Models {
	db = dbPool

	return Models{
		User: User{},
	}
}

func (u *User) GetByEmail(email string) (*User, error) {
	ctx, cancel := context.WithTimeout(context.Background(), dbTimeout)
	defer cancel()
	query := `SELECT id, email, first_name, last_name, password, active, created_at, updated_at FROM users WHERE email = $1`
	var user User
	row := db.QueryRowContext(ctx, query, email)
	err := row.Scan(
		&user.ID,
		&user.Email,
		&user.FirstName,
		&user.LastName,
		&user.Password,
		&user.Active,
		&user.CreatedAt,
		&user.UpdatedAt,
	)
	if err != nil {
		return nil, err
	}

	return &user, nil

}
```

## Go API

```go
//Used to register a HTTP route with a handler function for any HTTP request 
mux.HandleFunc("/api/hello", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		fmt.Println(w, `{"message": "Hello from Go backend!"}`)
	})
	
// GET /api/hello => "Hello from Go backend"
// 
```

```
alphabet = [0 for i in range(26)]
        for c in s:
            alphabet[ord(c) - 97] +=1  taking popping and appending all elements of inS
```
