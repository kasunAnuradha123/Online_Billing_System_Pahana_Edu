<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Login</title>
<script src="https://cdn.tailwindcss.com"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
        tailwind.config = {
            theme: {
                extend: {
                    animation: {
                        'fade-in': 'fadeIn 0.6s ease-out',
                        'slide-up': 'slideUp 0.5s ease-out',
                        'pulse-slow': 'pulse 3s infinite',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0', transform: 'translateY(20px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' }
                        },
                        slideUp: {
                            '0%': { transform: 'translateY(100px)', opacity: '0' },
                            '100%': { transform: 'translateY(0)', opacity: '1' }
                        }
                    }
                }
            }
        }
    </script>
</head>
<body
	class="min-h-screen bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-800 flex items-center justify-center  relative overflow-auto py-10">
	<!-- Animated Background Elements -->
	<div class="absolute inset-0 overflow-hidden">
		<div
			class="absolute -top-4 -left-4 w-72 h-72 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow"></div>
		<div
			class="absolute top-1/2 -right-4 w-72 h-72 bg-pink-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-2000"></div>
		<div
			class="absolute -bottom-8 left-1/2 w-72 h-72 bg-indigo-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-4000"></div>
	</div>

	<!-- Floating Book Icons -->
	<div class="absolute top-20 left-20 text-white/10 animate-bounce">
		<i class="fas fa-book text-4xl"></i>
	</div>
	<div class="absolute top-40 right-32 text-white/10 animate-bounce"
		style="animation-delay: 1s;">
		<i class="fas fa-book-open text-3xl"></i>
	</div>
	<div class="absolute bottom-32 left-32 text-white/10 animate-bounce"
		style="animation-delay: 2s;">
		<i class="fas fa-bookmark text-2xl"></i>
	</div>

	<!-- Main Container -->
	<div class="relative z-10 w-full max-w-md">
		<!-- Logo and Brand Section -->
		<div class="text-center mb-8 animate-fade-in">
			<div
				class="inline-flex items-center justify-center w-20 h-20 bg-white/10 backdrop-blur-md rounded-full mb-4 border border-white/20">
				<i class="fas fa-book-reader text-3xl text-white"></i>
			</div>
			<h1 class="text-3xl font-bold text-white mb-2">Pahana Edu
				BookShop</h1>
			<p class="text-white/80 text-sm">Billing & Dashboard System</p>
		</div>

		<!-- Login Form -->
		<form action="<%= request.getContextPath() %>/LoginServlet" method="post" class="animate-slide-up">
			<div
				class="bg-white/10 backdrop-blur-md rounded-2xl p-8 border border-white/20 shadow-2xl">
				<h2 class="text-2xl font-bold text-white mb-6 text-center">Welcome
					Back</h2>
				<%
				String errorMessage = (String) request.getAttribute("errorMessage");
				%>
				<%
				if (errorMessage != null) {
				%>
				<div class="mb-4 text-red-500 text-center font-semibold">
					<%=errorMessage%>
				</div>
				<%
				}
				%>


				<!-- Username Field -->
				<div class="mb-6">
					<label class="block text-white/90 font-medium mb-2 text-sm">
						<i class="fas fa-user mr-2"></i>Username <span
						class="text-pink-300">*</span>
					</label>
					<div class="relative">
						<input type="text" name="username"
							class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
							placeholder="Enter your username" required>
						<div
							class="absolute inset-0 rounded-xl bg-gradient-to-r from-pink-400/20 to-purple-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
					</div>
				</div>

				<!-- Password Field -->
				<div class="mb-6">
					<label class="block text-white/90 font-medium mb-2 text-sm">
						<i class="fas fa-lock mr-2"></i>Password <span
						class="text-pink-300">*</span>
					</label>
					<div class="relative">
						<input type="password" name="password" id="password"
							class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm pr-12"
							placeholder="Enter your password" required>
						<button type="button" onclick="togglePassword()"
							class="absolute top-1/2 right-4 transform -translate-y-1/2 text-white/60 hover:text-white transition-colors duration-200 focus:outline-none">
							<i id="eyeIcon" class="fas fa-eye"></i>
						</button>
						<div
							class="absolute inset-0 rounded-xl bg-gradient-to-r from-pink-400/20 to-purple-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
					</div>
				</div>

				

				<!-- Login Button -->
				<button type="submit"
					class="w-full bg-gradient-to-r from-pink-500 to-purple-600 text-white font-semibold py-4 rounded-xl hover:from-pink-600 hover:to-purple-700 transform hover:scale-[1.02] transition-all duration-300 shadow-lg hover:shadow-pink-500/25 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:ring-offset-2 focus:ring-offset-transparent">
					<i class="fas fa-sign-in-alt mr-2"></i> Sign In
				</button>

				<!-- Additional Links -->
				<div class="mt-6 text-center">
					<p class="text-white/60 text-sm">
						New to BookShop? <a href="#"
							class="text-pink-300 hover:text-pink-200 transition-colors duration-200 hover:underline font-medium">
							Contact Administrator </a>
					</p>
				</div>
			</div>
		</form>

		<!-- Footer -->
		<div class="text-center mt-8 animate-fade-in">
			<p class="text-white/50 text-xs">© 2025 Pahana Edu BookShop.
				Secure Billing System.</p>
		</div>
	</div>

	<script>
        function togglePassword() {
            const passwordInput = document.getElementById("password");
            const eyeIcon = document.getElementById("eyeIcon");
            
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                eyeIcon.classList.remove("fa-eye");
                eyeIcon.classList.add("fa-eye-slash");
            } else {
                passwordInput.type = "password";
                eyeIcon.classList.remove("fa-eye-slash");
                eyeIcon.classList.add("fa-eye");
            }
        }

        // Enhanced checkbox functionality
        document.addEventListener('DOMContentLoaded', function() {
            const checkbox = document.querySelector('input[type="checkbox"]');
            const checkboxVisual = checkbox.nextElementSibling;
            const checkboxBg = checkboxVisual.querySelector('div:nth-child(2)');
            const checkboxIcon = checkboxVisual.querySelector('i');
            
            checkbox.addEventListener('change', function() {
                if (this.checked) {
                    checkboxBg.classList.remove('opacity-0');
                    checkboxIcon.classList.remove('opacity-0');
                } else {
                    checkboxBg.classList.add('opacity-0');
                    checkboxIcon.classList.add('opacity-0');
                }
            });
        });

        // Add subtle animations on load
        window.addEventListener('load', function() {
            document.body.classList.add('loaded');
        });

        // Form validation feedback
        const form = document.querySelector('form');
        const inputs = form.querySelectorAll('input[required]');
        
        inputs.forEach(input => {
            input.addEventListener('invalid', function(e) {
                e.preventDefault();
                this.classList.add('border-red-400');
                this.classList.remove('border-white/20');
            });
            
            input.addEventListener('input', function() {
                if (this.validity.valid) {
                    this.classList.remove('border-red-400');
                    this.classList.add('border-white/20');
                }
            });
        });
    </script>

	<style>
.animation-delay-2000 {
	animation-delay: 2s;
}

.animation-delay-4000 {
	animation-delay: 4s;
}

/* Custom focus styles */
input:focus+div {
	opacity: 1 !important;
}

/* Smooth transitions for all interactive elements */
* {
	transition-property: all;
	transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

/* Loading animation */
.loaded {
	animation: fadeIn 0.8s ease-out;
}
</style>
</body>
</html>