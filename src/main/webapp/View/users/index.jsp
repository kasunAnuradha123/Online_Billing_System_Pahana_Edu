<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Users</title>
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
						<h1 class="text-3xl font-bold text-white">Users Management</h1>
						<p class="text-white/70 text-sm mt-1">Manage your users</p>
					</div>
					<div class="flex items-center space-x-4">
						<!-- Search Bar -->
						<div class="relative">
							<input type="text" id="searchInput"
								class="w-64 p-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm pl-10"
								placeholder="Search users..."> <i
								class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-white/50"></i>
						</div>
						<!-- Add User Button -->
						<button onclick="openAddModal()"
							class="px-6 py-3 bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white font-semibold rounded-xl transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-green-500/25 focus:outline-none focus:ring-2 focus:ring-green-400">
							<i class="fas fa-plus mr-2"></i>Add Users
						</button>
					</div>
				</div>
			</header>

			<main class="flex-1 p-6 overflow-y-auto">
				<!-- User Table -->

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
										<i class="fas fa-id-card mr-2"></i>User name
									</th>
									<th
										class="px-6 py-4 text-left text-sm font-medium text-white/90 uppercase tracking-wider">
										<i class="fas fa-phone mr-2"></i>Role
									</th>

								</tr>
							</thead>
							<tbody id="userTableBody" class="divide-y divide-white/10">
								<c:forEach var="user" items="${users}">
									<tr class="hover:bg-white/5 transition-colors duration-200">
										<td class="px-6 py-4 whitespace-nowrap text-white">${user.id}</td>
										<td class="px-6 py-4 whitespace-nowrap">
											<div class="flex items-center">
												<div
													class="w-10 h-10 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center mr-3">
													<span class="text-white font-medium text-sm">
														${fn:substring(user.name,0,1)} </span>
												</div>
												<div>
													<div class="text-white font-medium">${user.name}</div>
													<div class="text-white/60 text-sm">User</div>
												</div>
											</div>
										</td>
										<td class="px-6 py-4 whitespace-nowrap text-white">${user.username}</td>
										<td class="px-6 py-4 whitespace-nowrap text-white">${user.role}</td>

										<td class="px-6 py-4 whitespace-nowrap text-center">
											<button
												onclick="openEditModal(${user.id}, '${user.name}', '${user.password}', '${user.role}')"
												class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-2 rounded-lg mr-2 transition-colors duration-200">
												<i class="fas fa-edit"></i>
											</button>

											<button type="button" onclick="openDeleteModal(${user.id})"
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
						to <span class="font-medium text-white">${currentPage * 10 > totalUsers ? totalUsers : currentPage * 10}</span>
						of <span class="font-medium text-white">${totalUsers}</span>
						results
					</div>
					<div class="flex items-center space-x-2">
						<c:if test="${currentPage > 1}">
							<a href="UserServlet?page=${currentPage - 1}"
								class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
								<i class="fas fa-chevron-left"></i>
							</a>
						</c:if>

						<c:forEach begin="1" end="${totalPages}" var="i">
							<a href="UserServlet?page=${i}"
								class="px-4 py-2 ${i == currentPage ? 'bg-gradient-to-br from-teal-100 to-cyan-600 text-white' : 'bg-white/10 border border-white/20 text-white hover:bg-white/20'} rounded-lg font-medium">
								${i} </a>
						</c:forEach>

						<c:if test="${currentPage < totalPages}">
							<a href="UserServlet?page=${currentPage + 1}"
								class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
								<i class="fas fa-chevron-right"></i>
							</a>
						</c:if>
					</div>
				</div>
				<!-- Modal -->
				<!-- Add User Modal -->
				<div id="addUserModal"
					class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden">
					<div
						class="bg-gradient-to-br from-teal-400 to-cyan-600  rounded-2xl  max-w-xl w-full  p-6 relative shadow-2xl">
						<h2 class="text-white text-2xl font-bold mb-4">Add User</h2>
						<c:if test="${not empty errors}">
							<div
								class="mb-4 text-white bg-red-500 text-sm  border border-red-600 rounded-lg p-3">
								<c:forEach var="err" items="${errors}">
									<div>⚠️ ${err}</div>
								</c:forEach>
							</div>
						</c:if>

						<form action="UserServlet" method="post">
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
										placeholder="Enter user name">
									<div
										class="absolute inset-0 rounded-xl bg-gradient-to-r from-teal-400/20 to-cyan-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
								</div>
							</div>

							<!-- password -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-phone mr-2"></i>Password <span
									class="text-red-400">*</span>
								</label>
								<div class="relative">
									<input type="text" name="password"
										value="${formPw != null ? formPw : ''}"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter passsword number">
									<div
										class="absolute inset-0 rounded-xl bg-gradient-to-r from-teal-400/20 to-cyan-400/20 opacity-0 transition-opacity duration-300 pointer-events-none focus-within:opacity-100"></div>
								</div>
							</div>

							<!-- Role -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-map-marker-alt mr-2"></i>Role
								</label>
								<div class="relative">
									<select name="role"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 
               focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent 
               transition-all duration-300 backdrop-blur-sm">
										<option
											class="text-black bg-gradient-to-br from-teal-400 to-cyan-600"
											value="">Select Role</option>
										<option
											class="text-black bg-gradient-to-br from-teal-400 to-cyan-600"
											value="admin" ${formRole == 'admin' ? 'selected' : ''}>Admin</option>
										<option
											class="text-black bg-gradient-to-br from-teal-400 to-cyan-600"
											value="staff" ${formRole == 'staff' ? 'selected' : ''}>Staff</option>
									</select>

									<div
										class="absolute inset-0 rounded-xl bg-gradient-to-r from-teal-400/20 to-cyan-400/20 
                opacity-0 transition-opacity duration-300 pointer-events-none 
                focus-within:opacity-100"></div>
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
				<!-- Edit User Modal -->
				<div id="editModal"
					class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 hidden">
					<div
						class="bg-gradient-to-br from-teal-400 to-cyan-600  rounded-2xl max-w-xl w-full p-6 relative shadow-2xl">
						<h2 class="text-white text-2xl font-bold mb-4">Edit User</h2>
						<c:if test="${not empty errors}">
							<div
								class="mb-4 text-white bg-red-500 text-sm  border border-red-600 rounded-lg p-3 ">
								<c:forEach var="err" items="${errors}">
									<div>⚠️ ${err}</div>
								</c:forEach>
							</div>
						</c:if>

						<form action="UserServlet" method="post">
							<input type="hidden" name="action" value="edit"> <input
								type="hidden" id="editId" name="id"
								value="${editId != null ? editId : ''}">

							<!-- Name -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-user mr-2"></i>Name <span class="text-red-400">*</span>
								</label>
								<div class="relative">
									<input type="text" id="editName" name="name" name="name"
										value="${formName != null ? formName : ''}"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter user name">
								</div>
							</div>

							<!-- Password -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-phone mr-2"></i>Password <span
									class="text-red-400">*</span>
								</label>
								<div class="relative">
									<input type="text" id="editPw" name="pw"
										value="${formPw != null ? formPw : ''}"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm"
										placeholder="Enter password number">
								</div>
							</div>

							<!-- Role -->
							<div class="mb-6">
								<label class="block text-white/90 font-medium mb-2 text-sm">
									<i class="fas fa-map-marker-alt mr-2"></i>Role
								</label>
								<div class="relative">
									<select id="editRole" name="role"
										class="w-full p-4 bg-white/5 border border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-cyan-600 focus:border-transparent transition-all duration-300 backdrop-blur-sm">

										<option class="text-black " value="">-- Select Role
											--</option>
										<option class="text-black " value="admin"
											${formRole == 'admin' ? 'selected' : ''}>Admin</option>

										<option class="text-black " value="staff"
											${formRole == 'staff' ? 'selected' : ''}>Staff</option>

									</select>
								</div>
							</div>


							<!-- Buttons -->
							<div class="flex justify-end space-x-3">
								<button type="button" onclick="closeEditModal()"
									class="px-5 py-2 bg-white/10 border border-white/20 text-white rounded-xl hover:bg-white/20 transition-all duration-300">
									Cancel</button>
								<button type="submit"
									class="px-5 py-2 bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white rounded-xl transition-all duration-300">
									Save</button>
							</div>
						</form>

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
							this user?</p>
						<div class="flex justify-end gap-3">
							<button type="button" onclick="closeDeleteModal()"
								class="px-5 py-2 bg-white/10 border border-white/20 text-white rounded-xl hover:bg-white/20 transition-all duration-300">
								Cancel</button>
							<form method="post" action="UserServlet">
								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="id" id="deleteUserId">
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
	function openAddModal() {
	    document.getElementById('addUserModal').classList.remove('hidden');
	}
	function closeAddModal() {
	    document.getElementById('addUserModal').classList.add('hidden');
	}

	function openEditModal(id, name, pw, role) { 
	    document.getElementById('editId').value = id;
	    document.getElementById('editName').value = name;
	    document.getElementById('editPw').value = pw;
	    document.getElementById('editRole').value = role;
	    document.getElementById('editModal').classList.remove('hidden');
	}
	function closeEditModal() {
    document.getElementById('editModal').classList.add('hidden');
    }
	
	<%String openModal = (String) request.getAttribute("openModal");%>
	<%if ("add".equals(openModal)) {%>
	    document.getElementById('addUserModal').classList.remove('hidden');
	<%} else if ("edit".equals(openModal)) {%>
	    document.getElementById('editModal').classList.remove('hidden');
	<%}%>
	<!-- Delete -->
	 function openDeleteModal(id) {
	        document.getElementById("deleteModal").classList.remove("hidden");
	        document.getElementById("deleteUserId").value = id; // set the hidden input value
	    }
	    function closeDeleteModal() {
	        document.getElementById("deleteModal").classList.add("hidden");
	    }

</script>
	<style>
@
keyframes fade-in-out { 0%, 100% {
	opacity: 0;
	transform: translateY(-10px);
}

10






%
,
90






%
{
opacity






:






1




;
transform






:






translateY




(






0






)




;
}
}
.animate-fade-in-out {
	animation: fade-in-out 3s ease forwards;
}
</style>



</body>
</html>
