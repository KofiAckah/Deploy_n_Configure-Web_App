// Main JavaScript file for Todo App

// Edit todo functionality (can be expanded later)
function editTodo(id) {
    alert('Edit functionality coming soon! ID: ' + id);
    // You can implement an inline edit or modal here
}

// Add confirmation for delete
document.addEventListener('DOMContentLoaded', function() {
    // Add smooth scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });

    // Auto-focus on title input
    const titleInput = document.querySelector('input[name="title"]');
    if (titleInput) {
        titleInput.focus();
    }

    // Add animation to new todos
    const todos = document.querySelectorAll('.todo-item');
    todos.forEach((todo, index) => {
        todo.style.opacity = '0';
        todo.style.transform = 'translateY(20px)';
        setTimeout(() => {
            todo.style.transition = 'all 0.3s ease';
            todo.style.opacity = '1';
            todo.style.transform = 'translateY(0)';
        }, index * 50);
    });
});

// Show success message after form submission
const urlParams = new URLSearchParams(window.location.search);
if (urlParams.get('success')) {
    const message = document.createElement('div');
    message.className = 'success-message';
    message.textContent = 'Task added successfully!';
    message.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: #2ecc71;
        color: white;
        padding: 15px 25px;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        z-index: 1000;
    `;
    document.body.appendChild(message);
    setTimeout(() => message.remove(), 3000);
}
