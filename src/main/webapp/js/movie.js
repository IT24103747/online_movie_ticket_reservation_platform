document.addEventListener('DOMContentLoaded', function() {
    // Add any client-side validation or interactivity here

    // Example: Confirm before deleting a movie
    const deleteButtons = document.querySelectorAll('.btn.danger');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to delete this movie?')) {
                e.preventDefault();
            }
        });
    });

    // Example: Form validation for add/edit forms
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const title = form.querySelector('#title').value.trim();
            const description = form.querySelector('#description').value.trim();
            const releaseDate = form.querySelector('#releaseDate').value;

            if (!title || !description || !releaseDate) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
    });
});