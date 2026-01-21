const express = require('express');
const router = express.Router();
const Todo = require('../models/Todo');

// GET - Home page with all todos
router.get('/', async (req, res) => {
    try {
        const todos = await Todo.find().sort({ createdAt: -1 });
        const stats = {
            total: todos.length,
            completed: todos.filter(t => t.completed).length,
            pending: todos.filter(t => !t.completed).length
        };
        res.render('index', { todos, stats });
    } catch (err) {
        console.error(err);
        res.status(500).send('Error fetching todos');
    }
});

// POST - Create new todo
router.post('/todos', async (req, res) => {
    try {
        const { title, description, priority } = req.body;
        const newTodo = new Todo({
            title,
            description,
            priority: priority || 'medium'
        });
        await newTodo.save();
        res.redirect('/');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error creating todo');
    }
});

// PUT - Update todo (toggle completed or edit)
router.put('/todos/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { title, description, priority, completed } = req.body;
        
        const updateData = {
            title,
            description,
            priority,
            completed: completed === 'on' || completed === true,
            updatedAt: Date.now()
        };
        
        await Todo.findByIdAndUpdate(id, updateData);
        res.redirect('/');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error updating todo');
    }
});

// PUT - Toggle todo completion status
router.put('/todos/:id/toggle', async (req, res) => {
    try {
        const { id } = req.params;
        const todo = await Todo.findById(id);
        if (todo) {
            todo.completed = !todo.completed;
            await todo.save();
        }
        res.redirect('/');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error toggling todo');
    }
});

// DELETE - Delete todo
router.delete('/todos/:id', async (req, res) => {
    try {
        const { id } = req.params;
        await Todo.findByIdAndDelete(id);
        res.redirect('/');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error deleting todo');
    }
});

// API Routes (JSON responses for AJAX)
router.get('/api/todos', async (req, res) => {
    try {
        const todos = await Todo.find().sort({ createdAt: -1 });
        res.json(todos);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/api/todos', async (req, res) => {
    try {
        const newTodo = new Todo(req.body);
        await newTodo.save();
        res.json(newTodo);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
