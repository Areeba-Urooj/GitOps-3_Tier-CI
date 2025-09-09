# Microblog API

A RESTful API for a simple microblogging application built with Go and Gin framework.

## Features

- 🚀 RESTful API with full CRUD operations for blog posts
- 🔐 JWT-based authentication system
- 🗄️ PostgreSQL database integration with GORM
- 🐳 Docker and Docker Compose support
- 📝 Comprehensive error handling
- 🏗️ Clean architecture with separation of concerns
- 📊 Database migrations and seeding

## Tech Stack

- **Language**: Go 1.21+
- **Framework**: Gin
- **Database**: PostgreSQL
- **ORM**: GORM
- **Authentication**: JWT
- **Containerization**: Docker

## Project Structure

```
microblog-api/
├── main.go                 # Application entry point
├── go.mod                  # Go module dependencies
├── go.sum                  # Go module checksums
├── Dockerfile              # Docker container configuration
├── docker-compose.yml      # Docker Compose setup
├── init.sql               # Database initialization
├── .env.example           # Environment variables template
├── database/
│   └── database.go        # Database connection and configuration
├── models/
│   ├── user.go            # User model and methods
│   └── post.go            # Post model and DTOs
├── handlers/
│   ├── auth.go            # Authentication handlers
│   └── posts.go           # Post CRUD handlers
└── middleware/
    └── auth.go            # JWT authentication middleware
```

## API Endpoints

### Authentication
- `POST /api/v1/register` - Register a new user
- `POST /api/v1/login` - Login user and get JWT token

### Posts (Public)
- `GET /api/v1/posts` - Get all posts
- `GET /api/v1/posts/{id}` - Get a specific post

### Posts (Protected - requires JWT token)
- `POST /api/v1/posts` - Create a new post
- `PUT /api/v1/posts/{id}` - Update a post (author only)
- `DELETE /api/v1/posts/{id}` - Delete a post (author only)

### Health Check
- `GET /health` - API health status

## Quick Start with Docker

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd microblog-api
   ```

2. **Start with Docker Compose**
   ```bash
   docker-compose up -d
   ```

   This will start both the PostgreSQL database and the API server.

3. **The API will be available at**: `http://localhost:8080`

## Manual Setup

### Prerequisites

- Go 1.21 or later
- PostgreSQL 12 or later
- Git

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd microblog-api
   ```

2. **Install dependencies**
   ```bash
   go mod tidy
   ```

3. **Set up PostgreSQL database**
   ```bash
   # Create database
   createdb microblog

   # Run the initialization script
   psql -d microblog -f init.sql
   ```

4. **Configure environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your database credentials
   ```

5. **Run the application**
   ```bash
   go run main.go
   ```

## Environment Variables

Create a `.env` file in the root directory with the following variables:

```env
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=microblog
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
GIN_MODE=debug
PORT=8080
```

## Usage Examples

### Register a new user
```bash
curl -X POST http://localhost:8080/api/v1/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "johndoe",
    "email": "john@example.com",
    "password": "password123"
  }'
```

### Login
```bash
curl -X POST http://localhost:8080/api/v1/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123"
  }'
```

### Create a post (requires token)
```bash
curl -X POST http://localhost:8080/api/v1/posts \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "title": "My First Post",
    "content": "This is the content of my first blog post!"
  }'
```

### Get all posts
```bash
curl -X GET http://localhost:8080/api/v1/posts
```

## Database Schema

### Users Table
| Column | Type | Description |
|--------|------|-------------|
| id | SERIAL | Primary key |
| username | VARCHAR(30) | Unique username |
| email | VARCHAR(255) | Unique email address |
| password | VARCHAR(255) | Hashed password |
| created_at | TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | Last update time |

### Posts Table
| Column | Type | Description |
|--------|------|-------------|
| id | SERIAL | Primary key |
| title | VARCHAR(200) | Post title |
| content | TEXT | Post content |
| author_id | INTEGER | Foreign key to users table |
| created_at | TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | Last update time |

## Development

### Running Tests
```bash
go test ./...
```

### Building for Production
```bash
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .
```

### Docker Build
```bash
docker build -t microblog-api .
```

## Security Considerations

- Always change the `JWT_SECRET` in production
- Use HTTPS in production environments
- Implement rate limiting for production use
- Consider adding input validation and sanitization
- Use environment-specific configuration files

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.