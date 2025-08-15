<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
		<%@ include file="/components/sidebar.jsp"%>

		<!-- Main Content -->
		<div class="flex-1 flex flex-col overflow-hidden">
			<header
				class="bg-white/10 backdrop-blur-md border-b border-white/20 p-[18px] animate-fade-in">
				<div class="lg:flex items-center justify-between">
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
										<i class="fas fa-id-card mr-2"></i>Account No
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
								<c:forEach var="customer" items="${customers}">
									<tr class="hover:bg-white/5 transition-colors duration-200">
										<td class="px-6 py-4 whitespace-nowrap text-white">${customer.id}</td>
										<td class="px-6 py-4 whitespace-nowrap">
											<div class="flex items-center">
												<div
													class="w-10 h-10 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center mr-3">
													<span class="text-white font-medium text-sm">
														${fn:substring(customer.name,0,1)} </span>
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
											<button
												onclick="openEditModal(${customer.id}, '${customer.name}', '${customer.TP}', '${customer.address}')"
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
						Showing <span class="font-medium text-white">${(currentPage-1) * 10 + 1}</span>
						to <span class="font-medium text-white">${currentPage * 10 > totalCustomers ? totalCustomers : currentPage * 10}</span>
						of <span class="font-medium text-white">${totalCustomers}</span>
						results
					</div>
					<div class="flex items-center space-x-2">
						<c:if test="${currentPage > 1}">
							<a href="CustomerServlet?page=${currentPage - 1}"
								class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
								<i class="fas fa-chevron-left"></i>
							</a>
						</c:if>

						<c:forEach begin="1" end="${totalPages}" var="i">
							<a href="CustomerServlet?page=${i}"
								class="px-4 py-2 ${i == currentPage ? 'bg-gradient-to-r from-pink-500 to-purple-600 text-white' : 'bg-white/10 border border-white/20 text-white hover:bg-white/20'} rounded-lg font-medium">
								${i} </a>
						</c:forEach>

						<c:if test="${currentPage < totalPages}">
							<a href="CustomerServlet?page=${currentPage + 1}"
								class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
								<i class="fas fa-chevron-right"></i>
							</a>
						</c:if>
					</div>
				</div>
				<!-- Modal -->
				<!-- Add Customer Modal -->
				<div id="addCustomerModal"
					class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden">
					<div
						class="bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-800 rounded-2xl w-96 p-6 relative shadow-2xl">
						<h2 class="text-white text-2xl font-bold mb-4">Add Customer</h2>
						<form action="CustomerServlet" method="post">
							<input type="hidden" name="action" value="add">

							<!-- Name -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-user mr-2"></i>Name <span
									class="text-pink-300">*</span>
								</label>
								<div class="relative">
									<input type="text" name="name"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter customer name" required>
									<div
										class="absolute inset-0 rounded-xl bg-gradient-to-r from-pink-400/20 to-purple-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
								</div>
							</div>

							<!-- Contact -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-phone mr-2"></i>Contact <span
									class="text-pink-300">*</span>
								</label>
								<div class="relative">
									<input type="text" name="tp"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter contact number" required>
									<div
										class="absolute inset-0 rounded-xl bg-gradient-to-r from-pink-400/20 to-purple-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
								</div>
							</div>

							<!-- Address -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-map-marker-alt mr-2"></i>Address
								</label>
								<div class="relative">
									<input type="text" name="address"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter address">
									<div
										class="absolute inset-0 rounded-xl bg-gradient-to-r from-pink-400/20 to-purple-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
								</div>
							</div>

							<!-- Buttons -->
							<div class="flex justify-end space-x-3">
								<button type="button" onclick="closeAddModal()"
									class="px-5 py-2 bg-white/10 border border-white/20 text-white rounded-xl hover:bg-white/20 transition-all duration-300">
									Cancel</button>
								<button onclick="validateForm()" type="submit"
									class="px-5 py-2 bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white rounded-xl transition-all duration-300">
									Add</button>
							</div>
						</form>
						<button onclick="closeAddModal()"
							class="absolute top-3 right-3 text-white hover:text-pink-300 text-lg">
							&times;</button>
					</div>
				</div>
				<!-- Edit Customer Modal -->
				<div id="editModal"
					class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden">
					<div
						class="bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-800 rounded-2xl w-96 p-6 relative shadow-2xl">
						<h2 class="text-white text-2xl font-bold mb-4">Edit Customer</h2>
						<form action="CustomerServlet" method="post">
							<input type="hidden" name="action" value="edit"> <input
								type="hidden" id="editId" name="id">

							<!-- Name -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-user mr-2"></i>Name <span
									class="text-pink-300">*</span>
								</label>
								<div class="relative">
									<input type="text" id="editName" name="name" required
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter customer name">
								</div>
							</div>

							<!-- Contact -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-phone mr-2"></i>Contact <span
									class="text-pink-300">*</span>
								</label>
								<div class="relative">
									<input type="text" id="editTP" name="tp" required
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter contact number">
								</div>
							</div>

							<!-- Address -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-map-marker-alt mr-2"></i>Address
								</label>
								<div class="relative">
									<input type="text" id="editAddress" name="address"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-pink-400 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter address">
								</div>
							</div>

							<!-- Buttons -->
							<div class="flex justify-end space-x-3">
								<button type="button" onclick="closeEditModal()"
									class="px-5 py-2 bg-white/10 border border-white/20 text-white rounded-xl hover:bg-white/20 transition-all duration-300">
									Cancel</button>
								<button onclick="validateForm()" type="submit"
									class="px-5 py-2 bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white rounded-xl transition-all duration-300">
									Save</button>
							</div>
						</form>
						<button onclick="closeEditModal()"
							class="absolute top-3 right-3 text-white hover:text-pink-300 text-lg">&times;</button>
					</div>
				</div>

			</main>
		</div>
	</div>
	<script>
	<!-- Modal  -->
	function openAddModal() {
	    document.getElementById('addCustomerModal').classList.remove('hidden');
	}
	function closeAddModal() {
	    document.getElementById('addCustomerModal').classList.add('hidden');
	}

	function openEditModal(id, name, tp, address) { 
	    document.getElementById('editId').value = id;
	    document.getElementById('editName').value = name;
	    document.getElementById('editTP').value = tp;
	    document.getElementById('editAddress').value = address;
	    document.getElementById('editModal').classList.remove('hidden');
	}
	function closeEditModal() {
    document.getElementById('editModal').classList.add('hidden');
    }
	<!-- Delete -->
	function deleteCustomer(id) {
    if (confirm("Are you sure you want to delete this customer?")) {
        var form = document.createElement("form");
        form.method = "post";
        form.action = "CustomerServlet";
        form.innerHTML = '<input type="hidden" name="action" value="delete">' +
                         '<input type="hidden" name="id" value="' + id + '">';
        document.body.appendChild(form);
        form.submit();
    }
    
    <!-- validation -->>
    function validateForm() {
        const name = document.getElementById('name').value.trim();
        const tel = document.getElementById('telephone').value.trim();
        const errorMsg = document.getElementById('errorMsg');
        let errors = [];

        // Name length
        if (name.length === 0) errors.push("Name is required.");
        if (name.length > 100) errors.push("Name cannot exceed 100 characters.");

        // Telephone numeric
        if (!/^\d+$/.test(tel)) errors.push("Telephone number must contain digits only.");
        if (tel.length >= 10) errors.push("Telephone number cannot exceed 10 digits.");

        if (errors.length > 0) {
            errorMsg.innerHTML = errors.join("<br>");
            return false; // prevent form submission
        } else {
            errorMsg.innerHTML = "";
            document.querySelector("form").submit(); // submit if valid
        }
    }
}
</script>

</body>
</html>
