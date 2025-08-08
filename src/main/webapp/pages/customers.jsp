<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BookShop Pro - Dashboard</title>
<script src="https://cdn.tailwindcss.com"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body class="min-h-screen  font-sans">
	<!-- Main Wrapper -->
	<div class="flex h-screen">
		<!-- Sidebar -->
		<%@ include file="../components/sidebar.jsp"%>
		<!-- Main Content -->
		<div class="flex-1 flex flex-col">
			<main class="p-6 flex-1 overflow-y-auto">
				<!-- Add Customer Button -->
				<div class="mb-4">
					<a href="addCustomer.jsp"
						class="px-4 py-2 bg-green-500 hover:bg-green-600 text-white rounded-lg shadow">
						<i class="fa fa-plus"></i> Add Customer
					</a>
				</div>
				<!-- Customer Table -->
				<div class="overflow-x-auto bg-white rounded-lg shadow text-black">
					<table class="min-w-full table-auto">
						<thead class="bg-gray-200">
							<tr>
								<th class="px-4 py-2 text-left">ID</th>
								<th class="px-4 py-2 text-left">First Name</th>
								<th class="px-4 py-2 text-left">Last Name</th>
								<th class="px-4 py-2 text-left">Address</th>
								<th class="px-4 py-2 text-left">Contact</th>
								<th class="px-4 py-2 text-center">Actions</th>
							</tr>
						</thead>
					</table>
				</div>
		</div>
		</main>
	</div>
	</div>

</body>
</html>






















<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Management</title>
<script src="https://cdn.tailwindcss.com"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body
	class="min-h-screen bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-800 font-inter text-white">

	<div class="container mx-auto p-6">

		<!-- Sidebar -->
		<%@ include file="../components/sidebar.jsp"%>

		<h1 class="text-3xl font-bold mb-6">Customer Management</h1>

		<!-- Add Customer Button -->
		<div class="mb-4">
			<a href="addCustomer.jsp"
				class="px-4 py-2 bg-green-500 hover:bg-green-600 text-white rounded-lg shadow">
				<i class="fa fa-plus"></i> Add Customer
			</a>
		</div>

		<!-- Customer Table -->
		<div class="overflow-x-auto bg-white rounded-lg shadow text-black">
			<table class="min-w-full table-auto">
				<thead class="bg-gray-200">
					<tr>
						<th class="px-4 py-2 text-left">ID</th>
						<th class="px-4 py-2 text-left">First Name</th>
						<th class="px-4 py-2 text-left">Last Name</th>
						<th class="px-4 py-2 text-left">Address</th>
						<th class="px-4 py-2 text-left">Contact</th>
						<th class="px-4 py-2 text-center">Actions</th>
					</tr>
				</thead>

			</table>
		</div>
	</div>

</body>
</html>
