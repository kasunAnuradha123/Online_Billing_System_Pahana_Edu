<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Customer</title>
<script src="https://cdn.tailwindcss.com"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body
	class="min-h-screen bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-800 font-sans">
	<div class="flex h-screen relative z-10">
		<!-- Sidebar -->
		<%@ include file="../components/sidebar.jsp"%>

		<!-- Main Content -->
		<div class="flex-1 flex flex-col overflow-hidden">
			<header
				class="bg-white/10 backdrop-blur-md border-b border-white/20 p-[18px] animate-fade-in">
				<div class=" lg:flex items-center justify-between">
					<div>
						<h1 class="text-3xl font-bold text-white">Customer Management</h1>
						<p class="text-white/70 text-sm mt-1">Manage your customer
							database</p>
					</div>
					<div class="flex items-center space-x-4">
						<!-- Search Bar -->
						<div class="relative">
							<input type="text" id="searchInput"
								class="w-64 p-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm pl-10"
								placeholder="Search customers..."> <i
								class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-white/50"></i>
						</div>
						<!-- Add Customer Button -->
						<button onclick="openAddModal()"
							class="px-6 py-3 bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white font-semibold rounded-xl transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-green-500/25 focus:outline-none focus:ring-2 focus:ring-green-400">
							<i class="fas fa-plus mr-2"></i>Add Customer
						</button>

					</div>


				</div>
			</header>
			<main class="flex-1 p-6 overflow-y-auto">
				<!-- Customer Table -->
				<div
					class="bg-white/10 backdrop-blur-md rounded-xl border border-white/20 shadow-2xl overflow-hidden">
					<div class="overflow-x-auto">
						<table class="min-w-full">
							<thead class="bg-white/5 backdrop-blur-sm">
								<tr>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-hashtag mr-2"></i>ID
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-user mr-2"></i>Name
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-envelope mr-2"></i>Email
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-phone mr-2"></i>Contact
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-map-marker-alt mr-2"></i>Address
									</th>
									<th
										class="px-6 py-4 text-center text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-cogs mr-2"></i>Actions
									</th>
								</tr>
							</thead>
							<tbody id="customerTableBody" class="divide-y divide-white/10">
								<!-- Sample Customer Data -->
								<tr class="hover:bg-white/5 transition-colors duration-200">
									<td class="px-6 py-4 whitespace-nowrap text-white">001</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<div class="flex items-center">
											<div
												class="w-10 h-10 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center mr-3">
												<span class="text-white font-medium text-sm">JD</span>
											</div>
											<div>
												<div class="text-white font-medium">John Doe</div>
												<div class="text-white/60 text-sm">Premium Customer</div>
											</div>
										</div>
									</td>
									<td class="px-6 py-4 whitespace-nowrap text-white">john.doe@email.com</td>
									<td class="px-6 py-4 whitespace-nowrap text-white">+1 234
										567 8900</td>
									<td class="px-6 py-4 whitespace-nowrap text-white/80">123
										Main St, New York</td>
									<td class="px-6 py-4 whitespace-nowrap text-center">
										<button onclick="openEditModal(1)"
											class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-2 rounded-lg mr-2 transition-colors duration-200">
											<i class="fas fa-edit"></i>
										</button>
										<button onclick="deleteCustomer(1)"
											class="bg-red-500 hover:bg-red-600 text-white px-3 py-2 rounded-lg transition-colors duration-200">
											<i class="fas fa-trash"></i>
										</button>
									</td>
								</tr>

								<tr class="hover:bg-white/5 transition-colors duration-200">
									<td class="px-6 py-4 whitespace-nowrap text-white">002</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<div class="flex items-center">
											<div
												class="w-10 h-10 bg-gradient-to-r from-green-500 to-teal-600 rounded-full flex items-center justify-center mr-3">
												<span class="text-white font-medium text-sm">JS</span>
											</div>
											<div>
												<div class="text-white font-medium">Jane Smith</div>
												<div class="text-white/60 text-sm">Regular Customer</div>
											</div>
										</div>
									</td>
									<td class="px-6 py-4 whitespace-nowrap text-white">jane.smith@email.com</td>
									<td class="px-6 py-4 whitespace-nowrap text-white">+1 234
										567 8901</td>
									<td class="px-6 py-4 whitespace-nowrap text-white/80">456
										Oak Ave, California</td>
									<td class="px-6 py-4 whitespace-nowrap text-center">
										<button onclick="openEditModal(2)"
											class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-2 rounded-lg mr-2 transition-colors duration-200">
											<i class="fas fa-edit"></i>
										</button>
										<button onclick="deleteCustomer(2)"
											class="bg-red-500 hover:bg-red-600 text-white px-3 py-2 rounded-lg transition-colors duration-200">
											<i class="fas fa-trash"></i>
										</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- Pagination -->
				<div class="flex items-center justify-between mt-6">
					<div class="text-white/70 text-sm">
						Showing <span class="font-medium text-white">1</span> to <span
							class="font-medium text-white">10</span> of <span
							class="font-medium text-white">247</span> results
					</div>
					<div class="flex items-center space-x-2">
						<button
							class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20 transition-colors duration-200">
							<i class="fas fa-chevron-left"></i>
						</button>
						<button
							class="px-4 py-2 bg-gradient-to-r from-pink-500 to-purple-600 text-white rounded-lg font-medium">1</button>
						<button
							class="px-4 py-2 bg-white/10 border border-white/20 text-white rounded-lg hover:bg-white/20 transition-colors duration-200">2</button>
						<button
							class="px-4 py-2 bg-white/10 border border-white/20 text-white rounded-lg hover:bg-white/20 transition-colors duration-200">3</button>
						<button
							class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20 transition-colors duration-200">
							<i class="fas fa-chevron-right"></i>
						</button>
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
