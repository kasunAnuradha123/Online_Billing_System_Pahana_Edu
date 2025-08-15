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
<body class="min-h-screen bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-800 font-sans">

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
