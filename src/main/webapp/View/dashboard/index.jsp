<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Login</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-teal-400 to-cyan-600  font-sans">
<div class="absolute inset-0 overflow-hidden">
		<div
			class="absolute -top-4 -left-4 w-72 h-72 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow"></div>
		<div
			class="absolute top-1/2 -right-4 w-72 h-72 bg-pink-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-2000"></div>
		<div
			class="absolute -bottom-8 left-1/2 w-72 h-72 bg-indigo-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-4000"></div>
	</div>
    <!-- Main Wrapper -->
    <div class="flex h-screen">

        <!-- Sidebar -->
          <%@ include file="/components/sidebar.jsp" %>
       

        <!-- Main Content -->
        <div class="flex-1 flex flex-col">
            
           

            <!-- Dashboard Body -->
            <main class="p-6 flex-1 overflow-y-auto">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    
                    <!-- Card Example -->
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h2 class="text-lg font-semibold mb-2">Total Customers</h2>
                        <p class="text-3xl font-bold text-indigo-700">120</p>
                    </div>

                    <div class="bg-white p-6 rounded-lg shadow">
                        <h2 class="text-lg font-semibold mb-2">Monthly Sales</h2>
                        <p class="text-3xl font-bold text-green-600">$4,500</p>
                    </div>

                    <div class="bg-white p-6 rounded-lg shadow">
                        <h2 class="text-lg font-semibold mb-2">Stock Items</h2>
                        <p class="text-3xl font-bold text-orange-500">350</p>
                    </div>

                </div>
            </main>

        </div>
    </div>

</body>
</html>
