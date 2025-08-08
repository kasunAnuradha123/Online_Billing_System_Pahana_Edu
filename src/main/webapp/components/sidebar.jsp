<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


</head>
<body>

	<aside class="w-64 bg-indigo-900 text-white flex flex-col">
		<div class="p-6 text-2xl font-bold border-b border-indigo-700">
			📚 BookShop Pro</div>
		<nav class="flex-1 p-4 space-y-2">
			<a href="dashboard.jsp"
				class="flex items-center p-3 rounded-lg hover:bg-indigo-700"> <i
				class="fa fa-users mr-3"></i> Dashboard
			</a> <a href="customers.jsp"
				class="flex items-center p-3 rounded-lg hover:bg-indigo-700"> <i
				class="fa fa-users mr-3"></i> Customers
			</a> <a href="billing.jsp"
				class="flex items-center p-3 rounded-lg hover:bg-indigo-700"> <i
				class="fa fa-file-invoice-dollar mr-3"></i> Billing
			</a> <a href="items.jsp"
				class="flex items-center p-3 rounded-lg hover:bg-indigo-700"> <i
				class="fa fa-box mr-3"></i> Items
			</a> <a href="reports.jsp"
				class="flex items-center p-3 rounded-lg hover:bg-indigo-700"> <i
				class="fa fa-chart-line mr-3"></i> Reports
			</a> <a href="settings.jsp"
				class="flex items-center p-3 rounded-lg hover:bg-indigo-700"> <i
				class="fa fa-cog mr-3"></i> Settings
			</a>
		</nav>
		<div class="p-4 border-t border-indigo-700">
			<form action="logout" method="post">
				<button type="submit"
					class="w-full bg-red-600 hover:bg-red-700 p-2 rounded-lg">
					<i class="fa fa-sign-out-alt mr-2"></i> Logout
				</button>
			</form>
		</div>
	</aside>


</body>
</html>