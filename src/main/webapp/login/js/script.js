// Login Form Handling
if (document.getElementById('loginForm')) {
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();
        const rememberMe = document.getElementById('remember').checked;
        const errorContainer = document.createElement('div');
        errorContainer.className = 'error-message';
        errorContainer.style.color = 'red';
        errorContainer.style.marginBottom = '15px';

        // Clear previous errors
        const existingError = document.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }

        // Username validation
        if (!username) {
            errorContainer.textContent = 'Username is required';
            document.getElementById('loginForm').prepend(errorContainer);
            document.getElementById('username').focus();
            return;
        }

        // Username format validation (alphanumeric with optional underscores/dots)
        if (!/^[a-zA-Z0-9_.]{4,20}$/.test(username)) {
            errorContainer.textContent = 'Username must be 4-20 characters (letters, numbers, _ or .)';
            document.getElementById('loginForm').prepend(errorContainer);
            document.getElementById('username').focus();
            return;
        }

        // Password validation
        if (!password) {
            errorContainer.textContent = 'Password is required';
            document.getElementById('loginForm').prepend(errorContainer);
            document.getElementById('password').focus();
            return;
        }

        // Password complexity validation
        if (password.length < 8) {
            errorContainer.textContent = 'Password must be at least 8 characters';
            document.getElementById('loginForm').prepend(errorContainer);
            document.getElementById('password').focus();
            return;
        }

        // Here you would typically send this data to a server
        const loginData = {
            username: username,
            password: password,
            rememberMe: rememberMe
        };

        // For demo purposes, just show an alert
        console.log('Login attempt:', loginData);
        alert(`Login submitted for ${username}`);

        // In a real application, you would make an AJAX call here
        // Example:

        fetch('/LoginServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(loginData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.href = 'welcome.jsp';
                } else {
                    errorContainer.textContent = data.message || 'Login failed';
                    document.getElementById('loginForm').prepend(errorContainer);
                }
            })
            .catch(error => {
                errorContainer.textContent = 'Network error occurred';
                document.getElementById('loginForm').prepend(errorContainer);
            });

    });
}

// Signup Form Handling
if (document.getElementById('signupForm')) {
    document.getElementById('signupForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = {
            firstName: document.getElementById('firstName').value.trim(),
            lastName: document.getElementById('lastName').value.trim(),
            email: document.getElementById('email').value.trim(),
            phone: document.getElementById('phone').value.trim(),
            password: document.getElementById('password').value.trim(),
            confirmPassword: document.getElementById('confirmPassword').value.trim()
        };

        const errorContainer = document.createElement('div');
        errorContainer.className = 'error-message';
        errorContainer.style.color = 'red';
        errorContainer.style.marginBottom = '15px';

        // Clear previous errors
        const existingError = document.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }

        // First name validation
        if (!formData.firstName) {
            errorContainer.textContent = 'First name is required';
            document.getElementById('signupForm').prepend(errorContainer);
            document.getElementById('firstName').focus();
            return;
        }

        // Email validation
        if (!formData.email) {
            errorContainer.textContent = 'Email is required';
            document.getElementById('signupForm').prepend(errorContainer);
            document.getElementById('email').focus();
            return;
        }

        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email)) {
            errorContainer.textContent = 'Please enter a valid email address';
            document.getElementById('signupForm').prepend(errorContainer);
            document.getElementById('email').focus();
            return;
        }

        // Password validation
        if (formData.password !== formData.confirmPassword) {
            errorContainer.textContent = "Passwords don't match!";
            document.getElementById('signupForm').prepend(errorContainer);
            document.getElementById('confirmPassword').focus();
            return;
        }

        if (formData.password.length < 8) {
            errorContainer.textContent = "Password must be at least 8 characters long!";
            document.getElementById('signupForm').prepend(errorContainer);
            document.getElementById('password').focus();
            return;
        }

        // Password complexity (at least one uppercase, one lowercase, one number)
        if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(formData.password)) {
            errorContainer.textContent = "Password must contain at least one uppercase letter, one lowercase letter, and one number";
            document.getElementById('signupForm').prepend(errorContainer);
            document.getElementById('password').focus();
            return;
        }

        // Here you would typically send this data to a server
        console.log('Signup attempt:', formData);

        // For demo purposes, just show an alert
        alert(`Account created for ${formData.firstName} ${formData.lastName}`);

        // In a real application, you would make an AJAX call here

        fetch('/SignUpServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(formData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.href = 'login.jsp?signup=success';
                } else {
                    errorContainer.textContent = data.message || 'Signup failed';
                    document.getElementById('signupForm').prepend(errorContainer);
                }
            })
            .catch(error => {
                errorContainer.textContent = 'Network error occurred';
                document.getElementById('signupForm').prepend(errorContainer);
            });

    });
}