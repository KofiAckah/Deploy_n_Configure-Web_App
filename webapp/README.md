# Simple Todo App

A full-stack Todo application built with Node.js, Express, MongoDB, and EJS templating.

## Features

- ✅ Create, Read, Update, Delete (CRUD) todos
- ✅ Mark todos as complete/incomplete
- ✅ Priority levels (Low, Medium, High)
- ✅ Task descriptions
- ✅ Statistics dashboard
- ✅ Responsive design
- ✅ REST API endpoints

## Tech Stack

- **Backend**: Node.js + Express.js
- **Database**: MongoDB + Mongoose
- **Frontend**: EJS templates + Vanilla JavaScript
- **Styling**: Custom CSS with modern design

## Prerequisites

- Node.js (v14 or higher)
- MongoDB (v4.4 or higher)
- npm or yarn

## Installation

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Environment

Create a `.env` file:

```bash
cp .env.example .env
```

Edit `.env` with your configuration:

```
PORT=3000
MONGODB_URI=mongodb://localhost:27017/todoapp
NODE_ENV=development
```

### 3. Start MongoDB

Make sure MongoDB is running:

```bash
# On Linux/Mac
sudo systemctl start mongod

# Or using Docker
docker run -d -p 27017:27017 --name mongodb mongo:latest
```

### 4. Run the Application

Development mode (with auto-restart):
```bash
npm run dev
```

Production mode:
```bash
npm start
```

The app will be available at `http://localhost:3000`

## Project Structure

```
webapp/
├── server.js              # Main application entry point
├── package.json           # Dependencies and scripts
├── .env.example          # Environment variables template
├── models/
│   └── Todo.js           # MongoDB Todo model
├── routes/
│   └── todos.js          # Todo routes and controllers
├── views/
│   └── index.ejs         # Main page template
└── public/
    ├── css/
    │   └── style.css     # Application styles
    └── js/
        └── main.js       # Client-side JavaScript
```

## API Endpoints

### Web Routes (HTML)
- `GET /` - Home page with all todos
- `POST /todos` - Create new todo
- `PUT /todos/:id` - Update todo
- `PUT /todos/:id/toggle` - Toggle completion status
- `DELETE /todos/:id` - Delete todo

### API Routes (JSON)
- `GET /api/todos` - Get all todos (JSON)
- `POST /api/todos` - Create todo (JSON)
- `GET /health` - Health check endpoint

## Usage Examples

### Create a Todo

Fill out the form on the home page:
- **Title**: What needs to be done?
- **Description**: Optional details
- **Priority**: Low, Medium, or High

### Complete a Todo

Click the checkbox next to a todo to mark it as complete/incomplete.

### Delete a Todo

Click the trash icon to delete a todo (will ask for confirmation).

## Deployment with Ansible

This app is designed to be deployed on an EC2 instance using Ansible. The deployment playbook will:

1. Install Node.js and MongoDB
2. Clone/copy the application
3. Install dependencies
4. Configure environment variables
5. Set up systemd service
6. Start the application

## Health Check

Visit `http://localhost:3000/health` to check:
- Server status
- Database connection
- Timestamp

## Database Schema

```javascript
{
  title: String,          // Required
  description: String,    // Optional
  completed: Boolean,     // Default: false
  priority: String,       // low, medium, high
  createdAt: Date,        // Auto-generated
  updatedAt: Date         // Auto-updated
}
```

## Future Enhancements

- [ ] User authentication
- [ ] Due dates and reminders
- [ ] Categories/Tags
- [ ] Search and filter
- [ ] Bulk operations
- [ ] Export to PDF/CSV
- [ ] Dark mode

## License

MIT

## Author

Created for AWS Terraform + Ansible deployment assignment
