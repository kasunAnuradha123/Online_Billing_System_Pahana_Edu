<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Sales</title>
<script src="https://cdn.tailwindcss.com"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>


	

</head>
<body
	class="min-h-screen bg-gradient-to-br from-teal-400 to-cyan-600  font-sans">
	<div class="absolute inset-0 overflow-hidden">
		<div
			class="absolute -top-4 -left-4 w-72 h-72 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow"></div>
		<div
			class="absolute top-1/2 -right-4 w-72 h-72 bg-pink-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-2000"></div>
		<div
			class="absolute -bottom-8 left-1/2 w-72 h-72 bg-indigo-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-4000"></div>
	</div>
	<div class="flex h-screen relative z-10">
		<!-- Sidebar -->
		<%@ include file="/components/sidebar.jsp"%>

		<!-- Main Content -->
		<div class="flex-1 flex flex-col overflow-hidden">
			<header
				class="bg-white/10 backdrop-blur-md border-b border-white/20 p-[18px] animate-fade-in">
				<div class="lg:flex items-center justify-between">
					<div>
						<h1 class="text-3xl font-bold text-white">Sales Management</h1>
						<p class="text-white/70 text-sm mt-1">Manage your Sales</p>
					</div>
					<div class="flex items-center space-x-4">
						<!-- Search Bar -->
						<div class="relative">
							<input type="text" id="searchInput"
								class="w-64 p-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm pl-10"
								placeholder="Search customers..."> <i
								class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-white/50"></i>
						</div>

					</div>
				</div>
			</header>

			<main class="flex-1 p-6 overflow-y-auto">
				<!-- Sales Table -->

				
				
				<div
					class="bg-white/10 backdrop-blur-md rounded-xl border border-white/20 shadow-2xl overflow-hidden">
					<div class="overflow-x-auto">

						<table class="min-w-full">

							<thead class="bg-white/5 backdrop-blur-sm">
								<tr>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-hashtag mr-2"></i>Order ID
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-user mr-2"></i>Customer
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-user mr-2"></i>Sub Total
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-id-card mr-2"></i>Discount
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-phone mr-2"></i>Net Total
									</th>

									<th
										class="px-6 py-4 text-center text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-cogs mr-2"></i>Actions
									</th>
								</tr>
							</thead>
							<tbody id="orderTableBody" class="divide-y divide-white/10">
								<c:forEach var="order" items="${orders}">
									<tr class="hover:bg-white/5 transition-colors duration-200">
										<td class="px-6 py-4 whitespace-nowrap text-white">${order.id}</td>
										<td class="px-6 py-4 whitespace-nowrap text-white">${order.customerName}</td>
										<td class="px-6 py-4 whitespace-nowrap text-white">${order.totalAmount + order.discount}</td>
										<td class="px-6 py-4 whitespace-nowrap text-white">${order.discount}</td>
										<td class="px-6 py-4 whitespace-nowrap text-white">${order.totalAmount}</td>

										<td class="px-6 py-4 whitespace-nowrap text-center">
    <button type="button" onclick="openOrderItemsModal(${order.id})"
        class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-2 rounded-lg mr-2 transition-colors duration-200">
        <i class="fas fa-eye"></i>
    </button>

    <button type="button" onclick="openDeleteModal(${order.id})"
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
						Showing <span class="font-medium text-white">${(currentPage-1) * 10 + 1}</span>
						to <span class="font-medium text-white">${currentPage * 10 > totalOrders ? totalOrders : currentPage * 10}</span>
						of <span class="font-medium text-white">${totalOrders}</span>
						results
					</div>
					<div class="flex items-center space-x-2">
						<c:if test="${currentPage > 1}">
							<a href="SalesServlet?page=${currentPage - 1}"
								class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
								<i class="fas fa-chevron-left"></i>
							</a>
						</c:if>

						<c:forEach begin="1" end="${totalPages}" var="i">
							<a href="SalesServlet?page=${i}"
								class="px-4 py-2 ${i == currentPage ? 'bg-gradient-to-br from-teal-100 to-cyan-600 text-white' : 'bg-white/10 border border-white/20 text-white hover:bg-white/20'} rounded-lg font-medium">
								${i} </a>
						</c:forEach>

						<c:if test="${currentPage < totalPages}">
							<a href="SalesServlet?page=${currentPage + 1}"
								class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
								<i class="fas fa-chevron-right"></i>
							</a>
						</c:if>
					</div>
				</div>
				<!-- Modal -->
				<!-- Order Items Modal -->
				<div id="orderItemsModal"
					class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden">
					<div
						class="bg-white rounded-2xl max-w-2xl w-full p-6 relative shadow-2xl">
						<h2 class="text-gray-800 text-2xl font-bold mb-4">Order
							Details</h2>
						<table class="min-w-full text-gray-700 mb-4">
							<thead>
								<tr class="border-b">
									<th class="px-4 py-2 text-left">Item</th>
									<th class="px-4 py-2 text-left">Price</th>
									<th class="px-4 py-2 text-left">Quantity</th>
									<th class="px-4 py-2 text-left">Total</th>
								</tr>
							</thead>
							<tbody id="orderItemsBody">
							</tbody>
						</table>
						<button onclick="closeOrderItemsModal()"
							class="px-5 py-2 bg-red-600 hover:bg-red-700 text-white rounded-xl">
							Close</button>
					</div>
				</div>



				<!-- Delete Confirmation Modal -->
				<div id="deleteModal"
					class="fixed inset-0 flex items-center justify-center bg-black/50 hidden z-50">
					<div
						class="bg-gradient-to-br from-teal-400 to-cyan-600 p-6 rounded-2xl shadow-lg w-96">
						<h2 class="text-lg font-semibold text-white mb-4">
							<i class="fas fa-exclamation-triangle text-yellow-400 mr-2"></i>
							Confirm Delete
						</h2>
						<p class="text-white mb-6">Are you sure you want to delete
							this customer?</p>
						<div class="flex justify-end gap-3">
							<button type="button" onclick="closeDeleteModal()"
								class="px-5 py-2 bg-white/10 border border-white/20 text-white rounded-xl hover:bg-white/20 transition-all duration-300">
								Cancel</button>
							<form method="post" action="SalesServlet">
								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="id" id="deleteCustomerId">
								<button type="submit"
									class="px-4 py-2 rounded-lg bg-red-600 hover:bg-red-700 text-white transition">
									Yes, Delete</button>
							</form>
						</div>
					</div>
				</div>



			</main>
		</div>
	</div>
	<script>
	<!-- Modal  -->
	function openOrderItemsModal(orderId) {
	    fetch('SalesServlet', {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	        body: 'action=view&id=' + orderId
	    })
	    .then(response => response.json())
	    
	    .then(data => {
	    	 console.log("Received data:", data);
	        const tbody = document.getElementById('orderItemsBody');
	        tbody.innerHTML = '';
	        data.forEach(item => {
	            tbody.innerHTML += `<tr>
	                <td class="px-4 py-2">\${item.name}</td>
	                <td class="px-4 py-2">\${item.itemPrice}</td>
	                <td class="px-4 py-2">\${item.qty}</td>
	                <td class="px-4 py-2">\${item.total}</td>
	            </tr>`;
	        });
	        document.getElementById('orderItemsModal').classList.remove('hidden');
	    });
	}

	function closeOrderItemsModal() {
	    document.getElementById('orderItemsModal').classList.add('hidden');
	}



	<!-- Delete -->
	 function openDeleteModal(id) {
	        document.getElementById("deleteModal").classList.remove("hidden");
	        document.getElementById("deleteCustomerId").value = id; // set the hidden input value
	    }
	    function closeDeleteModal() {
	        document.getElementById("deleteModal").classList.add("hidden");
	    }

</script>
<style>
@keyframes fade-in-out {
  0%, 100% { opacity: 0; transform: translateY(-10px); }
  10%, 90% { opacity: 1; transform: translateY(0); }
}
.animate-fade-in-out {
  animation: fade-in-out 3s ease forwards;
}
</style>
</body>
</html>
