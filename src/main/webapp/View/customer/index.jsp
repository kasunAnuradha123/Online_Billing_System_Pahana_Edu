<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Customer</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-800 font-sans">
	<div class="flex h-screen relative z-10">
		<!-- Sidebar -->
		<%@ include file="/components/sidebar.jsp" %>

		<!-- Main Content -->
		<div class="flex-1 flex flex-col overflow-hidden">
			<header class="bg-white/10 backdrop-blur-md border-b border-white/20 p-[18px] animate-fade-in">
				<div class="lg:flex items-center justify-between">
					<div>
						<h1 class="text-3xl font-bold text-white">Customer Management</h1>
						<p class="text-white/70 text-sm mt-1">Manage your customer database</p>
					</div>
					<div class="flex items-center space-x-4">
						<!-- Search Bar -->
						<div class="relative">
							<input type="text" id="searchInput"
								class="w-64 p-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm pl-10"
								placeholder="Search customers...">
							<i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-white/50"></i>
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
				<div class="bg-white/10 backdrop-blur-md rounded-xl border border-white/20 shadow-2xl overflow-hidden">
					<div class="overflow-x-auto">
						<table class="min-w-full">
							<thead class="bg-white/5 backdrop-blur-sm">
								<tr>
									<th class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-hashtag mr-2"></i>ID
									</th>
									<th class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-user mr-2"></i>Name
									</th>
									<th class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-id-card mr-2"></i>Account No
									</th>
									<th class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-phone mr-2"></i>Contact
									</th>
									<th class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-map-marker-alt mr-2"></i>Address
									</th>
									<th class="px-6 py-4 text-center text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-cogs mr-2"></i>Actions
									</th>
								</tr>
							</thead>
							<tbody id="customerTableBody" class="divide-y divide-white/10">
								<c:forEach var="customer" items="${customers}">
									<tr class="hover:bg-white/5 transition-colors duration-200">
										<td class="px-6 py-4 whitespace-nowrap text-white">${customer.id}</td>
										<td class="px-6 py-4 whitespace-nowrap">
											<div class="flex items-center">
												<div class="w-10 h-10 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center mr-3">
													<span class="text-white font-medium text-sm">
														${fn:substring(customer.name,0,1)}
													</span>
												</div>
												<div>
													<div class="text-white font-medium">${customer.name}</div>
													<div class="text-white/60 text-sm">Customer</div>
												</div>
											</div>
										</td>
										<td class="px-6 py-4 whitespace-nowrap text-white">${customer.accountNumber}</td>
										<td class="px-6 py-4 whitespace-nowrap text-white">${customer.TP}</td>
										<td class="px-6 py-4 whitespace-nowrap text-white/80">${customer.address}</td>
										<td class="px-6 py-4 whitespace-nowrap text-center">
											<button onclick="openEditModal(${customer.id})"
												class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-2 rounded-lg mr-2 transition-colors duration-200">
												<i class="fas fa-edit"></i>
											</button>
											<button onclick="deleteCustomer(${customer.id})"
												class="bg-red-500 hover:bg-red-600 text-white px-3 py-2 rounded-lg transition-colors duration-200">
												<i class="fas fa-trash"></i>
											</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<!-- Pagination -->
				<div class="flex items-center justify-between mt-6">
					<div class="text-white/70 text-sm">
						Showing 
						<span class="font-medium text-white">${(currentPage-1) * 10 + 1}</span>
						to 
						<span class="font-medium text-white">${currentPage * 10 > totalCustomers ? totalCustomers : currentPage * 10}</span>
						of 
						<span class="font-medium text-white">${totalCustomers}</span> results
					</div>
					<div class="flex items-center space-x-2">
						<c:if test="${currentPage > 1}">
							<a href="CustomerServlet?page=${currentPage - 1}" class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
								<i class="fas fa-chevron-left"></i>
							</a>
						</c:if>

						<c:forEach begin="1" end="${totalPages}" var="i">
							<a href="CustomerServlet?page=${i}"
							   class="px-4 py-2 ${i == currentPage ? 'bg-gradient-to-r from-pink-500 to-purple-600 text-white' : 'bg-white/10 border border-white/20 text-white hover:bg-white/20'} rounded-lg font-medium">
								${i}
							</a>
						</c:forEach>

						<c:if test="${currentPage < totalPages}">
							<a href="CustomerServlet?page=${currentPage + 1}" class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
								<i class="fas fa-chevron-right"></i>
							</a>
						</c:if>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>
