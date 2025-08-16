<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Item</title>
<script src="https://cdn.tailwindcss.com"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body
	class="min-h-screenclass bg-gradient-to-br from-teal-400 to-cyan-600  font-sans">
	<div class="absolute inset-0 overflow-hidden">
		<div
			class="absolute -top-4 -left-4 w-72 h-72 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow"></div>
		<div
			class="absolute top-1/2 -right-4 w-72 h-72 bg-pink-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-2000"></div>
		<div
			class="absolute -bottom-8 left-1/2 w-72 h-72 bg-indigo-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-4000"></div>
	</div>
	<div class="flex h-screen relative z-10">
		<%@ include file="/components/sidebar.jsp"%>

		<div class="flex-1 flex flex-col overflow-hidden">
			<header
				class="bg-white/10 backdrop-blur-md border-b border-white/20 p-[18px] animate-fade-in">
				<div class="lg:flex items-center justify-between">
					<div>
						<h1 class="text-3xl font-bold text-white">Billing Management</h1>
						<p class="text-white/70 text-sm mt-1">Manage your bill</p>
					</div>

				</div>
			</header>

			<main class="flex-1 p-6 overflow-y-auto">
				<%
				String successMessage = (String) session.getAttribute("successMessage");
				if (successMessage != null) {
				%>
				<div
					class="fixed top-4 right-4 max-w-sm w-full bg-green-600 border border-green-400 text-green-100 rounded-lg shadow-lg p-4 flex items-center animate-fade-in-out">
					<i class="fas fa-check-circle mr-3 text-green-200 text-lg"></i> <span
						class="flex-1 text-sm font-medium"><%=successMessage%></span>
					<button onclick="this.parentElement.remove()"
						class="ml-3 text-green-200 hover:text-white font-bold">&times;</button>
				</div>
				<%
				session.removeAttribute("successMessage");
				}
				%>

				<!-- Main Content -->
				<div class="grid grid-cols-1 sm:grid-cols-5 gap-2">
					<div class="col-start-1 sm:col-span-3">
						<div>
							<input type="text" id="searchBox" name="search"
								placeholder="🔍 Search for an item"
								class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-teal-500 focus:outline-none">
						</div>


						<!-- Items Grid -->
						<div class="grid grid-cols-3 gap-6 mt-2">
							<c:forEach var="item" items="${items}">
								<div
									class="bg-white/70 shadow rounded-xl p-4 flex flex-col justify-between h-[150px] item-card"
									data-name="${fn:toLowerCase(item.name)}"
									data-code="${fn:toLowerCase(item.itemCode)}">
									<h3 class="text-lg font-semibold">${item.itemCode}-
										${item.name}</h3>
									<p class="text-black mb-2">Rs. ${item.sellingPrice}</p>

									<!-- Add to Cart form -->
									<form class="text-center">
										<input type="hidden" name="itemId" value="${item.id}">
										<button type="submit"
											class="bg-gradient-to-r from-green-400 to-emerald-500 text-white px-3 py-2 rounded-lg hover:from-green-500 hover:to-emerald-600">
											Add to Cart</button>
									</form>
								</div>
							</c:forEach>

						</div>
						<!-- Pagination -->
						<div
							class="flex items-center justify-between mt-6 text-white/70 text-sm">
							<div>
								Showing <span class="font-medium text-white">${(currentPage-1) * 10 + 1}</span>
								to <span class="font-medium text-white">${currentPage * 10 > totalItems ? totalItems : currentPage * 10}</span>
								of <span class="font-medium text-white">${totalItems}</span>
								results
							</div>
							<div class="flex items-center space-x-2">
								<c:if test="${currentPage > 1}">
									<a href="BillingServlet?page=${currentPage - 1}"
										class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
										<i class="fas fa-chevron-left"></i>
									</a>
								</c:if>
								<c:forEach begin="1" end="${totalPages}" var="i">
									<a href="BillingServlet?page=${i}"
										class="px-4 py-2 ${i == currentPage ? 'bg-gradient-to-br from-teal-100 to-cyan-600 text-white' : 'bg-white/10 border border-white/20 text-white hover:bg-white/20'} rounded-lg font-medium">
										${i} </a>
								</c:forEach>
								<c:if test="${currentPage < totalPages}">
									<a href="BillingServlet?page=${currentPage + 1}"
										class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
										<i class="fas fa-chevron-right"></i>
									</a>
								</c:if>
							</div>
						</div>
					</div>

					<div class="col-start-4 sm:col-span-2">
						<!-- Right Side: Cart -->
						<div class="bg-white/70 shadow-md rounded-xl p-6">
							<h2 class="text-xl font-semibold mb-4">Billing Cart</h2>

							<!-- Customer Selection -->
							<div class="flex space-x-2 mb-4">
								<input type="text" placeholder="Search Customer..."
									class="flex-1 border rounded-lg px-3 py-2 focus:ring-2 focus:ring-cyan-500 focus:outline-none">
								<button
									class="bg-gradient-to-r from-cyan-500 to-teal-500 text-white px-3 py-2 rounded-lg hover:from-cyan-600 hover:to-teal-600">🔍</button>

								<button
									class="bg-gradient-to-r from-cyan-500 to-teal-500 text-white px-3 py-2 rounded-lg hover:from-cyan-600 hover:to-teal-600">Add
									New</button>
							</div>
							<!-- customer details -->

							<!-- Cart Items -->
							<div class="divide-y">
								<div class="flex justify-between items-center py-2">
									<div>
										<p class="font-medium">Casual Shoe</p>
										<p class="text-sm text-gray-500 mt-1">
											Qty: <input type="text" placeholder="Enter qty"
												class="flex-1 border w-24 rounded-lg px-3 py-2 focus:ring-2 focus:ring-cyan-500 focus:outline-none">
										</p>
									</div>
									<p class="font-semibold">$120</p>
								</div>

							</div>



							<!-- Totals -->
							<div class="mt-6 border-t pt-4 space-y-2">
								<div class="flex justify-between">
									<span>Subtotal</span> <span>$200</span>
								</div>
								<div class="flex justify-between">
									<span>Discount</span> <span><input type="text"
										placeholder="Enter discount"
										class="flex-1 border  rounded-lg px-3 py-2 focus:ring-2 focus:ring-cyan-500 focus:outline-none"></span>
								</div>
								<div
									class="flex justify-between text-xl font-bold text-cyan-600">
									<span>Total</span> <span>$220</span>
								</div>
							</div>

							<!-- Checkout Button -->
							<button
								class="mt-6 w-full bg-gradient-to-r from-teal-500 to-cyan-600 text-white px-4 py-3 rounded-lg text-lg font-semibold hover:from-teal-600 hover:to-cyan-700">
								Save & Print</button>
						</div>
					</div>
				</div>

			</main>
			<!-- Modal -->
			<!-- Add Customer Modal -->
			<div id="addCustomerModal"
				class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden">
				<div
					class="bg-gradient-to-br from-teal-400 to-cyan-600  rounded-2xl w-96 p-6 relative shadow-2xl">
					<h2 class="text-white text-2xl font-bold mb-4">Add Customer</h2>
					<c:if test="${not empty errors}">
						<div
							class="mb-4 text-white bg-red-500 text-sm  border border-red-600 rounded-lg p-3">
							<c:forEach var="err" items="${errors}">
								<div>⚠️ ${err}</div>
							</c:forEach>
						</div>
					</c:if>

					<form action="CustomerServlet" method="post">
						<input type="hidden" name="action" value="add">

						<!-- Name -->
						<div class="mb-6">
							<label class="block text-white/90 font-medium mb-2 text-sm">
								<i class="fas fa-user mr-2"></i>Name <span class="text-red-400">*</span>
							</label>
							<div class="relative">
								<input type="text" name="name"
									value="${formName != null ? formName : ''}"
									class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
									placeholder="Enter customer name">
								<div
									class="absolute inset-0 rounded-xl bg-gradient-to-r from-teal-400/20 to-cyan-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
							</div>
						</div>

						<!-- Contact -->
						<div class="mb-6">
							<label class="block text-white/90 font-medium mb-2 text-sm">
								<i class="fas fa-phone mr-2"></i>Contact <span
								class="text-red-400">*</span>
							</label>
							<div class="relative">
								<input type="text" name="tp"
									value="${formTP != null ? formTP : ''}"
									class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
									placeholder="Enter contact number">
								<div
									class="absolute inset-0 rounded-xl bg-gradient-to-r from-teal-400/20 to-cyan-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
							</div>
						</div>

						<!-- Address -->
						<div class="mb-6">
							<label class="block text-white/90 font-medium mb-2 text-sm">
								<i class="fas fa-map-marker-alt mr-2"></i>Address
							</label>
							<div class="relative">
								<input type="text" name="address"
									value="${formAddress != null ? formAddress : ''}"
									class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
									placeholder="Enter address">
								<div
									class="absolute inset-0 rounded-xl bg-gradient-to-r from-teal-400/20 to-cyan-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
							</div>
						</div>

						<!-- Buttons -->
						<div class="flex justify-end space-x-3">
							<button type="button" onclick="closeAddModal()"
								class="px-5 py-2 bg-white/10 border border-white/20 text-white rounded-xl hover:bg-white/20 transition-all duration-300">
								Cancel</button>
							<button type="submit"
								class="px-5 py-2 bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white rounded-xl transition-all duration-300">
								Add</button>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
	<script>
	<!-- Modal  -->
	//item serch filter
	document.getElementById('searchBox').addEventListener('input', function () {
	    let searchValue = this.value.toLowerCase().trim();
	    let items = document.querySelectorAll('.item-card');

	    items.forEach(item => {
	        let name = item.getAttribute('data-name');
	        let code = item.getAttribute('data-code');

	        if (name.includes(searchValue) || code.includes(searchValue)) {
	            item.style.display = 'flex'; // show
	        } else {
	            item.style.display = 'none'; // hide
	        }
	    });
	});
	
		function openAddModal() {
			document.getElementById('addCustomerModal').classList
					.remove('hidden');
		}
		function closeAddModal() {
			document.getElementById('addCustomerModal').classList.add('hidden');
		}
	<%String openModal = (String) request.getAttribute("openModal");%>
		
	<%if ("add".equals(openModal)) {%>
		document.getElementById('addCustomerModal').classList.remove('hidden');
	<%} else if ("edit".equals(openModal)) {%>
		document.getElementById('editModal').classList.remove('hidden');
	<%}%>
		
	</script>


</body>
</html>

